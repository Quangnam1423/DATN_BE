package com.DATN.Bej.listener;

import com.DATN.Bej.dto.ApiNotificationRequest;
import com.DATN.Bej.enums.NotificationType;
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
import java.util.stream.Collectors;

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
     * Tự động gửi thông báo cho user, admin và staff
     */
    @Async
    @EventListener
    public void handleOrderCreatedEvent(OrderCreatedEvent event) {
        log.info("🛒 Handling OrderCreatedEvent - Order: {}, User: {}, Type: {}", 
                event.orderId(), event.userId(), event.orderType());
        
        try {
            String orderTypeName = event.orderType() == 0 ? "mua bán" : "sửa chữa";
            
            // Tạo thông báo cho user
            String userTitle = "Đơn hàng đã được tạo";
            String userBody = String.format("Đơn hàng #%s (%s) đã được tạo thành công với tổng giá trị: %.0f VNĐ", 
                    event.orderId(), orderTypeName, event.totalPrice());
            
            ApiNotificationRequest userNotificationRequest = new ApiNotificationRequest(
                NotificationType.ORDER_PLACED,
                userTitle,
                userBody,
                Map.of("orderId", event.orderId(), 
                       "orderType", String.valueOf(event.orderType()))
            );
            
            // Gửi thông báo cho user
            notificationService.createAndSendPersonalNotification(
                event.userId(),
                userNotificationRequest
            );
            
            // Tạo thông báo cho admin và staff
            String adminTitle = "Đơn hàng mới";
            String adminBody = String.format("Có đơn hàng #%s (%s) mới được tạo với tổng giá trị: %.0f VNĐ", 
                    event.orderId(), orderTypeName, event.totalPrice());
            
            ApiNotificationRequest adminNotificationRequest = new ApiNotificationRequest(
                NotificationType.ORDER_PLACED,
                adminTitle,
                adminBody,
                Map.of("orderId", event.orderId(), 
                       "orderType", String.valueOf(event.orderType()),
                       "userId", event.userId())
            );
            
            // Lấy danh sách admin và staff
            List<String> adminAndStaffIds = userRepository.findDistinctByRoles_NameIn(List.of("ADMIN"))
                    .stream()
                    .map(user -> user.getId())
                    .collect(Collectors.toList());
            
            // Gửi thông báo cho admin và staff
            if (!adminAndStaffIds.isEmpty()) {
                notificationService.sendNotificationsToMultipleUsers(adminAndStaffIds, adminNotificationRequest);
                log.info("✅ Order created notification sent to {} admin/staff users", adminAndStaffIds.size());
            }
            
            log.info("✅ Order created notification sent to user: {}", event.userId());
        } catch (Exception e) {
            log.error("❌ Failed to send order created notification - Order: {}, User: {} - {}", 
                    event.orderId(), event.userId(), e.getMessage(), e);
        }
    }

    /**
     * Xử lý sự kiện cập nhật trạng thái đơn hàng
     * Tự động gửi thông báo cho user sở hữu đơn hàng, admin và staff
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
            
            // Lấy danh sách admin và staff
            List<String> adminAndStaffIds = userRepository.findDistinctByRoles_NameIn(List.of("ADMIN"))
                    .stream()
                    .map(user -> user.getId())
                    .collect(Collectors.toList());
            
            // Gửi thông báo cho admin và staff
            if (!adminAndStaffIds.isEmpty()) {
                notificationService.sendNotificationsToMultipleUsers(adminAndStaffIds, notificationRequest);
                log.info("✅ Order status update notification sent to {} admin/staff users", adminAndStaffIds.size());
            }
            
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