package com.DATN.Bej.listener;

import com.DATN.Bej.dto.ApiNotificationRequest;
import com.DATN.Bej.enums.NotificationType;
import com.DATN.Bej.enums.Role;
import com.DATN.Bej.entity.identity.User;
import com.DATN.Bej.event.BroadcastNotificationEvent;
import com.DATN.Bej.event.NotificationSendEvent;
import com.DATN.Bej.event.OrderCreatedEvent;
import com.DATN.Bej.event.OrderStatusUpdateEvent;
import com.DATN.Bej.repository.UserRepository;
import com.DATN.Bej.service.NotificationService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.transaction.event.TransactionPhase;
import org.springframework.transaction.event.TransactionalEventListener;

import java.util.List;
import java.util.Map;

/**
 * Event Listener xử lý các sự kiện thông báo
 * Tự động gửi thông báo qua WebSocket, Firebase và lưu vào database
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class NotificationEventListener {

    private final NotificationService notificationService;
    private final UserRepository userRepository;

    /**
     * Xử lý sự kiện gửi thông báo cá nhân
     * Tự động gửi qua WebSocket, Firebase và lưu vào database
     */
    @Async
    @EventListener
    public void handleNotificationSendEvent(NotificationSendEvent event) {
        log.info("📨 Handling NotificationSendEvent for user: {}", event.userId());
        try {
            notificationService.createAndSendPersonalNotification(
                event.userId(),
                event.request()
            );
            log.info("✅ Notification sent successfully to user: {}", event.userId());
        } catch (Exception e) {
            log.error("❌ Failed to send notification to user: {} - {}", event.userId(), e.getMessage(), e);
        }
    }

    /**
     * Xử lý sự kiện tạo đơn hàng mới
     * Tự động gửi thông báo cho:
     * 1. User tạo đơn hàng (xác nhận đơn đã được tạo)
     * 2. Tất cả admin users (thông báo có đơn hàng mới)
     * 
     * Sử dụng @TransactionalEventListener để đảm bảo chỉ chạy sau khi transaction commit thành công
     */
    @Async
    @TransactionalEventListener(phase = TransactionPhase.AFTER_COMMIT)
    public void handleOrderCreatedEvent(OrderCreatedEvent event) {
        log.info("📦 [EVENT LISTENER] Handling OrderCreatedEvent - Order: {}, User: {}, Type: {}", 
                event.orderId(), event.userId(), event.orderType());
        
        try {
            // 1. Gửi thông báo cho user tạo đơn hàng
            String userTitle = event.orderType() == 0 ? "Đơn hàng đã được tạo" : "Yêu cầu sửa chữa đã được tiếp nhận";
            String userBody = event.orderType() == 0 
                ? String.format("Đơn hàng #%s đã được tạo thành công. Tổng tiền: %,.0f VND", 
                    event.orderId(), event.totalPrice())
                : String.format("Yêu cầu sửa chữa #%s đã được tiếp nhận. Chúng tôi sẽ liên hệ với bạn sớm nhất.", 
                    event.orderId());
            
            ApiNotificationRequest userNotification = new ApiNotificationRequest(
                event.orderType() == 0 ? NotificationType.ORDER_PLACED : NotificationType.REPAIR_REQUEST_RECEIVED,
                userTitle,
                userBody,
                Map.of("orderId", event.orderId(), 
                       "orderType", String.valueOf(event.orderType()),
                       "totalPrice", String.valueOf(event.totalPrice()))
            );
            
            log.info("📨 [EVENT LISTENER] Sending notification to user: {}", event.userId());
            notificationService.createAndSendPersonalNotification(
                event.userId(),
                userNotification
            );
            log.info("✅ [EVENT LISTENER] Order created notification sent to user: {}", event.userId());
            
            // 2. Gửi thông báo cho tất cả admin users
            String adminTitle = event.orderType() == 0 ? "Đơn hàng mới" : "Yêu cầu sửa chữa mới";
            String adminBody = event.orderType() == 0
                ? String.format("Có đơn hàng mới #%s. Tổng tiền: %,.0f VND", 
                    event.orderId(), event.totalPrice())
                : String.format("Có yêu cầu sửa chữa mới #%s cần xử lý", event.orderId());
            
            ApiNotificationRequest adminNotification = new ApiNotificationRequest(
                event.orderType() == 0 ? NotificationType.ORDER_PLACED : NotificationType.REPAIR_REQUEST_RECEIVED,
                adminTitle,
                adminBody,
                Map.of("orderId", event.orderId(), 
                       "orderType", String.valueOf(event.orderType()),
                       "totalPrice", String.valueOf(event.totalPrice()))
            );
            
            // Lấy tất cả admin users và gửi thông báo
            log.info("📨 [EVENT LISTENER] Finding admin users...");
            List<User> adminUsers = userRepository.findAll().stream()
                    .filter(user -> user.getRoles() != null && user.getRoles().contains(Role.ADMIN))
                    .toList();
            
            log.info("📨 [EVENT LISTENER] Found {} admin users, sending notifications...", adminUsers.size());
            for (User admin : adminUsers) {
                try {
                    log.info("📨 [EVENT LISTENER] Sending notification to admin: {} ({})", admin.getId(), admin.getFullName());
                    notificationService.createAndSendPersonalNotification(
                        admin.getId(),
                        adminNotification
                    );
                    log.info("✅ [EVENT LISTENER] Notification sent to admin: {}", admin.getId());
                } catch (Exception e) {
                    log.error("❌ [EVENT LISTENER] Failed to send notification to admin {}: {}", admin.getId(), e.getMessage(), e);
                }
            }
            
            log.info("✅ [EVENT LISTENER] Order created notifications sent to {} admin users", adminUsers.size());
        } catch (Exception e) {
            log.error("❌ [EVENT LISTENER] Failed to send order created notification - Order: {}, User: {} - {}", 
                    event.orderId(), event.userId(), e.getMessage(), e);
            log.error("❌ [EVENT LISTENER] Exception stack trace:", e);
        }
    }
    
    /**
     * Xử lý sự kiện cập nhật trạng thái đơn hàng
     * Tự động gửi thông báo cho user sở hữu đơn hàng
     * Phân biệt đơn mua bán (type=0) và đơn sửa chữa (type=1)
     */
    @Async
    @EventListener
    public void handleOrderStatusUpdateEvent(OrderStatusUpdateEvent event) {
        log.info("📦 [EVENT LISTENER] Handling OrderStatusUpdateEvent - Order: {}, User: {}, Type: {}, Status: {} -> {}", 
                event.orderId(), event.userId(), event.orderType(), event.oldStatus(), event.newStatus());
        
        try {
            // Xác định notification type dựa trên orderType
            NotificationType notificationType = event.orderType() == 0 
                ? NotificationType.ORDER_STATUS_UPDATE  // Đơn mua bán
                : NotificationType.REPAIR_STATUS_UPDATE;  // Đơn sửa chữa
            
            // Tạo thông báo từ event
            String title = event.orderType() == 0 ? "Cập nhật đơn hàng" : "Cập nhật trạng thái sửa chữa";
            String body = event.orderType() == 0
                ? String.format("Đơn hàng #%s đã được cập nhật: %s", event.orderId(), event.statusName())
                : String.format("Yêu cầu sửa chữa #%s đã được cập nhật: %s", event.orderId(), event.statusName());
            
            if (event.note() != null && !event.note().isEmpty()) {
                body += " - " + event.note();
            }
            
            ApiNotificationRequest notificationRequest = new ApiNotificationRequest(
                notificationType,
                title,
                body,
                Map.of("orderId", event.orderId(), 
                       "orderType", String.valueOf(event.orderType()),
                       "oldStatus", String.valueOf(event.oldStatus()),
                       "newStatus", String.valueOf(event.newStatus()))
            );
            
            log.info("📨 [EVENT LISTENER] Sending {} notification to user: {}", notificationType, event.userId());
            // Gửi thông báo cho user
            notificationService.createAndSendPersonalNotification(
                event.userId(),
                notificationRequest
            );
            
            log.info("✅ [EVENT LISTENER] Order status update notification sent to user: {}", event.userId());
        } catch (Exception e) {
            log.error("❌ [EVENT LISTENER] Failed to send order status update notification - Order: {}, User: {} - {}", 
                    event.orderId(), event.userId(), e.getMessage(), e);
            log.error("❌ [EVENT LISTENER] Exception stack trace:", e);
        }
    }

    /**
     * Xử lý sự kiện broadcast thông báo
     * Gửi thông báo cho tất cả users trong hệ thống
     */
    @Async
    @EventListener
    public void handleBroadcastNotificationEvent(BroadcastNotificationEvent event) {
        log.info("📢 Handling BroadcastNotificationEvent - Title: {}", event.request().title());
        
        try {
            notificationService.sendBroadcast(event.request());
            log.info("✅ Broadcast notification sent successfully");
        } catch (Exception e) {
            log.error("❌ Failed to send broadcast notification - {}", e.getMessage(), e);
        }
    }
}