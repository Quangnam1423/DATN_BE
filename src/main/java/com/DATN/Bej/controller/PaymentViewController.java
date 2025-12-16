package com.DATN.Bej.controller;

import com.DATN.Bej.dto.response.payment.PaymentCallbackResponse;
import com.DATN.Bej.service.payment.VNPayService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Controller xử lý view (HTML) cho payment callback
 * Tách riêng để tránh conflict với PaymentController (REST API)
 */
@Slf4j
@Controller
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequestMapping("/payment")
public class PaymentViewController {
    
    VNPayService vnPayService;
    
    /**
     * GET /payment/callback
     * Callback từ VNPay sau khi thanh toán (user redirect về)
     * Cập nhật trạng thái đơn hàng và hiển thị trang kết quả cho user
     * 
     * @param request HttpServletRequest chứa các tham số từ VNPay
     * @param redirectUrl URL để redirect về frontend (optional, query param: ?redirectUrl=...)
     * @param format Format response: "html" (mặc định) hoặc "json" (optional)
     * @param model Model để truyền data vào view
     * @return Tên view template (ordersuccess.html hoặc orderfail.html) hoặc redirect
     * 
     * VNPay sẽ redirect user về URL này với các tham số:
     * - vnp_TransactionStatus: "00" = thành công
     * - vnp_OrderInfo: "Thanh toan don hang {orderId}"
     * - vnp_TransactionNo: mã giao dịch
     * - vnp_PayDate: thời gian thanh toán
     * - vnp_Amount: số tiền (đã nhân 100)
     * - vnp_SecureHash: chữ ký để verify
     * 
     * Flow đơn giản cho Frontend:
     * 1. Frontend gọi POST /payment/create với orderId
     * 2. Frontend redirect user đến paymentUrl từ response
     * 3. User thanh toán trên VNPay
     * 4. VNPay tự động redirect về /payment/callback
     * 5. Backend xử lý và hiển thị kết quả (HTML page)
     * 6. User chỉ cần xem kết quả, không cần làm gì thêm
     * 
     * Optional: 
     * - Frontend có thể truyền redirectUrl trong query param:
     *   /payment/callback?redirectUrl=https://your-frontend.com/orders/{orderId}
     *   Sau khi hiển thị kết quả, sẽ tự động redirect về frontend sau 5 giây
     * 
     * - Nếu redirectUrl được truyền và format=json, sẽ redirect ngay lập tức về frontend
     *   với query params chứa kết quả: ?orderId=...&status=success&transactionId=...
     * 
     * Note: 
     * - Đây là callback cho user, hiển thị trang HTML (mặc định)
     * - IPN callback (server-to-server) ở endpoint /ipn để cập nhật status
     * - User KHÔNG CẦN làm gì, chỉ cần xem kết quả trên trang này
     * - Frontend có thể dùng GET /payment/status/{orderId} để check status nếu cần
     */
    @GetMapping("/callback")
    String paymentCallback(
            HttpServletRequest request, 
            @RequestParam(required = false) String redirectUrl,
            @RequestParam(required = false, defaultValue = "html") String format,
            Model model) {
        log.info("📞 Payment callback received from VNPay (user redirect)");
        
        PaymentCallbackResponse callbackResponse = vnPayService.handlePaymentCallback(request);
        
        // Format số tiền (từ VND sang định dạng có dấu phẩy)
        String formattedAmount = String.format("%,.0f", callbackResponse.getAmount()) + " VND";
        
        // Format thời gian thanh toán (từ yyyyMMddHHmmss sang dd/MM/yyyy HH:mm:ss)
        String formattedPaymentTime = formatPaymentTime(callbackResponse.getPaymentTime());
        
        // Truyền data vào model
        model.addAttribute("orderId", callbackResponse.getOrderId());
        model.addAttribute("totalPrice", formattedAmount);
        model.addAttribute("paymentTime", formattedPaymentTime);
        model.addAttribute("transactionId", callbackResponse.getTransactionId());
        
        // Nếu có redirectUrl và format=json, redirect ngay về frontend với query params
        if (redirectUrl != null && !redirectUrl.isEmpty() && "json".equalsIgnoreCase(format)) {
            String separator = redirectUrl.contains("?") ? "&" : "?";
            String redirectWithParams = redirectUrl + separator + 
                "orderId=" + callbackResponse.getOrderId() +
                "&status=" + (callbackResponse.isSuccess() ? "success" : "failed") +
                "&transactionId=" + (callbackResponse.getTransactionId() != null ? callbackResponse.getTransactionId() : "") +
                "&amount=" + callbackResponse.getAmount();
            
            log.info("🔄 Redirecting to frontend: {}", redirectWithParams);
            // Redirect về frontend với thông tin kết quả
            return "redirect:" + redirectWithParams;
        }
        
        // Nếu có redirectUrl, truyền vào model để auto redirect sau 5 giây
        if (redirectUrl != null && !redirectUrl.isEmpty()) {
            model.addAttribute("redirectUrl", redirectUrl);
        }
        
        if (callbackResponse.isSuccess()) {
            log.info("✅ Payment successful - Order: {}, Transaction: {}", 
                    callbackResponse.getOrderId(), callbackResponse.getTransactionId());
            return "ordersuccess";
        } else {
            log.warn("❌ Payment failed - Order: {}, Status: {}", 
                    callbackResponse.getOrderId(), callbackResponse.getPaymentStatus());
            model.addAttribute("errorMessage", callbackResponse.getMessage());
            return "orderfail";
        }
    }
    
    /**
     * Format payment time từ yyyyMMddHHmmss sang dd/MM/yyyy HH:mm:ss
     */
    private String formatPaymentTime(String paymentTime) {
        if (paymentTime == null || paymentTime.length() != 14) {
            return paymentTime;
        }
        try {
            // yyyyMMddHHmmss -> dd/MM/yyyy HH:mm:ss
            String year = paymentTime.substring(0, 4);
            String month = paymentTime.substring(4, 6);
            String day = paymentTime.substring(6, 8);
            String hour = paymentTime.substring(8, 10);
            String minute = paymentTime.substring(10, 12);
            String second = paymentTime.substring(12, 14);
            return day + "/" + month + "/" + year + " " + hour + ":" + minute + ":" + second;
        } catch (Exception e) {
            return paymentTime;
        }
    }
}

