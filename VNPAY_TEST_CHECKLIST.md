# ✅ Checklist Test Thanh Toán VNPay

## 📋 Chuẩn bị Test

### 1. Cấu hình Environment Variables (.env)
```bash
# VNPay Configuration (Sandbox)
VNPAY_PAY_URL=https://sandbox.vnpayment.vn/paymentv2/vpcpay.html
VNPAY_RETURN_URL=http://localhost:8080/bej3/payment/callback
VNPAY_IPN_URL=http://localhost:8080/bej3/payment/ipn
VNPAY_TMN_CODE=IMYHPI42
VNPAY_HASH_SECRET=DZTC8YYQSNX480PAPOD4JB6ZOOUQR3FI
```

**Lưu ý:**
- Nếu test trên mobile/remote: Thay `localhost` bằng IP public hoặc domain
- Có thể dùng ngrok để expose localhost: `ngrok http 8080`
- Sau đó cập nhật `VNPAY_RETURN_URL` và `VNPAY_IPN_URL` với ngrok URL

### 2. Thẻ Test VNPay Sandbox
```
Ngân hàng: NCB
Số thẻ: 9704198526191432198
Tên chủ thẻ: NGUYEN VAN A
Ngày phát hành: 07/15
Mật khẩu OTP: 123456
```

---

## 🧪 Test Cases

### Test Case 1: Tạo Payment URL ✅

**Endpoint:** `POST /bej3/payment/create`

**Request:**
```json
{
  "orderId": "your-order-id"
}
```

**Expected Response:**
```json
{
  "code": 1000,
  "result": {
    "orderId": "your-order-id",
    "paymentUrl": "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html?...",
    "qrCodeUrl": "...",
    "transactionRef": "12345678",
    "amount": 30990000,
    "message": "Payment URL created successfully"
  }
}
```

**Kiểm tra:**
- [ ] Response có `paymentUrl` hợp lệ
- [ ] `amount` khớp với `totalPrice` của order
- [ ] `transactionRef` được tạo thành công
- [ ] URL chứa đầy đủ tham số VNPay

**Edge Cases:**
- [ ] Order không tồn tại → Error 404
- [ ] Order đã thanh toán (status = 2 hoặc 5) → Error
- [ ] Order có totalPrice <= 0 → Error

---

### Test Case 2: Thanh toán thành công ✅

**Flow:**
1. Gọi `POST /payment/create` với orderId hợp lệ
2. Copy `paymentUrl` từ response
3. Mở `paymentUrl` trong browser
4. Thanh toán với thẻ test:
   - Số thẻ: `9704198526191432198`
   - Tên: `NGUYEN VAN A`
   - Ngày: `07/15`
   - OTP: `123456`
5. VNPay redirect về `/payment/callback`

**Expected Result:**
- [ ] Redirect về `/payment/callback` với các query params từ VNPay
- [ ] Backend hiển thị trang `ordersuccess.html`
- [ ] Trang hiển thị:
  - ✅ "Thanh toán thành công!"
  - Mã đơn hàng
  - Tổng tiền (đã format)
  - Thời gian thanh toán (đã format)
  - Mã giao dịch
- [ ] Order status được cập nhật thành `2` (Đã thanh toán)
- [ ] Log backend hiển thị: `✅ Payment successful`

**Kiểm tra Database:**
```sql
SELECT id, status, totalPrice FROM Orders WHERE id = 'your-order-id';
-- Expected: status = 2
```

---

### Test Case 3: Thanh toán thất bại ❌

**Flow:**
1. Gọi `POST /payment/create`
2. Mở `paymentUrl` trong browser
3. Trên trang VNPay, click "Hủy" hoặc để hết thời gian

**Expected Result:**
- [ ] VNPay redirect về `/payment/callback` với `vnp_TransactionStatus != "00"`
- [ ] Backend hiển thị trang `orderfail.html`
- [ ] Trang hiển thị:
  - ❌ "Thanh toán thất bại"
  - Thông báo lỗi
  - Thông tin đơn hàng
- [ ] Order status được cập nhật thành `3` (Thanh toán thất bại)
- [ ] Log backend hiển thị: `❌ Payment failed`

---

### Test Case 4: IPN Callback (Server-to-Server) 🔄

**Endpoint:** `POST /bej3/payment/ipn`

**Cấu hình:**
1. Đăng nhập VNPay Merchant Admin: https://sandbox.vnpayment.vn/merchantv2/
2. Cấu hình IPN URL: `http://your-backend-url/bej3/payment/ipn`
3. VNPay sẽ tự động gọi endpoint này sau khi thanh toán

**Expected Result:**
- [ ] VNPay gọi IPN endpoint tự động
- [ ] Backend xử lý và cập nhật order status
- [ ] Response trả về JSON với kết quả
- [ ] Log backend hiển thị: `✅ IPN: Payment successful`

**Test Manual (nếu cần):**
```bash
curl -X POST "http://localhost:8080/bej3/payment/ipn" \
  -d "vnp_Amount=3099000000&vnp_BankCode=NCB&vnp_TransactionStatus=00&..."
```

---

### Test Case 5: Check Payment Status 📊

**Endpoint:** `GET /bej3/payment/status/{orderId}`

**Request:**
```bash
GET /bej3/payment/status/your-order-id
```

**Expected Response:**
```json
{
  "code": 1000,
  "result": {
    "orderId": "your-order-id",
    "orderStatus": 2,
    "statusName": "Đã thanh toán",
    "isPaid": true,
    "totalPrice": 30990000,
    "message": "Order has been paid"
  }
}
```

**Kiểm tra:**
- [ ] `isPaid = true` nếu status = 2 hoặc 5
- [ ] `isPaid = false` nếu status khác
- [ ] `statusName` hiển thị đúng tiếng Việt

---

### Test Case 6: Callback với Redirect URL 🔄

**Flow:**
1. Tạo payment URL với returnUrl có query param:
   ```
   VNPAY_RETURN_URL=http://localhost:8080/bej3/payment/callback?redirectUrl=https://your-frontend.com/orders/{orderId}
   ```
2. Thanh toán thành công
3. Backend redirect về frontend với query params

**Expected Result:**
- [ ] Sau khi hiển thị kết quả, tự động redirect về frontend sau 5 giây
- [ ] Hoặc nếu `format=json`, redirect ngay với query params:
  ```
  https://your-frontend.com/orders/order-123?orderId=order-123&status=success&transactionId=...
  ```

---

## 🔍 Kiểm tra Logic

### ✅ Logic đã được kiểm tra:

1. **Signature Verification:**
   - [x] Backend verify signature từ VNPay
   - [x] Nếu signature không hợp lệ, không cập nhật order

2. **Order Status Update:**
   - [x] Status = 2 nếu thanh toán thành công (`vnp_TransactionStatus = "00"`)
   - [x] Status = 3 nếu thanh toán thất bại
   - [x] Không cập nhật nếu signature không hợp lệ

3. **Amount Handling:**
   - [x] VNPay gửi amount đã nhân 100, backend chia lại
   - [x] Format hiển thị có dấu phẩy

4. **Order ID Extraction:**
   - [x] Extract từ `vnp_OrderInfo` (format: "Thanh toan don hang {orderId}")
   - [x] Handle edge case nếu format khác

5. **Error Handling:**
   - [x] Order không tồn tại → Exception
   - [x] Order đã thanh toán → Exception
   - [x] Invalid signature → Không cập nhật, trả về error

---

## 🐛 Potential Issues & Fixes

### Issue 1: Callback URL không accessible từ VNPay
**Fix:** 
- Dùng ngrok: `ngrok http 8080`
- Hoặc deploy lên server có public IP
- Cập nhật `VNPAY_RETURN_URL` và `VNPAY_IPN_URL`

### Issue 2: Signature verification fail
**Check:**
- [ ] `VNPAY_HASH_SECRET` đúng với VNPay config
- [ ] `VNPAY_TMN_CODE` đúng
- [ ] URL encoding đúng format

### Issue 3: Order status không cập nhật
**Check:**
- [ ] Transaction có `@Transactional`
- [ ] Database connection OK
- [ ] Order tồn tại trong DB

### Issue 4: HTML page không hiển thị
**Check:**
- [ ] Thymeleaf template engine đã config
- [ ] File `ordersuccess.html` và `orderfail.html` tồn tại
- [ ] Model attributes được truyền đúng

---

## 📝 Test Scripts

### Test với cURL:

```bash
# 1. Tạo payment
curl -X POST "http://localhost:8080/bej3/payment/create" \
  -H "Content-Type: application/json" \
  -d '{"orderId": "your-order-id"}'

# 2. Check status
curl "http://localhost:8080/bej3/payment/status/your-order-id"

# 3. Test IPN (simulate)
curl -X POST "http://localhost:8080/bej3/payment/ipn" \
  -d "vnp_Amount=3099000000&vnp_TransactionStatus=00&..."
```

---

## ✅ Kết luận

**Logic đã được kiểm tra và sẵn sàng test:**
- ✅ API endpoints đầy đủ
- ✅ Callback handling đúng
- ✅ Error handling tốt
- ✅ Security config đúng (public cho callback, có thể thêm auth cho create)
- ✅ HTML pages responsive
- ✅ Database update logic đúng

**Cần test thực tế với VNPay Sandbox để verify end-to-end flow.**


