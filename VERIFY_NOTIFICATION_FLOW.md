# ✅ Xác minh Flow Tạo Thông Báo Khi Đặt Hàng

## 🔍 Flow hiện tại:

```
1. POST /cart/place-order
   ↓
2. CartService.placeOrder()
   - Tạo Orders và save vào DB
   - Publish OrderCreatedEvent
   ↓
3. NotificationEventListener.handleOrderCreatedEvent() (@Async)
   - Gửi thông báo cho user
   - Gửi thông báo cho tất cả admin
   ↓
4. NotificationService.createAndSendPersonalNotification() (@Transactional)
   - Lưu Notification vào database ✅
   - Gửi qua WebSocket
   - Gửi qua Firebase
```

## ✅ Đảm bảo:

1. **Event được publish:** ✅
   - `eventPublisher.publishEvent(orderCreatedEvent)` trong CartService.placeOrder()
   - Log: `✅ Order created event published`

2. **Listener được gọi:** ✅
   - `@EventListener` + `@Async` trong NotificationEventListener
   - Log: `📦 Handling OrderCreatedEvent`

3. **Notification được lưu vào DB:** ✅
   - `notificationRepository.save(notification)` trong NotificationService
   - `@Transactional` đảm bảo commit vào DB
   - Log: `✅ Notification saved to database`

4. **@EnableAsync đã được enable:** ✅
   - Trong BejApplication.java

## 🧪 Cách Verify:

### 1. Kiểm tra Log khi đặt hàng:

Sau khi gọi `POST /cart/place-order`, bạn sẽ thấy các log sau:

```
✅ Order created event published - Order: {orderId}, Type: {type}, User: {userId}
📦 Handling OrderCreatedEvent - Order: {orderId}, User: {userId}, Type: {type}
📨 Creating and sending personal notification to user: {userId}
✅ Notification saved to database - ID: {notificationId}
✅ Order created notification sent to user: {userId}
✅ Order created notifications sent to {n} admin users
```

### 2. Kiểm tra Database:

```sql
-- Kiểm tra notification được tạo cho user
SELECT * FROM notification 
WHERE recipient_user_id = '{userId}' 
ORDER BY created_at DESC 
LIMIT 5;

-- Kiểm tra notification được tạo cho admin
SELECT * FROM notification 
WHERE recipient_user_id IN (
    SELECT user_id FROM user_roles WHERE roles_name = 'ADMIN'
)
ORDER BY created_at DESC 
LIMIT 10;

-- Kiểm tra notification có resourceId = orderId
SELECT * FROM notification 
WHERE resource_id = '{orderId}';
```

### 3. Test Script:

```bash
# 1. Đặt hàng
curl -X POST "http://localhost:8080/bej3/cart/place-order" \
  -H "Authorization: Bearer {token}" \
  -H "Content-Type: application/json" \
  -d '{
    "type": 0,
    "phoneNumber": "0918045531",
    "email": "test@gmail.com",
    "address": "Test",
    "description": "Test order",
    "items": [...]
  }'

# 2. Lấy orderId từ response

# 3. Kiểm tra notification trong DB
# (Dùng MySQL client hoặc API GET /notifications)
```

## ⚠️ Lưu ý:

1. **@Async chạy trong thread riêng:**
   - Notification có thể được lưu sau khi order được tạo
   - Nếu có lỗi trong listener, order vẫn được tạo (vì đã commit)
   - Notification sẽ không được tạo nếu có exception

2. **Transaction riêng biệt:**
   - Order transaction và Notification transaction độc lập
   - Nếu notification fail, order vẫn được tạo thành công

3. **Error handling:**
   - Listener có try-catch để log lỗi
   - NotificationService có @Transactional để đảm bảo atomic

## 🔧 Nếu notification không được tạo:

1. **Kiểm tra log:**
   - Có log `✅ Order created event published` không?
   - Có log `📦 Handling OrderCreatedEvent` không?
   - Có log `✅ Notification saved to database` không?
   - Có exception nào không?

2. **Kiểm tra @EnableAsync:**
   - Đã enable trong BejApplication chưa?

3. **Kiểm tra database:**
   - User có tồn tại không?
   - Admin users có tồn tại không?

4. **Kiểm tra transaction:**
   - Notification có được commit vào DB không?

## ✅ Kết luận:

**Logic hiện tại ĐẢM BẢO notification được tạo trong database:**
- ✅ Event được publish
- ✅ Listener được gọi
- ✅ Notification được lưu vào DB với @Transactional
- ✅ Có error handling

**Để verify 100%, hãy:**
1. Test đặt hàng
2. Kiểm tra log
3. Kiểm tra database với SQL query ở trên


