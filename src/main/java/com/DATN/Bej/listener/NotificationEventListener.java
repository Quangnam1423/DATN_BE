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
     */
    @Async
    @EventListener
    public void handleOrderCreatedEvent(OrderCreatedEvent event) {
        log.info("📦 Handling OrderCreatedEvent - Order: {}, User: {}, Type: {}", 
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
            
            notificationService.createAndSendPersonalNotification(
                event.userId(),
                userNotification
            );
            log.info("✅ Order created notification sent to user: {}", event.userId());
            
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
            List<User> adminUsers = userRepository.findAll().stream()
                    .filter(user -> user.getRoles() != null && user.getRoles().contains(Role.ADMIN))
                    .toList();
            
            for (User admin : adminUsers) {
                notificationService.createAndSendPersonalNotification(
                    admin.getId(),
                    adminNotification
                );
            }
            
            log.info("✅ Order created notifications sent to {} admin users", adminUsers.size());
        } catch (Exception e) {
            log.error("❌ Failed to send order created notification - Order: {}, User: {} - {}", 
                    event.orderId(), event.userId(), e.getMessage(), e);
        }
    }
    
    /**
     * Xử lý sự kiện cập nhật trạng thái đơn hàng
     * Tự động gửi thông báo cho user sở hữu đơn hàng
     */
    @Async
    @EventListener
    public void handleOrderStatusUpdateEvent(OrderStatusUpdateEvent event) {
        log.info("📦 Handling OrderStatusUpdateEvent - Order: {}, User: {}, Status: {} -> {}", 
                event.orderId(), event.userId(), event.oldStatus(), event.newStatus());
        
        try {
            // Tạo thông báo từ event
            String title = "Cập nhật đơn hàng";
            String body = String.format("Đơn hàng #%s đã được cập nhật: %s", 
                    event.orderId(), event.statusName());
            
            if (event.note() != null && !event.note().isEmpty()) {
                body += " - " + event.note();
            }
            
            ApiNotificationRequest notificationRequest = new ApiNotificationRequest(
                NotificationType.ORDER_STATUS_UPDATE,
                title,
                body,
                Map.of("orderId", event.orderId(), 
                       "oldStatus", String.valueOf(event.oldStatus()),
                       "newStatus", String.valueOf(event.newStatus()))
            );
            
            // Gửi thông báo cho user
            notificationService.createAndSendPersonalNotification(
                event.userId(),
                notificationRequest
            );
            
            log.info("✅ Order status update notification sent to user: {}", event.userId());
        } catch (Exception e) {
            log.error("❌ Failed to send order status update notification - Order: {}, User: {} - {}", 
                    event.orderId(), event.userId(), e.getMessage(), e);
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