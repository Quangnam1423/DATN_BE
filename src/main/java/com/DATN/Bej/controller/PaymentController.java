package com.DATN.Bej.controller;

import com.DATN.Bej.dto.request.ApiResponse;
import com.DATN.Bej.dto.request.payment.PaymentRequest;
import com.DATN.Bej.dto.response.payment.PaymentCallbackResponse;
import com.DATN.Bej.dto.response.payment.PaymentResponse;
import com.DATN.Bej.service.payment.VNPayService;
import com.DATN.Bej.service.payment.ZaloPayService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
     * GET /payment/zalopay/return
     * Return callback từ ZaloPay sau khi thanh toán (user redirect về)
     * ZaloPay sẽ redirect user về URL này bằng GET với query params chứa kết quả
     * 
     * Flow:
     * 1. User thanh toán trên ZaloPay
     * 2. ZaloPay redirect user về đây (GET) với query params
     * 3. Backend parse query params và trả về JSON
     * 4. Frontend có thể dùng GET /payment/status/{orderId} để check status chi tiết
     * 
     * Lưu ý: 
     * - Việc cập nhật DB đã được xử lý bởi server-to-server callback (POST /payment/zalopay/callback)
     * - Endpoint này chỉ để frontend biết kết quả và có thể redirect về trang kết quả
     * 
     * @param request HttpServletRequest chứa query params từ ZaloPay
     * @param redirectUrl URL để redirect về frontend (optional, query param: ?redirectUrl=...)
     * @return JSON response với thông tin kết quả thanh toán
     */
    @GetMapping("/zalopay/return")
    public ResponseEntity<?> zaloPayReturn(
            HttpServletRequest request,
            @RequestParam(required = false) String redirectUrl) {
        log.info("📞 ZaloPay return callback received (user redirect)");
        
        Map<String, Object> returnData = zaloPayService.handleReturnCallback(request);
        
        if (returnData == null) {
            log.warn("❌ Failed to process ZaloPay return callback");
            Map<String, Object> errorResp = new HashMap<>();
            errorResp.put("code", 9999);
            errorResp.put("message", "Failed to process return callback");
            return ResponseEntity.ok(errorResp);
        }
        
        // Nếu có redirectUrl, redirect về frontend với query params
        if (redirectUrl != null && !redirectUrl.isEmpty()) {
            String separator = redirectUrl.contains("?") ? "&" : "?";
            String redirectWithParams = redirectUrl + separator + 
                "appTransId=" + returnData.get("appTransId") +
                "&status=" + returnData.get("status") +
                "&success=" + returnData.get("success") +
                "&amount=" + returnData.get("amount");
            
            log.info("🔄 Redirecting to frontend: {}", redirectWithParams);
            return ResponseEntity.status(HttpStatus.FOUND)
                .header("Location", redirectWithParams)
                .build();
        }
        
        // Trả về JSON để frontend xử lý
        Map<String, Object> response = new HashMap<>();
        response.put("code", 1000);
        response.put("result", returnData);
        response.put("message", "Return callback processed. Please check payment status using GET /payment/status/{orderId}");
        
        return ResponseEntity.ok(response);
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