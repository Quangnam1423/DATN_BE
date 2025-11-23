package com.DATN.Bej.controller;

import com.DATN.Bej.dto.ApiNotificationRequest;
import com.DATN.Bej.dto.request.ApiResponse;
import com.DATN.Bej.entity.Notification;
import com.DATN.Bej.event.BroadcastNotificationEvent;
import com.DATN.Bej.event.NotificationSendEvent;
import com.DATN.Bej.service.NotificationService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/notifications")
@RequiredArgsConstructor 
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true) 
public class NotificationController {

    NotificationService notificationService;
    ApplicationEventPublisher eventPublisher;

    /**
     * API gửi cá nhân (dùng bởi admin/service khác)
     * Yêu cầu: ROLE_ADMIN
     * Sử dụng event để tự động gửi qua WebSocket, Firebase và lưu vào database
     */
    @PostMapping("/user/{userId}")
    @PreAuthorize("hasRole('ADMIN')")
    public ApiResponse<Void> sendToUserById(
            @PathVariable String userId,
            @RequestBody ApiNotificationRequest request) {
        
        log.info("📨 Admin sending notification to user: {}", userId);
        
        // Publish event - EventListener sẽ tự động xử lý
        eventPublisher.publishEvent(new NotificationSendEvent(userId, request));
        
        return ApiResponse.<Void>builder()
                .message("Notification event published for user: " + userId)
                .build();
    }

    /**
     * API gửi broadcast (dùng bởi admin/service khác)
     * Yêu cầu: ROLE_ADMIN
     * Sử dụng event để tự động gửi qua WebSocket, Firebase và lưu vào database cho tất cả users
     */
    @PostMapping("/broadcast")
    @PreAuthorize("hasRole('ADMIN')")
    public ApiResponse<Void> sendBroadcastNotification(@RequestBody ApiNotificationRequest request) {
        log.info("📢 Admin sending broadcast notification - Title: {}", request.title());
        
        // Publish event - EventListener sẽ tự động xử lý
        eventPublisher.publishEvent(new BroadcastNotificationEvent(request));
        
        return ApiResponse.<Void>builder()
                .message("Broadcast notification event published")
                .build();
    }

    /**
     * API lấy LỊCH SỬ (dùng bởi client đã đăng nhập)
     * Trả về ResponseEntity (giống /logout) vì cần check Principal
     */
    @GetMapping("/my-history")
    public ResponseEntity<ApiResponse<List<Notification>>> getMyNotifications(Principal principal) {
        
        // Giống logic check header trong /logout
        if (principal == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(
                ApiResponse.<List<Notification>>builder()
                        .code(1001) // Giả sử 1001 là lỗi "Chưa xác thực"
                        .message("User not authenticated")
                        .build()
            );
        }
        
        String userId = principal.getName();
        List<Notification> history = notificationService.getHistoryForUser(userId);
        
        // Trả về 200 OK với kết quả
        return ResponseEntity.ok(
            ApiResponse.<List<Notification>>builder()
                    .result(history)
                    .build()
        );
    }

    /**
     * API đánh dấu ĐÃ ĐỌC (dùng bởi client đã đăng nhập)
     * Trả về ResponseEntity (giống /logout) vì có nhiều logic fail
     */
    @PutMapping("/{notificationId}/read")
    public ResponseEntity<ApiResponse<Void>> markAsRead(
            @PathVariable String notificationId,
            Principal principal) {
                
        if (principal == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(
                ApiResponse.<Void>builder()
                        .code(1001) 
                        .message("User not authenticated")
                        .build()
            );
        }
        
        try {
            String userId = principal.getName();
            boolean success = notificationService.markAsRead(notificationId, userId);
            
            if (success) {
                // 200 OK
                return ResponseEntity.ok(
                    ApiResponse.<Void>builder()
                            .message("Notification marked as read")
                            .build()
                );
            } else {
                // 404 Not Found
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(
                    ApiResponse.<Void>builder()
                            .code(1004) // Giả sử 1004 là "Not Found"
                            .message("Notification not found")
                            .build()
                );
            }
        } catch (SecurityException e) {
            // 403 Forbidden
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(
                ApiResponse.<Void>builder()
                        .code(1003) // Giả sử 1003 là "Không có quyền"
                        .message(e.getMessage())
                        .build()
            );
        }
    }
}