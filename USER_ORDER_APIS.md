# 📦 API Đặt Đơn và Cập Nhật Đơn Cho User

## 🛒 API Đặt Đơn (Place Order)

### `POST /cart/place-order`
**Mô tả:** User đặt đơn hàng từ giỏ hàng

**Yêu cầu:**
- ✅ Authentication: JWT Token (bắt buộc)
- ✅ User được xác định từ JWT token

**Request Body:**
```json
{
  "type": 0,  // 0 = đơn mua bán, 1 = đơn sửa chữa
  "phoneNumber": "0918045531",
  "email": "user@example.com",
  "address": "123 Main St",
  "description": "Giao hàng nhanh",
  "items": [
    {
      "cartItemId": "cart-item-id-1",
      "productAttId": "product-attribute-id-1",
      "quantity": 2
    }
  ]
}
```

**Response:**
```json
{
  "result": {
    "id": "order-id",
    "type": 0,
    "status": 0,
    "totalPrice": 798000,
    "phoneNumber": "0918045531",
    "email": "user@example.com",
    "address": "123 Main St",
    "description": "Giao hàng nhanh",
    "orderAt": "2024-12-29",
    "items": [...]
  }
}
```

**Logic:**
- Tạo đơn hàng mới từ các items trong giỏ hàng
- Xóa các items đã đặt hàng khỏi giỏ hàng
- Tự động tạo thông báo cho user và admin
- Publish `OrderCreatedEvent` để trigger notifications

**Example:**
```bash
curl -X POST "http://localhost:8080/bej3/cart/place-order" \
  -H "Authorization: Bearer {token}" \
  -H "Content-Type: application/json" \
  -d '{
    "type": 0,
    "phoneNumber": "0918045531",
    "email": "test@gmail.com",
    "address": "Test Address",
    "description": "Test order",
    "items": [
      {
        "cartItemId": "5215ff7e-96f6-4de6-a7d5-5efc6bc4d123",
        "productAttId": "2f6d8da8-0b89-41a1-8401-f14ef3bb3962",
        "quantity": 1
      }
    ]
  }'
```

---

## 🔄 API Cập Nhật Đơn (Update Order)

### ⚠️ Lưu ý quan trọng:
Hiện tại trong hệ thống, **KHÔNG CÓ API cho user cập nhật đơn hàng** sau khi đã đặt. Các API cập nhật đơn chỉ dành cho **Admin**:

### 1. `PUT /manage/orders/{orderId}/items` (Admin Only)
**Mô tả:** Admin cập nhật items của đơn hàng (thêm linh kiện cho đơn sửa chữa)

**Yêu cầu:**
- ✅ Authentication: JWT Token (bắt buộc)
- ✅ Role: ROLE_ADMIN

**Request Body:**
```json
{
  "items": [
    {
      "productAttId": "product-attribute-id",
      "quantity": 1
    }
  ]
}
```

**Logic:**
- Thêm items mới vào đơn hàng
- Cập nhật tổng tiền (totalPrice += giá items mới)
- Tạo OrderNote: "Cập nhật linh kiện sử dụng"

---

### 2. `PUT /manage/orders/{orderId}/status` (Admin Only)
**Mô tả:** Admin cập nhật trạng thái đơn hàng

**Yêu cầu:**
- ✅ Authentication: JWT Token (bắt buộc)
- ✅ Role: ROLE_ADMIN

**Request Body:**
```json
{
  "status": 1,  // 0-5
  "note": "Ghi chú cập nhật (tùy chọn)"
}
```

**Status Codes:**
- `0`: Chờ xử lý
- `1`: Đã xác nhận
- `2`: Đã thanh toán
- `3`: Thanh toán thất bại
- `4`: Đang giao hàng
- `5`: Đã hoàn thành

---

### 3. `PUT /orders/repair-order/{orderId}/confirm` (User)
**Mô tả:** User xác nhận đơn sửa chữa (chỉ cho repair order)

**Yêu cầu:**
- ✅ Authentication: JWT Token (bắt buộc)
- ✅ Chỉ user sở hữu đơn hàng mới có thể xác nhận

**Request:** Không có body

**Response:**
```json
{
  "result": {
    "id": "order-id",
    "status": 1,
    ...
  }
}
```

**Logic:**
- Chỉ áp dụng cho đơn sửa chữa (type = 1)
- Cập nhật status từ 0 (Chờ xử lý) → 1 (Đã xác nhận)

---

## 📋 API Xem Đơn Hàng (View Orders)

### 1. `GET /cart/my-order` hoặc `GET /orders/my-orders`
**Mô tả:** Lấy danh sách tất cả đơn hàng của user hiện tại

**Yêu cầu:**
- ✅ Authentication: JWT Token (bắt buộc)

**Response:**
```json
{
  "result": [
    {
      "id": "order-id-1",
      "type": 0,
      "status": 2,
      "totalPrice": 798000,
      ...
    },
    ...
  ]
}
```

---

### 2. `GET /orders/{orderId}`
**Mô tả:** Lấy chi tiết đơn hàng của user hiện tại

**Yêu cầu:**
- ✅ Authentication: JWT Token (bắt buộc)
- ✅ Chỉ user sở hữu đơn hàng mới có thể xem

**Response:**
```json
{
  "result": {
    "id": "order-id",
    "type": 0,
    "status": 2,
    "totalPrice": 798000,
    "phoneNumber": "0918045531",
    "email": "user@example.com",
    "address": "123 Main St",
    "description": "Giao hàng nhanh",
    "orderAt": "2024-12-29",
    "items": [
      {
        "id": "order-item-id",
        "productAttId": "product-attribute-id",
        "quantity": 2,
        "price": 399000
      }
    ],
    "orderNotes": [...]
  }
}
```

---

## 📝 Tóm Tắt

| API | Method | Endpoint | User/Admin | Mô tả |
|-----|--------|----------|------------|-------|
| Đặt đơn | POST | `/cart/place-order` | User | Đặt đơn hàng từ giỏ hàng |
| Xem danh sách đơn | GET | `/cart/my-order` hoặc `/orders/my-orders` | User | Lấy danh sách đơn hàng của user |
| Xem chi tiết đơn | GET | `/orders/{orderId}` | User | Lấy chi tiết đơn hàng |
| Xác nhận đơn sửa chữa | PUT | `/orders/repair-order/{orderId}/confirm` | User | Xác nhận đơn sửa chữa |
| Cập nhật items đơn | PUT | `/manage/orders/{orderId}/items` | **Admin** | Cập nhật items của đơn hàng |
| Cập nhật status đơn | PUT | `/manage/orders/{orderId}/status` | **Admin** | Cập nhật trạng thái đơn hàng |

---

## ⚠️ Lưu ý

1. **User KHÔNG THỂ cập nhật đơn hàng** sau khi đã đặt (trừ xác nhận đơn sửa chữa)
2. **Chỉ Admin** mới có thể:
   - Cập nhật items của đơn hàng
   - Cập nhật trạng thái đơn hàng
3. **User chỉ có thể:**
   - Đặt đơn hàng mới
   - Xem danh sách và chi tiết đơn hàng của mình
   - Xác nhận đơn sửa chữa (nếu là đơn sửa chữa)

---

## 💡 Gợi ý

Nếu bạn muốn thêm API cho user cập nhật đơn hàng (ví dụ: cập nhật địa chỉ, số điện thoại), bạn có thể:
1. Tạo API mới: `PUT /orders/{orderId}/update-info`
2. Chỉ cho phép cập nhật khi status = 0 (Chờ xử lý)
3. Chỉ cho phép cập nhật các thông tin như: phoneNumber, email, address, description

Bạn có muốn tôi thêm API này không?

