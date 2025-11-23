package com.DATN.Bej.dto.response.payment;

import lombok.*;
import lombok.experimental.FieldDefaults;

/**
 * Response DTO cho thanh toán VNPay
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class PaymentResponse {
    
    String orderId;          // ID đơn hàng
    String paymentUrl;       // URL thanh toán VNPay (để redirect hoặc mở trong WebView)
    String qrCodeUrl;        // URL QR code (nếu VNPay hỗ trợ)
    String qrCodeData;       // Data QR code (base64 hoặc string) để generate QR code
    String transactionRef;   // Mã tham chiếu giao dịch (vnp_TxnRef)
    Long amount;             // Số tiền thanh toán
    String message;          // Thông báo
}

