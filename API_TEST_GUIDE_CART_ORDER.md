# 📖 Hướng dẫn Test API Giỏ Hàng và Đặt Hàng

Dựa trên dữ liệu trong `data.sql`, đây là hướng dẫn chi tiết để test các API.

---

## 🔐 Bước 1: Đăng nhập để lấy JWT Token

### API: `POST /bej3/auth/login`

**Request:**
```json
{
  "phoneNumber": "admin",
  "password": "admin"
}
```

**Hoặc dùng user khác:**
```json
{
  "phoneNumber": "0123123123",
  "password": "test1"
}
```

**Response:**
```json
{
  "code": 1000,
  "result": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "id": "33ff2646-2922-416c-8216-c877201ed659",
      "fullName": "admin",
      "email": "admin@gmail.com",
      "phoneNumber": "admin"
    }
  }
}
```

**Lưu token này để dùng cho các API sau!**

---

## 🛒 Bước 2: Thêm sản phẩm vào giỏ hàng

### API: `POST /bej3/cart/add/{productAttId}`

**Headers:**
```
Authorization: Bearer {your-jwt-token}
```

**Dữ liệu mẫu từ data.sql:**

#### Option 1: Thêm iPhone 17 512GB (Xanh Lam Khói)
```
POST http://localhost:8080/bej3/cart/add/2f6d8da8-0b89-41a1-8401-f14ef3bb3962
```

**Response:**
```json
{
  "code": 1000,
  "result": {
    "id": "cart-item-id-generated",
    "productName": "iPhone 17 256GB - Chính hãng Apple Việt Nam",
    "quantity": 1,
    "price": 30990000,
    "color": "Xanh Lam Khói"
  }
}
```

#### Option 2: Thêm Samsung Galaxy Z Fold7 5G
```
POST http://localhost:8080/bej3/cart/add/b7b7dda1-d5c5-40d9-839e-37dd2cadec9d
```

#### Option 3: Thêm iPhone 17 256GB (Tím Oải Hương)
```
POST http://localhost:8080/bej3/cart/add/c0c5e0c9-6114-4988-bd67-d6520e7e4837
```

#### Option 4: Thêm Pin iPhone 11 Pro Max
```
POST http://localhost:8080/bej3/cart/add/ff42fd0d-0a32-4e84-8f6e-f1c9bd1d6053
```

**Lưu `id` (cartItemId) từ response để dùng cho bước đặt hàng!**

---

## 👀 Bước 3: Xem giỏ hàng

### API: `GET /bej3/cart/view`

**Headers:**
```
Authorization: Bearer {your-jwt-token}
```

**Response:**
```json
{
  "code": 1000,
  "result": [
    {
      "id": "39b0f24b-c944-43f7-b1dc-8e9dc2f0839e",
      "productName": "iPhone 17 256GB - Chính hãng Apple Việt Nam",
      "quantity": 2,
      "price": 30990000,
      "color": "Xanh Lam Khói",
      "productAttId": "2f6d8da8-0b89-41a1-8401-f14ef3bb3962"
    },
    {
      "id": "00829fb6-4bdf-4f14-a333-8ad810d0fdcc",
      "productName": "Samsung Galaxy Z Fold7 5G",
      "quantity": 1,
      "price": 41990000,
      "color": "Xám bạc",
      "productAttId": "b7b7dda1-d5c5-40d9-839e-37dd2cadec9d"
    }
  ]
}
```

**Lưu `id` (cartItemId) và `productAttId` để dùng cho bước đặt hàng!**

---

## 📦 Bước 4: Đặt hàng (Place Order)

### API: `POST /bej3/cart/place-order`

**Headers:**
```
Authorization: Bearer {your-jwt-token}
Content-Type: application/json
```

### Đơn hàng mua bán (type = 0)

**Request:**
```json
{
  "type": 0,
  "phoneNumber": "0918045531",
  "email": "suongthu2003@gmail.com",
  "address": "Hoc vien PTIT",
  "description": "Giao hàng nhanh",
  "items": [
    {
      "cartItemId": "39b0f24b-c944-43f7-b1dc-8e9dc2f0839e",
      "productAttId": "2f6d8da8-0b89-41a1-8401-f14ef3bb3962",
      "quantity": 2
    }
  ]
}
```

**Lưu ý:**
- `cartItemId`: Lấy từ response của `/cart/view` hoặc `/cart/add`
- `productAttId`: Lấy từ response của `/cart/view` hoặc `/cart/add`
- `quantity`: Phải khớp với quantity trong cart item
- `type`: `0` = đơn mua bán, `1` = đơn sửa chữa
- **KHÔNG cần gửi `totalPrice`** - backend tự tính

**Response:**
```json
{
  "code": 1000,
  "result": {
    "id": "order-id-generated",
    "phoneNumber": "0918045531",
    "email": "suongthu2003@gmail.com",
    "address": "Hoc vien PTIT",
    "description": "Giao hàng nhanh",
    "type": 0,
    "status": 0,
    "totalPrice": 61980000,
    "orderAt": "2025-12-29",
    "orderItems": [
      {
        "id": "order-item-id",
        "quantity": 2,
        "price": 30990000
      }
    ]
  }
}
```

---

### Đơn sửa chữa (type = 1)

**Request:**
```json
{
  "type": 1,
  "phoneNumber": "0918045531",
  "email": "suongthu2003@gmail.com",
  "address": "Hoc vien PTIT",
  "description": "iPhone 13 | chai pin, nhanh hết pin",
  "items": []
}
```

**Lưu ý:**
- `type`: `1` = đơn sửa chữa
- `items`: Có thể là `[]` (rỗng) hoặc `null`
- `description`: Mô tả chi tiết vấn đề cần sửa

**Response:**
```json
{
  "code": 1000,
  "result": {
    "id": "order-id-generated",
    "phoneNumber": "0918045531",
    "email": "suongthu2003@gmail.com",
    "address": "Hoc vien PTIT",
    "description": "iPhone 13 | chai pin, nhanh hết pin",
    "type": 1,
    "status": 0,
    "totalPrice": 0,
    "orderAt": "2025-12-29",
    "orderItems": []
  }
}
```

---

## 📋 Danh sách ProductAttribute ID có sẵn (từ data.sql)

### Điện thoại:

| Product | ProductAttribute ID | Giá | Mô tả |
|---------|---------------------|-----|-------|
| iPhone 17 512GB | `2f6d8da8-0b89-41a1-8401-f14ef3bb3962` | 30,990,000 | Xanh Lam Khói |
| iPhone 17 256GB | `c0c5e0c9-6114-4988-bd67-d6520e7e4837` | 24,990,000 | Tím Oải Hương |
| iPhone 17 256GB | `3d038e44-a3d4-48c6-ba45-b94f1d8dce43` | 24,990,000 | Tím Oải Hương |
| Samsung Galaxy Z Fold7 5G | `b7b7dda1-d5c5-40d9-839e-37dd2cadec9d` | 41,990,000 | Xám bạc, 12/512GB |
| Samsung Galaxy Z Flip7 5G | `5dabc04d-f222-4e26-84f9-aa49321e0293` | 25,990,000 | Đỏ San Hô, 12/512GB |
| Samsung Galaxy S25 | `6294ca85-c862-4456-8583-e7bd64de5652` | 17,990,000 | Xám Bạc, 256GB |

### Linh kiện:

| Product | ProductAttribute ID | Giá | Mô tả |
|---------|---------------------|-----|-------|
| Pin iPhone 11 Pro Max | `ff42fd0d-0a32-4e84-8f6e-f1c9bd1d6053` | 1,150,000 | Dung lượng cao |
| Pin iPhone 11 Pro Max | `6baa992a-2960-4668-80b2-8e7299738dbc` | 1,000,000 | Cơ bản |
| Chân sạc iPhone 11 Pro Max | `0256c9b9-93c0-4be6-97fc-6bf0cc568142` | 1,100,000 | - |

---

## 🔄 Flow Test Hoàn Chỉnh

### Scenario 1: Đơn hàng mua bán

```bash
# 1. Đăng nhập
curl -X POST "http://localhost:8080/bej3/auth/login" \
  -H "Content-Type: application/json" \
  -d '{
    "phoneNumber": "admin",
    "password": "admin"
  }'

# Lưu token từ response

# 2. Thêm vào giỏ hàng
curl -X POST "http://localhost:8080/bej3/cart/add/2f6d8da8-0b89-41a1-8401-f14ef3bb3962" \
  -H "Authorization: Bearer {your-token}"

# Lưu cartItemId từ response

# 3. Xem giỏ hàng
curl -X GET "http://localhost:8080/bej3/cart/view" \
  -H "Authorization: Bearer {your-token}"

# 4. Đặt hàng
curl -X POST "http://localhost:8080/bej3/cart/place-order" \
  -H "Authorization: Bearer {your-token}" \
  -H "Content-Type: application/json" \
  -d '{
    "type": 0,
    "phoneNumber": "0918045531",
    "email": "suongthu2003@gmail.com",
    "address": "Hoc vien PTIT",
    "description": "Giao hàng nhanh",
    "items": [
      {
        "cartItemId": "{cartItemId-from-step-2}",
        "productAttId": "2f6d8da8-0b89-41a1-8401-f14ef3bb3962",
        "quantity": 1
      }
    ]
  }'
```

### Scenario 2: Đơn sửa chữa

```bash
# 1. Đăng nhập (dùng token từ scenario 1)

# 2. Đặt đơn sửa chữa (không cần thêm vào giỏ hàng)
curl -X POST "http://localhost:8080/bej3/cart/place-order" \
  -H "Authorization: Bearer {your-token}" \
  -H "Content-Type: application/json" \
  -d '{
    "type": 1,
    "phoneNumber": "0918045531",
    "email": "suongthu2003@gmail.com",
    "address": "Hoc vien PTIT",
    "description": "iPhone 13 | chai pin, nhanh hết pin",
    "items": []
  }'
```

---

## ✅ Checklist Test

- [ ] Đăng nhập thành công và lấy được token
- [ ] Thêm sản phẩm vào giỏ hàng thành công
- [ ] Xem giỏ hàng hiển thị đúng items
- [ ] Đặt đơn mua bán thành công (type = 0)
- [ ] Đặt đơn sửa chữa thành công (type = 1)
- [ ] Nhận được thông báo sau khi đặt đơn (notification)
- [ ] Cart items được xóa sau khi đặt đơn

---

## 🐛 Troubleshooting

### Lỗi "User not existed":
- ✅ Đã sửa - giờ sẽ hiển thị log chi tiết hơn
- Kiểm tra ProductAttribute ID có tồn tại không
- Kiểm tra CartItem ID có tồn tại và thuộc về user không

### Lỗi 404:
- Kiểm tra URL không có khoảng trắng
- Kiểm tra context-path `/bej3`
- Kiểm tra JWT token trong header

### Lỗi 401 Unauthorized:
- Token đã hết hạn → Đăng nhập lại
- Token không hợp lệ → Kiểm tra format `Bearer {token}`

---

## 📝 Ví dụ Request Body đầy đủ

### Đơn mua bán với nhiều items:

```json
{
  "type": 0,
  "phoneNumber": "0918045531",
  "email": "suongthu2003@gmail.com",
  "address": "Hoc vien PTIT",
  "description": "Giao hàng nhanh",
  "items": [
    {
      "cartItemId": "39b0f24b-c944-43f7-b1dc-8e9dc2f0839e",
      "productAttId": "2f6d8da8-0b89-41a1-8401-f14ef3bb3962",
      "quantity": 2
    },
    {
      "cartItemId": "00829fb6-4bdf-4f14-a333-8ad810d0fdcc",
      "productAttId": "b7b7dda1-d5c5-40d9-839e-37dd2cadec9d",
      "quantity": 1
    }
  ]
}
```

**Tổng tiền sẽ được tính tự động:** (30,990,000 × 2) + (41,990,000 × 1) = 103,970,000 VND

---

Chúc bạn test thành công! 🎉


