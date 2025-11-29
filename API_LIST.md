# DANH SÁCH TẤT CẢ CÁC API TRONG DỰ ÁN

## 1. AUTHENTICATION API (`/auth`)

### 1.1. Đăng nhập
- **Endpoint**: `POST /auth/log-in`
- **Mô tả**: Xác thực người dùng và trả về JWT token
- **Request Body**: `AuthenticationRequest`
- **Response**: `ApiResponse<AuthenticationResponse>`

### 1.2. Kiểm tra token
- **Endpoint**: `POST /auth/introspect`
- **Mô tả**: Kiểm tra tính hợp lệ của JWT token
- **Request Body**: `IntrospectRequest`
- **Response**: `ApiResponse<IntrospectResponse>`

### 1.3. Đăng xuất
- **Endpoint**: `POST /auth/logout`
- **Mô tả**: Đăng xuất người dùng và xóa FCM tokens
- **Headers**: `Authorization: Bearer <token>`
- **Response**: `ResponseEntity<ApiResponse<Void>>`

---

## 2. USER API (`/users`)

### 2.1. Tạo người dùng mới
- **Endpoint**: `POST /users/create`
- **Mô tả**: Tạo tài khoản người dùng mới
- **Request Body**: `UserCreationRequest` (validated)
- **Response**: `ApiResponse<UserResponse>`

### 2.2. Lấy thông tin cá nhân
- **Endpoint**: `GET /users/profile/my-info`
- **Mô tả**: Lấy thông tin của người dùng hiện tại
- **Response**: `ApiResponse<UserResponse>`

### 2.3. Cập nhật thông tin cá nhân
- **Endpoint**: `PUT /users/profile/my-info/update`
- **Mô tả**: Cập nhật thông tin của người dùng hiện tại
- **Request Body**: `UserUpdateRequest`
- **Response**: `ApiResponse<UserResponse>`

---

## 3. USER MANAGEMENT API (`/users/manage`)

### 3.1. Lấy danh sách tất cả người dùng
- **Endpoint**: `GET /users/manage`
- **Mô tả**: Lấy danh sách tất cả người dùng (quản lý)
- **Response**: `ApiResponse<List<UserResponse>>`

### 3.2. Lấy thông tin người dùng theo ID
- **Endpoint**: `GET /users/manage/{userId}`
- **Mô tả**: Lấy thông tin chi tiết của một người dùng
- **Path Variable**: `userId`
- **Response**: `ApiResponse<UserResponse>`

### 3.3. Cập nhật thông tin người dùng
- **Endpoint**: `PUT /users/manage/update/{userId}`
- **Mô tả**: Cập nhật thông tin của một người dùng
- **Path Variable**: `userId`
- **Request Body**: `UserUpdateRequest`
- **Response**: `ApiResponse<UserResponse>`

---

## 4. ROLE API (`/admin/roles`)

### 4.1. Tạo role mới
- **Endpoint**: `POST /admin/roles`
- **Mô tả**: Tạo một role mới trong hệ thống
- **Request Body**: `RoleRequest`
- **Response**: `ApiResponse<RoleResponse>`

### 4.2. Lấy danh sách tất cả roles
- **Endpoint**: `GET /admin/roles`
- **Mô tả**: Lấy danh sách tất cả roles
- **Response**: `ApiResponse<List<RoleResponse>>`

### 4.3. Xóa role
- **Endpoint**: `DELETE /admin/roles/{role}`
- **Mô tả**: Xóa một role khỏi hệ thống
- **Path Variable**: `role`
- **Response**: `ApiResponse<Void>`

---

## 5. PERMISSION API (`/admin/permissions`)

### 5.1. Tạo permission mới
- **Endpoint**: `POST /admin/permissions`
- **Mô tả**: Tạo một permission mới trong hệ thống
- **Request Body**: `PermissionRequest`
- **Response**: `ApiResponse<PermissionResponse>`

### 5.2. Lấy danh sách tất cả permissions
- **Endpoint**: `GET /admin/permissions`
- **Mô tả**: Lấy danh sách tất cả permissions
- **Response**: `ApiResponse<List<PermissionResponse>>`

### 5.3. Xóa permission
- **Endpoint**: `DELETE /admin/permissions/{permission}`
- **Mô tả**: Xóa một permission khỏi hệ thống
- **Path Variable**: `permission`
- **Response**: `ApiResponse<Void>`

---

## 6. PRODUCT API (`/home`)

### 6.1. Lấy danh sách sản phẩm
- **Endpoint**: `GET /home`
- **Mô tả**: Lấy danh sách tất cả sản phẩm (cho khách hàng)
- **Response**: `ApiResponse<List<ProductListResponse>>`

### 6.2. Lấy chi tiết sản phẩm
- **Endpoint**: `GET /home/product/{productId}`
- **Mô tả**: Lấy thông tin chi tiết của một sản phẩm
- **Path Variable**: `productId`
- **Response**: `ApiResponse<ProductDetailRes>`

---

## 7. PRODUCT MANAGEMENT API (`/manage/product`)

### 7.1. Lấy danh sách tất cả sản phẩm (quản lý)
- **Endpoint**: `GET /manage/product/list`
- **Mô tả**: Lấy danh sách tất cả sản phẩm cho quản trị viên
- **Response**: `ApiResponse<List<ProductListResponse>>`

### 7.2. Lấy chi tiết sản phẩm (quản lý)
- **Endpoint**: `GET /manage/product/{productId}`
- **Mô tả**: Lấy thông tin chi tiết sản phẩm cho quản trị viên
- **Path Variable**: `productId`
- **Response**: `ApiResponse<ProductResponse>`

### 7.3. Thêm sản phẩm mới
- **Endpoint**: `POST /manage/product/add`
- **Mô tả**: Thêm sản phẩm mới vào hệ thống
- **Request Body**: `ProductRequest` (multipart/form-data, validated)
- **Response**: `ApiResponse<ProductResponse>`

### 7.4. Cập nhật sản phẩm
- **Endpoint**: `PUT /manage/product/update/{productId}`
- **Mô tả**: Cập nhật thông tin sản phẩm
- **Path Variable**: `productId`
- **Request Body**: `ProductRequest` (multipart/form-data)
- **Response**: `ApiResponse<ProductResponse>`

### 7.5. Xóa sản phẩm
- **Endpoint**: `DELETE /manage/product/delete/{productId}`
- **Mô tả**: Xóa sản phẩm khỏi hệ thống
- **Path Variable**: `productId`
- **Response**: `ApiResponse<Void>`

### 7.6. Vô hiệu hóa sản phẩm
- **Endpoint**: `PUT /manage/product/inactive/{productId}`
- **Mô tả**: Vô hiệu hóa sản phẩm (không xóa)
- **Path Variable**: `productId`
- **Response**: `ApiResponse<Void>`

---

## 8. CATEGORY MANAGEMENT API (`/admin/category`)

### 8.1. Lấy danh sách tất cả danh mục
- **Endpoint**: `GET /admin/category`
- **Mô tả**: Lấy danh sách tất cả danh mục sản phẩm
- **Response**: `ApiResponse<List<CategoryResponse>>`

### 8.2. Thêm danh mục mới
- **Endpoint**: `POST /admin/category/add`
- **Mô tả**: Thêm danh mục sản phẩm mới
- **Request Body**: `CategoryRequest` (multipart/form-data, validated)
- **Response**: `ApiResponse<CategoryResponse>`

---

## 9. CART API (`/cart`)

### 9.1. Thêm sản phẩm vào giỏ hàng
- **Endpoint**: `POST /cart/add/{attId}`
- **Mô tả**: Thêm sản phẩm (attribute) vào giỏ hàng
- **Path Variable**: `attId` (attribute ID)
- **Response**: `ApiResponse<CartItemResponse>`

### 9.2. Xem giỏ hàng
- **Endpoint**: `GET /cart/view`
- **Mô tả**: Lấy danh sách các sản phẩm trong giỏ hàng
- **Response**: `ApiResponse<List<CartItemResponse>>`

### 9.3. Đặt hàng
- **Endpoint**: `POST /cart/place-order`
- **Mô tả**: Đặt hàng từ giỏ hàng
- **Request Body**: `OrderRequest`
- **Response**: `ApiResponse<OrderDetailsResponse>`
- **Note**: Transactional

### 9.4. Lấy danh sách đơn hàng của tôi
- **Endpoint**: `GET /cart/my-order`
- **Mô tả**: Lấy danh sách đơn hàng của người dùng hiện tại
- **Response**: `ApiResponse<List<OrderDetailsResponse>>`

---

## 10. ORDER MANAGEMENT API (`/manage/orders`)

### 10.1. Lấy danh sách tất cả đơn hàng
- **Endpoint**: `GET /manage/orders/get-all`
- **Mô tả**: Lấy danh sách tất cả đơn hàng (quản lý)
- **Response**: `ApiResponse<List<OrdersResponse>>`

### 10.2. Lấy chi tiết đơn hàng
- **Endpoint**: `GET /manage/orders/details/{orderId}`
- **Mô tả**: Lấy thông tin chi tiết của một đơn hàng
- **Path Variable**: `orderId`
- **Response**: `ApiResponse<OrderDetailsResponse>`

---

## 11. SCHEDULE MANAGEMENT API (`/manage/schedule`)

### 11.1. Lấy lịch làm việc theo tháng
- **Endpoint**: `POST /manage/schedule/monthly`
- **Mô tả**: Lấy lịch làm việc theo tháng
- **Request Body**: `ScheduleGetRequest`
- **Response**: `ApiResponse<List<ScheduleResponse>>`

### 11.2. Thêm lịch làm việc
- **Endpoint**: `POST /manage/schedule`
- **Mô tả**: Thêm lịch làm việc mới
- **Request Body**: `ScheduleAddRequest`
- **Response**: `ApiResponse<ScheduleResponse>`

### 11.3. Thêm ca làm việc
- **Endpoint**: `POST /manage/schedule/shift`
- **Mô tả**: Thêm ca làm việc mới
- **Request Body**: `ShiftRequest`
- **Response**: `ApiResponse<ShiftResponse>`

### 11.4. Lấy danh sách ca làm việc
- **Endpoint**: `GET /manage/schedule/shifts`
- **Mô tả**: Lấy danh sách tất cả ca làm việc
- **Response**: `ApiResponse<List<ShiftResponse>>`

---

## 12. FCM DEVICE TOKEN API (`/api/device-token`)

### 12.1. Đăng ký FCM token
- **Endpoint**: `POST /api/device-token/register`
- **Mô tả**: Đăng ký FCM token cho thiết bị để nhận push notification
- **Request Body**: `RegisterFcmTokenRequest`
- **Response**: `ApiResponse<FcmTokenResponse>`

### 12.2. Xóa FCM token
- **Endpoint**: `DELETE /api/device-token/{tokenId}`
- **Mô tả**: Xóa một FCM token cụ thể
- **Path Variable**: `tokenId`
- **Response**: `ApiResponse<Void>`

### 12.3. Xóa tất cả FCM tokens
- **Endpoint**: `DELETE /api/device-token/all`
- **Mô tả**: Xóa tất cả FCM tokens của người dùng (khi logout)
- **Response**: `ApiResponse<Void>`

### 12.4. Gửi test notification (yêu cầu authentication)
- **Endpoint**: `POST /api/device-token/send-notification`
- **Mô tả**: Gửi push notification test đến một thiết bị cụ thể
- **Request Body**: `SendPushNotificationRequest`
- **Response**: `ApiResponse<SendPushNotificationResponse>`

### 12.5. Gửi test notification (PUBLIC - không cần authentication)
- **Endpoint**: `POST /api/device-token/test-send-notification`
- **Mô tả**: Gửi push notification test (public, dùng để test)
- **Request Body**: `SendPushNotificationRequest`
- **Response**: `ApiResponse<SendPushNotificationResponse>`

---

## 13. NOTIFICATION API (`/api/notifications`)

### 13.1. Gửi notification cho user cụ thể
- **Endpoint**: `POST /api/notifications/user/{userId}`
- **Mô tả**: Gửi notification cá nhân cho một user (dùng bởi admin/service khác)
- **Path Variable**: `userId`
- **Request Body**: `ApiNotificationRequest`
- **Response**: `ApiResponse<Void>`

### 13.2. Gửi broadcast notification
- **Endpoint**: `POST /api/notifications/broadcast`
- **Mô tả**: Gửi notification broadcast cho tất cả users (dùng bởi admin/service khác)
- **Request Body**: `ApiNotificationRequest`
- **Response**: `ApiResponse<Void>`

### 13.3. Lấy lịch sử notification của tôi
- **Endpoint**: `GET /api/notifications/my-history`
- **Mô tả**: Lấy lịch sử notifications của người dùng hiện tại
- **Response**: `ResponseEntity<ApiResponse<List<Notification>>>`

### 13.4. Đánh dấu notification đã đọc
- **Endpoint**: `PUT /api/notifications/{notificationId}/read`
- **Mô tả**: Đánh dấu một notification là đã đọc
- **Path Variable**: `notificationId`
- **Response**: `ResponseEntity<ApiResponse<Void>>`

---

## 14. PAYMENT API (`/payment`)

### 14.1. Trang chủ thanh toán
- **Endpoint**: `GET /payment/home`
- **Mô tả**: Trang chủ thanh toán (trả về HTML template)
- **Response**: `String` (HTML template: index.html)

### 14.2. Tạo đơn hàng thanh toán VNPay
- **Endpoint**: `POST /payment/submitOrder`
- **Mô tả**: Tạo đơn hàng và chuyển hướng đến VNPay
- **Request Parameters**: 
  - `amount`: Tổng tiền đơn hàng
  - `orderInfo`: Thông tin đơn hàng
- **Response**: `String` (redirect URL đến VNPay)

### 14.3. Callback từ VNPay
- **Endpoint**: `GET /payment/vnpay-payment`
- **Mô tả**: Nhận callback từ VNPay sau khi thanh toán
- **Request Parameters**: Các tham số từ VNPay (vnp_OrderInfo, vnp_PayDate, vnp_TransactionNo, vnp_Amount)
- **Response**: `String` (HTML template: ordersuccess.html hoặc orderfail.html)

---

## TỔNG KẾT

### Số lượng API theo nhóm:
- **Authentication**: 3 APIs
- **User Management**: 6 APIs (3 user + 3 manage)
- **Role & Permission**: 6 APIs (3 role + 3 permission)
- **Product**: 8 APIs (2 public + 6 manage)
- **Category**: 2 APIs
- **Cart & Order**: 6 APIs (4 cart + 2 order manage)
- **Schedule**: 4 APIs
- **FCM/Notification**: 9 APIs (5 FCM + 4 notification)
- **Payment**: 3 APIs

### **Tổng cộng: 47 APIs**

---

## LƯU Ý

1. **Authentication**: Hầu hết các API yêu cầu JWT token trong header `Authorization: Bearer <token>`
2. **Response Format**: Tất cả API trả về dạng `ApiResponse<T>` hoặc `ResponseEntity<ApiResponse<T>>`
3. **File Upload**: Các API thêm/cập nhật Product và Category sử dụng `multipart/form-data` với `@ModelAttribute`
4. **Public APIs**: 
   - `POST /api/device-token/test-send-notification` (không cần authentication)
   - `GET /home` và `GET /home/product/{productId}` (có thể public tùy cấu hình)
5. **Payment**: Sử dụng VNPay integration với callback mechanism



