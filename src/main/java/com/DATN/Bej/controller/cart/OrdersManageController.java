package com.DATN.Bej.controller.cart;

import com.DATN.Bej.dto.request.ApiResponse;
import com.DATN.Bej.dto.request.order.UpdateOrderStatusRequest;
import com.DATN.Bej.dto.response.cart.OrderDetailsResponse;
import com.DATN.Bej.dto.response.cart.OrdersResponse;
import com.DATN.Bej.dto.response.order.OrderStatusUpdateResponse;
import com.DATN.Bej.service.guest.CartService;
import com.DATN.Bej.service.order.OrderService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Controller quản lý đơn hàng cho Admin
 * Tất cả endpoints yêu cầu ROLE_ADMIN
 */
@Slf4j
@RestController
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequestMapping("/manage/orders")
public class OrdersManageController {

    CartService cartService;
    OrderService orderService;

    /**
     * GET /manage/orders/get-all
     * Lấy danh sách tất cả đơn hàng (Admin only)
     * Yêu cầu: ROLE_ADMIN
     */
    @GetMapping("/get-all")
    @PreAuthorize("hasRole('ADMIN')")
    ApiResponse<List<OrdersResponse>> getAllOrders(){
        log.info("📦 Admin getting all orders");
        return ApiResponse.<List<OrdersResponse>>builder()
                .result(cartService.getAllOrders())
                .build();
    }

    /**
     * GET /manage/orders/details/{orderId}
     * Lấy chi tiết đơn hàng (Admin only)
     * Yêu cầu: ROLE_ADMIN
     */
    @GetMapping("/details/{orderId}")
    @PreAuthorize("hasRole('ADMIN')")
    ApiResponse<OrderDetailsResponse> getOrderDetails(@PathVariable String orderId){
        log.info("📦 Admin getting order details - ID: {}", orderId);
        return ApiResponse.<OrderDetailsResponse>builder()
                .result(cartService.getOrderDetails(orderId))
                .build();
    }
    
    /**
     * PUT /manage/orders/{orderId}/status
     * Cập nhật trạng thái đơn hàng (Admin only)
     * Cập nhật real-time qua WebSocket
     * Yêu cầu: ROLE_ADMIN
     * 
     * @param orderId ID đơn hàng
     * @param request UpdateOrderStatusRequest chứa status mới
     * @return OrderStatusUpdateResponse với thông tin cập nhật
     * 
     * Status codes:
     * - 0: Chờ xử lý
     * - 1: Đã xác nhận
     * - 2: Đã thanh toán
     * - 3: Thanh toán thất bại
     * - 4: Đang giao hàng
     * - 5: Đã hoàn thành
     * 
     * WebSocket sẽ broadcast đến:
     * - /topic/orders/{userId}/{orderId} - User sở hữu đơn hàng
     * - /topic/orders/admin - Admin dashboard
     */
    @PutMapping("/{orderId}/status")
    @PreAuthorize("hasRole('ADMIN')")
    ApiResponse<OrderStatusUpdateResponse> updateOrderStatus(
            @PathVariable String orderId,
            @RequestBody @Valid UpdateOrderStatusRequest request) {
        log.info("📦 Admin updating order status - Order: {}, Status: {}", orderId, request.getStatus());
        
        OrderStatusUpdateResponse result = orderService.updateOrderStatus(orderId, request);
        
        log.info("✅ Order status updated - Order: {}, Status: {} -> {}", 
                orderId, result.getOldStatus(), result.getNewStatus());
        
        return ApiResponse.<OrderStatusUpdateResponse>builder()
                .result(result)
                .build();
    }
}
