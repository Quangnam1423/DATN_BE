package com.DATN.Bej.controller;

import com.DATN.Bej.dto.request.ApiResponse;
import com.DATN.Bej.dto.request.payment.PaymentRequest;
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
     * 
     * @param request PaymentRequest chứa orderId, amount, orderInfo
     * @param httpRequest HttpServletRequest để lấy IP và base URL
     * @return PaymentResponse chứa paymentUrl, qrCodeUrl, transactionRef
     * 
     * Response sẽ chứa:
     * - paymentUrl: URL để redirect đến trang thanh toán VNPay
     * - qrCodeUrl: URL QR code (nếu VNPay hỗ trợ)
     * - transactionRef: Mã tham chiếu giao dịch
     * 
     * Example:
     * POST /payment/create
     * {
     *   "orderId": "order-123",
     *   "amount": 27990000,
     *   "orderInfo": "Thanh toan don hang order-123"
     * }
     */
    @PostMapping("/create")
    ApiResponse<PaymentResponse> createPayment(
            @RequestBody @Valid PaymentRequest request,
            HttpServletRequest httpRequest) {
        log.info("💳 Creating payment for order: {}, amount: {}", request.getOrderId(), request.getAmount());
        
        PaymentResponse paymentResponse = vnPayService.createPayment(
                request.getOrderId(),
                request.getAmount(),
                request.getOrderInfo(),
                httpRequest
        );
        
        log.info("✅ Payment URL created - TransactionRef: {}", paymentResponse.getTransactionRef());
        return ApiResponse.<PaymentResponse>builder()
                .result(paymentResponse)
                .build();
    }
    
    /**
     * GET /payment/callback
     * Callback từ VNPay sau khi thanh toán
     * Cập nhật trạng thái đơn hàng dựa trên kết quả thanh toán
     * 
     * @param request HttpServletRequest chứa các tham số từ VNPay
     * @return PaymentCallbackResponse với thông tin kết quả thanh toán
     * 
     * VNPay sẽ redirect về URL này với các tham số:
     * - vnp_TransactionStatus: "00" = thành công
     * - vnp_OrderInfo: orderId
     * - vnp_TransactionNo: mã giao dịch
     * - vnp_PayDate: thời gian thanh toán
     * - vnp_Amount: số tiền
     */
    @GetMapping("/callback")
    ApiResponse<PaymentCallbackResponse> paymentCallback(HttpServletRequest request) {
        log.info("📞 Payment callback received from VNPay");
        
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
    
}