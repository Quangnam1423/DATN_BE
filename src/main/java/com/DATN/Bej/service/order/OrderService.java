package com.DATN.Bej.service.order;

import com.DATN.Bej.dto.request.cartRequest.OrderItemsUpdateRequest;
import com.DATN.Bej.dto.request.order.UpdateOrderStatusRequest;
import com.DATN.Bej.dto.response.cart.OrderDetailsResponse;
import com.DATN.Bej.dto.response.order.OrderStatusUpdateResponse;
import com.DATN.Bej.entity.cart.OrderItem;
import com.DATN.Bej.entity.cart.OrderNote;
import com.DATN.Bej.entity.cart.Orders;
import com.DATN.Bej.entity.identity.User;
import com.DATN.Bej.entity.product.ProductAttribute;
import com.DATN.Bej.event.OrderStatusUpdateEvent;
import com.DATN.Bej.exception.AppException;
import com.DATN.Bej.exception.ErrorCode;
import com.DATN.Bej.mapper.product.OrderMapper;
import com.DATN.Bej.repository.UserRepository;
import com.DATN.Bej.repository.product.OrderRepository;
import com.DATN.Bej.repository.product.ProductAttributeRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Transactional
public class OrderService {
    private final ProductAttributeRepository productAttributeRepository;
    private final UserRepository userRepository;

    OrderMapper orderMapper;

    OrderRepository orderRepository;
    SimpMessagingTemplate messagingTemplate;
    ApplicationEventPublisher eventPublisher;

    /**
     * Cập nhật trạng thái đơn hàng và broadcast qua WebSocket
     * @param orderId ID đơn hàng
     * @param request UpdateOrderStatusRequest chứa status mới
     * @return OrderStatusUpdateResponse
     */
    public OrderStatusUpdateResponse updateOrderStatus(String orderId, UpdateOrderStatusRequest request) {
        log.info("📦 Updating order status - Order: {}, New status: {}", orderId, request.getStatus());
        
        Orders order = orderRepository.findById(orderId)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED));
        var context = SecurityContextHolder.getContext();
        String name = context.getAuthentication().getName();
        User user = userRepository.findByPhoneNumber(name).orElseThrow(
                () -> new AppException(ErrorCode.USER_NOT_EXISTED));;
        
        int oldStatus = order.getStatus();
        int newStatus = request.getStatus();
        
        // Validate status transition (có thể thêm logic phức tạp hơn)
        if (newStatus < 0 || newStatus > 5) {
            throw new AppException(ErrorCode.INVALID_KEY);
        }

        if (request.getNote() != null){
            OrderNote newNote = new OrderNote();
            newNote.setOrder(order);
            newNote.setNote(request.getNote());
            newNote.setUpdateTime(LocalDateTime.now());
            newNote.setUpdateBy(user);
            order.getOrderNotes().add(newNote);
        }
        
        // Cập nhật trạng thái
        order.setStatus(newStatus);
        order.setUpdatedAt(LocalDate.now());
        orderRepository.save(order);
        
        // Tạo response
        OrderStatusUpdateResponse response = OrderStatusUpdateResponse.builder()
                .orderId(orderId)
                .oldStatus(oldStatus)
                .newStatus(newStatus)
                .statusName(getStatusName(newStatus))
                .updatedAt(LocalDate.now())
                .note(request.getNote())
                .message("Order status updated successfully")
                .build();
        
        // Broadcast qua WebSocket đến user sở hữu đơn hàng
        String userId = order.getUser().getId();
        String destination = "/topic/orders/" + userId + "/" + orderId;
        
        Map<String, Object> message = new HashMap<>();
        message.put("type", "ORDER_STATUS_UPDATE");
        message.put("orderId", orderId);
        message.put("oldStatus", oldStatus);
        message.put("newStatus", newStatus);
        message.put("statusName", getStatusName(newStatus));
        message.put("updatedAt", LocalDate.now().toString());
        message.put("note", request.getNote());
        
        messagingTemplate.convertAndSend(destination, message);
        
        // Broadcast đến topic chung cho admin
        messagingTemplate.convertAndSend("/topic/orders/admin", message);
        
        // Publish event để gửi thông báo qua Firebase và lưu vào database
        OrderStatusUpdateEvent statusUpdateEvent = new OrderStatusUpdateEvent(
                orderId,
                userId,
                oldStatus,
                newStatus,
                getStatusName(newStatus),
                request.getNote()
        );
        
        eventPublisher.publishEvent(statusUpdateEvent);
        
        log.info("✅ Order status updated, broadcasted via WebSocket and event published - Order: {}, Status: {} -> {}", 
                orderId, oldStatus, newStatus);
        
        return response;
    }

    public OrderDetailsResponse updateOrderItems(String orderId, OrderItemsUpdateRequest request){
        Orders order = orderRepository.findById(orderId).orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED));
        var context = SecurityContextHolder.getContext();
        String name = context.getAuthentication().getName();
        User user = userRepository.findByPhoneNumber(name).orElseThrow(
                () -> new AppException(ErrorCode.USER_NOT_EXISTED));;

        double price = 0;
        for (var itemReq : request.getItems()){
            ProductAttribute productAtt = productAttributeRepository
                    .findById(itemReq.getProductAttId())
                    .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED));
            OrderItem orderItem = orderMapper.toOrderItem(itemReq);
            orderItem.setProductA(productAtt);
            orderItem.setOrder(order);
            orderItem.setPrice(productAtt.getFinalPrice());
            price += productAtt.getFinalPrice();
            order.getOrderItems().add(orderItem);
        }
        OrderNote newNote = new OrderNote();
        newNote.setOrder(order);
        newNote.setNote("Cập nhật linh kiện sử dụng");
        newNote.setUpdateTime(LocalDateTime.now());
        newNote.setUpdateBy(user);
        order.getOrderNotes().add(newNote);

        order.setUpdatedAt(LocalDate.now());
        double totalPrice = order.getTotalPrice();
        order.setTotalPrice(totalPrice + price);
        return orderMapper.toOrderDetailsResponse(orderRepository.save(order));
    }
    
    /**
     * Lấy tên trạng thái đơn hàng
     */
    private String getStatusName(int status) {
        return switch (status) {
            case 0 -> "Chờ xử lý";
            case 1 -> "Đã xác nhận";
            case 2 -> "Đã thanh toán";
            case 3 -> "Thanh toán thất bại";
            case 4 -> "Đang giao hàng";
            case 5 -> "Đã hoàn thành";
            default -> "Không xác định";
        };
    }
}

