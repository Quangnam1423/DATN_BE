package com.DATN.Bej.controller;

import com.DATN.Bej.dto.request.ApiResponse;
import com.DATN.Bej.dto.request.payment.CreatePaymentRequest;
import com.DATN.Bej.dto.response.payment.PaymentCallbackResponse;
import com.DATN.Bej.dto.response.payment.PaymentResponse;
import com.DATN.Bej.service.payment.VNPayService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequestMapping("/payment")
public class PaymentController {
    
    VNPayService vnPayService;

    /**
     * POST /payment/create
     * Tạo URL thanh toán VNPay cho đơn hàng
     * Backend tự động lấy totalPrice từ Orders, không cần client gửi amount
     * 
     * @param request CreatePaymentRequest chỉ chứa orderId
     * @param httpRequest HttpServletRequest để lấy IP và base URL
     * @return PaymentResponse chứa paymentUrl, qrCodeUrl, transactionRef, amount
     * 
     * Response sẽ chứa:
     * - paymentUrl: URL để redirect đến trang thanh toán VNPay
     * - qrCodeUrl: URL QR code (có thể dùng để generate QR code ở client)
     * - transactionRef: Mã tham chiếu giao dịch
     * - amount: Số tiền thanh toán (tự động lấy từ Orders.totalPrice)
     * 
     * Example:
     * POST /payment/create
     * {
     *   "orderId": "order-123"
     * }
     * 
     * Response:
     * {
     *   "code": 1000,
     *   "result": {
     *     "orderId": "order-123",
     *     "paymentUrl": "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html?...",
     *     "qrCodeUrl": "...",
     *     "transactionRef": "12345678",
     *     "amount": 27990000,
     *     "message": "Payment URL created successfully"
     *   }
     * }
     */
    @PostMapping("/create")
    ApiResponse<PaymentResponse> createPayment(
            @RequestBody @Valid CreatePaymentRequest request,
            HttpServletRequest httpRequest) {
        log.info("💳 Creating payment for order: {}", request.getOrderId());
        
        PaymentResponse paymentResponse = vnPayService.createPayment(
                request.getOrderId(),
                httpRequest
        );
        
        log.info("✅ Payment URL created - Order: {}, Amount: {}, TransactionRef: {}", 
                request.getOrderId(), paymentResponse.getAmount(), paymentResponse.getTransactionRef());
        return ApiResponse.<PaymentResponse>builder()
                .result(paymentResponse)
                .build();
    }
    
    /**
     * GET /payment/callback
     * Callback từ VNPay sau khi thanh toán (user redirect về)
     * Cập nhật trạng thái đơn hàng dựa trên kết quả thanh toán
     * 
     * @param request HttpServletRequest chứa các tham số từ VNPay
     * @return PaymentCallbackResponse với thông tin kết quả thanh toán
     * 
     * VNPay sẽ redirect user về URL này với các tham số:
     * - vnp_TransactionStatus: "00" = thành công
     * - vnp_OrderInfo: "Thanh toan don hang {orderId}"
     * - vnp_TransactionNo: mã giao dịch
     * - vnp_PayDate: thời gian thanh toán
     * - vnp_Amount: số tiền (đã nhân 100)
     * - vnp_SecureHash: chữ ký để verify
     * 
     * Note: Đây là callback cho user, IPN callback (server-to-server) ở endpoint /ipn
     */
    @GetMapping("/callback")
    ApiResponse<PaymentCallbackResponse> paymentCallback(HttpServletRequest request) {
        log.info("📞 Payment callback received from VNPay (user redirect)");
        
        PaymentCallbackResponse callbackResponse = vnPayService.handlePaymentCallback(request);
        
        if (callbackResponse.isSuccess()) {
            log.info("✅ Payment successful - Order: {}, Transaction: {}", 
                    callbackResponse.getOrderId(), callbackResponse.getTransactionId());
        } else {
            log.warn("❌ Payment failed - Order: {}, Status: {}", 
                    callbackResponse.getOrderId(), callbackResponse.getPaymentStatus());
        }
        
        return ApiResponse.<PaymentCallbackResponse>builder()
                .result(callbackResponse)
                .build();
    }
    
    /**
     * POST /payment/ipn
     * IPN (Instant Payment Notification) callback từ VNPay (server-to-server)
     * VNPay sẽ gọi endpoint này tự động để cập nhật trạng thái thanh toán
     * 
     * @param request HttpServletRequest chứa các tham số từ VNPay
     * @return PaymentCallbackResponse với thông tin kết quả thanh toán
     * 
     * VNPay sẽ POST đến URL này với các tham số tương tự như /callback
     * IPN được gọi tự động bởi VNPay server, không phải user redirect
     * 
     * Note: Cần cấu hình IPN URL trong VNPay merchant admin:
     * https://sandbox.vnpayment.vn/merchantv2/
     */
    @PostMapping("/ipn")
    ApiResponse<PaymentCallbackResponse> paymentIPN(HttpServletRequest request) {
        log.info("📞 IPN callback received from VNPay (server-to-server)");
        
        PaymentCallbackResponse callbackResponse = vnPayService.handleIPNCallback(request);
        
        if (callbackResponse.isSuccess()) {
            log.info("✅ IPN: Payment successful - Order: {}, Transaction: {}", 
                    callbackResponse.getOrderId(), callbackResponse.getTransactionId());
        } else {
            log.warn("❌ IPN: Payment failed - Order: {}, Status: {}", 
                    callbackResponse.getOrderId(), callbackResponse.getPaymentStatus());
        }
        
        return ApiResponse.<PaymentCallbackResponse>builder()
                .result(callbackResponse)
                .build();
    }
    
}