package com.DATN.Bej.event;

/**
 * Event được phát ra khi đơn hàng mới được tạo (mua bán hoặc sửa chữa)
 */
public record OrderCreatedEvent(
    String orderId,           // ID đơn hàng
    String userId,            // ID user tạo đơn hàng
    int orderType,            // 0 = mua bán, 1 = sửa chữa
    double totalPrice,        // Tổng tiền
    String description        // Mô tả đơn hàng (optional)
) {}

