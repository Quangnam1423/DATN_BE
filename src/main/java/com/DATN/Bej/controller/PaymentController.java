package com.DATN.Bej.controller;

import com.DATN.Bej.dto.request.ApiResponse;
import com.DATN.Bej.dto.request.payment.CreatePaymentRequest;
import com.DATN.Bej.dto.response.payment.PaymentCallbackResponse;
import com.DATN.Bej.dto.response.payment.PaymentResponse;
import com.DATN.Bej.dto.response.payment.PaymentStatusResponse;
import com.DATN.Bej.entity.cart.Orders;
import com.DATN.Bej.exception.AppException;
import com.DATN.Bej.exception.ErrorCode;
import com.DATN.Bej.repository.product.OrderRepository;
import com.DATN.Bej.service.payment.VNPayService;
import com.DATN.Bej.service.payment.ZaloPayService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@RestController
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequestMapping("/payment")
public class PaymentController {
    
    VNPayService vnPayService;
    ZaloPayService zaloPayService;
    OrderRepository orderRepository;

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
    
    /**
     * POST /payment/zalopay/create
     * Tạo URL thanh toán ZaloPay cho đơn hàng
     * 
     * @param request CreatePaymentRequest chỉ chứa orderId
     * @param httpRequest HttpServletRequest để lấy base URL
     * @return PaymentResponse chứa orderUrl để redirect đến ZaloPay gateway
     * 
     * Example:
     * POST /payment/zalopay/create
     * {
     *   "orderId": "order-123"
     * }
     * 
     * Response:
     * {
     *   "code": 1000,
     *   "result": {
     *     "orderId": "order-123",
     *     "orderUrl": "https://qcgateway.zalopay.vn/openinapp?order=...",
     *     "paymentUrl": "https://qcgateway.zalopay.vn/openinapp?order=...",
     *     "transactionRef": "231217_order-123",
     *     "amount": 27990000,
     *     "message": "Payment URL created successfully"
     *   }
     * }
     */
    @PostMapping("/zalopay/create")
    ApiResponse<PaymentResponse> createZaloPayPayment(
            @RequestBody @Valid CreatePaymentRequest request,
            HttpServletRequest httpRequest) {
        log.info("💳 Creating ZaloPay payment for order: {}", request.getOrderId());
        
        PaymentResponse paymentResponse = zaloPayService.createPayment(
                request.getOrderId(),
                httpRequest
        );
        
        log.info("✅ ZaloPay payment URL created - Order: {}, Amount: {}, OrderUrl: {}", 
                request.getOrderId(), paymentResponse.getAmount(), paymentResponse.getOrderUrl());
        return ApiResponse.<PaymentResponse>builder()
                .result(paymentResponse)
                .build();
    }

    /**
     * POST /payment/zalopay/callback
     * Callback từ ZaloPay (server-to-server) sau khi trừ tiền user thành công
     * ZaloPay sẽ POST JSON với các field: data, mac, type
     *
     * Yêu cầu response:
     * {
     *   "return_code": 1,           // 1 = thành công, 2 = trùng giao dịch, khác = lỗi
     *   "return_message": "success" // mô tả
     * }
     *
     * Lưu ý: Không bọc response trong ApiResponse, trả JSON raw theo format của ZaloPay.
     */
    @PostMapping("/zalopay/callback")
    public Map<String, Object> zaloPayCallback(@RequestBody Map<String, Object> body) {
        log.info("📞 ZaloPay callback received (server-to-server)");

        boolean ok = zaloPayService.handleCallback(body);

        Map<String, Object> resp = new HashMap<>();
        if (ok) {
            resp.put("return_code", 1);
            resp.put("return_message", "success");
        } else {
            resp.put("return_code", -1);
            resp.put("return_message", "error");
        }

        return resp;
    }
    
    /**
     * GET /payment/status/{orderId}
     * Lấy trạng thái thanh toán của đơn hàng
     * Frontend có thể dùng API này để check xem đơn hàng đã thanh toán chưa
     * 
     * @param orderId ID của đơn hàng
     * @return PaymentStatusResponse với thông tin trạng thái thanh toán
     * 
     * Use case:
     * - Sau khi redirect user đến paymentUrl, frontend có thể polling API này
     * - Hoặc sau khi user quay lại từ VNPay, frontend check status để hiển thị kết quả
     * 
     * Example:
     * GET /payment/status/order-123
     * 
     * Response:
     * {
     *   "code": 1000,
     *   "result": {
     *     "orderId": "order-123",
     *     "orderStatus": 2,
     *     "statusName": "Đã thanh toán",
     *     "isPaid": true,
     *     "totalPrice": 30990000,
     *     "message": "Order has been paid"
     *   }
     * }
     */
    @GetMapping("/status/{orderId}")
    ApiResponse<PaymentStatusResponse> getPaymentStatus(@PathVariable String orderId) {
        log.info("📊 Getting payment status for order: {}", orderId);
        
        Orders order = orderRepository.findById(orderId)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED));
        
        boolean isPaid = (order.getStatus() == 2 || order.getStatus() == 5);
        String statusName = getStatusName(order.getStatus());
        String message = isPaid ? "Order has been paid" : "Order payment pending";
        
        PaymentStatusResponse response = PaymentStatusResponse.builder()
                .orderId(orderId)
                .orderStatus(order.getStatus())
                .statusName(statusName)
                .isPaid(isPaid)
                .totalPrice(order.getTotalPrice())
                .message(message)
                .build();
        
        log.info("✅ Payment status retrieved - Order: {}, Status: {}, IsPaid: {}", 
                orderId, order.getStatus(), isPaid);
        
        return ApiResponse.<PaymentStatusResponse>builder()
                .result(response)
                .build();
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