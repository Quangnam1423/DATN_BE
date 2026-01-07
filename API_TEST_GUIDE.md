# Hướng dẫn Test API Place Order

## URL đúng:
```
POST http://localhost:8080/bej3/cart/place-order
```

**Lưu ý:** Không có khoảng trắng trong URL!

## Headers cần thiết:
```
Content-Type: application/json
Authorization: Bearer {your-jwt-token}
```

## Body request:
```json
{
  "type": 0,
  "phoneNumber": "0918045531",
  "email": "suongthu2003@gmail.com",
  "address": "Hoc vien PTIT",
  "description": "Giao hàng nhanh",
  "items": [
    {
      "cartItemId": "5215ff7e-96f6-4de6-a7d5-5efc6bc4d123",
      "productAttId": "6670f5da-7bd5-4e00-ae35-b43bbdff2f5e",
      "quantity": 2
    }
  ]
}
```

## Test với cURL:
```bash
curl -X POST "http://localhost:8080/bej3/cart/place-order" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN_HERE" \
  -d '{
    "type": 0,
    "phoneNumber": "0918045531",
    "email": "suongthu2003@gmail.com",
    "address": "Hoc vien PTIT",
    "description": "Giao hàng nhanh",
    "items": [
      {
        "cartItemId": "5215ff7e-96f6-4de6-a7d5-5efc6bc4d123",
        "productAttId": "6670f5da-7bd5-4e00-ae35-b43bbdff2f5e",
        "quantity": 2
      }
    ]
  }'
```

## Test với Postman:
1. Method: **POST**
2. URL: `http://localhost:8080/bej3/cart/place-order`
3. Headers:
   - `Content-Type`: `application/json`
   - `Authorization`: `Bearer {your-jwt-token}`
4. Body (raw JSON): Copy body request ở trên

## Lấy JWT Token:
Đăng nhập trước để lấy token:
```
POST http://localhost:8080/bej3/auth/login
{
  "phoneNumber": "your-phone",
  "password": "your-password"
}
```

Response sẽ có token trong field `result.token`

## Các lỗi thường gặp:

### 404 Not Found:
- ❌ Kiểm tra URL có khoảng trắng không
- ❌ Kiểm tra context-path `/bej3` có đúng không
- ❌ Kiểm tra server có đang chạy không

### 401 Unauthorized:
- ❌ Thiếu JWT token trong header
- ❌ Token đã hết hạn
- ❌ Token không hợp lệ

### 400 Bad Request:
- ❌ Body request không đúng format
- ❌ Thiếu trường bắt buộc (`type`, `items`)
- ❌ Validation error


