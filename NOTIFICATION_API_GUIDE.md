# 📬 Notification API Guide - Hướng Dẫn Sử Dụng API Thông Báo

## 📋 Mục Lục
1. [Tổng Quan](#tổng-quan)
2. [API Endpoints - User Endpoints](#api-endpoints---user-endpoints)
3. [API Endpoints - Admin Endpoints](#api-endpoints---admin-endpoints)
4. [Nhận Notifications Qua Message Broker (WebSocket/STOMP)](#nhận-notifications-qua-message-broker-websocketstomp)
5. [Ví Dụ Code Frontend](#ví-dụ-code-frontend)
6. [Tự Động Gửi Notification Khi Order Status Update](#tự-động-gửi-notification-khi-order-status-update)

---

## 📌 Tổng Quan

Hệ thống notification hỗ trợ:
- ✅ **REST API**: Lấy danh sách, đếm, đánh dấu đã đọc
- ✅ **Real-time via WebSocket**: Nhận notifications tự động qua RabbitMQ STOMP broker
- ✅ **Firebase Push Notification**: Push notification cho mobile app
- ✅ **Auto Notification**: Tự động gửi khi order status update

**Base URL**: `http://localhost:8080/bej3`

**Authentication**: Tất cả API yêu cầu JWT token trong header:
```
Authorization: Bearer <your-jwt-token>
```

---

## 🔐 API Endpoints - User Endpoints

### 1. Lấy Tất Cả Notifications Của User

**Endpoint**: `GET /api/notifications/my-notifications`

**Mô tả**: Lấy tất cả notifications của user hiện tại (đã đọc và chưa đọc)

**Headers**:
```
Authorization: Bearer <jwt-token>
```

**Response**:
```json
{
  "code": 1000,
  "message": "Success",
  "result": [
    {
      "id": "550e8400-e29b-41d4-a716-446655440000",
      "type": "ORDER_STATUS_UPDATE",
      "title": "Cập nhật đơn hàng",
      "body": "Đơn hàng #123 đã được cập nhật: Đang giao hàng",
      "isRead": false,
      "resourceId": "123",
      "createdAt": "2025-01-15T10:30:00Z"
    },
    {
      "id": "550e8400-e29b-41d4-a716-446655440001",
      "type": "GENERAL_ANNOUNCEMENT",
      "title": "Thông báo hệ thống",
      "body": "Chào mừng bạn đến với hệ thống",
      "isRead": true,
      "resourceId": null,
      "createdAt": "2025-01-14T09:00:00Z"
    }
  ]
}
```

**Ví dụ cURL**:
```bash
curl -X GET "http://localhost:8080/bej3/api/notifications/my-notifications" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

**Ví dụ JavaScript**:
```javascript
const response = await fetch('http://localhost:8080/bej3/api/notifications/my-notifications', {
  method: 'GET',
  headers: {
    'Authorization': `Bearer ${jwtToken}`,
    'Content-Type': 'application/json'
  }
});
const data = await response.json();
console.log('Notifications:', data.result);
```

---

### 2. Đếm Số Notification Chưa Đọc

**Endpoint**: `GET /api/notifications/unread-count`

**Mô tả**: Lấy số lượng notification chưa đọc của user

**Response**:
```json
{
  "code": 1000,
  "message": "Success",
  "result": {
    "unreadCount": 5
  }
}
```

**Ví dụ JavaScript**:
```javascript
const response = await fetch('http://localhost:8080/bej3/api/notifications/unread-count', {
  method: 'GET',
  headers: {
    'Authorization': `Bearer ${jwtToken}`
  }
});
const data = await response.json();
const unreadCount = data.result.unreadCount;
console.log(`Bạn có ${unreadCount} thông báo chưa đọc`);
```

---

### 3. Lấy Danh Sách Notification Chưa Đọc

**Endpoint**: `GET /api/notifications/unread`

**Mô tả**: Lấy danh sách chỉ các notifications chưa đọc

**Response**: Tương tự như `/my-notifications` nhưng chỉ trả về notifications có `isRead: false`

**Ví dụ JavaScript**:
```javascript
const response = await fetch('http://localhost:8080/bej3/api/notifications/unread', {
  method: 'GET',
  headers: {
    'Authorization': `Bearer ${jwtToken}`
  }
});
const data = await response.json();
const unreadNotifications = data.result;
```

---

### 4. Đánh Dấu Một Notification Là Đã Đọc

**Endpoint**: `PUT /api/notifications/{notificationId}/read`

**Mô tả**: Đánh dấu một notification cụ thể là đã đọc

**Path Parameters**:
- `notificationId`: ID của notification cần đánh dấu

**Response**:
```json
{
  "code": 1000,
  "message": "Notification marked as read"
}
```

**Ví dụ cURL**:
```bash
curl -X PUT "http://localhost:8080/bej3/api/notifications/550e8400-e29b-41d4-a716-446655440000/read" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

**Ví dụ JavaScript**:
```javascript
const notificationId = '550e8400-e29b-41d4-a716-446655440000';
const response = await fetch(
  `http://localhost:8080/bej3/api/notifications/${notificationId}/read`,
  {
    method: 'PUT',
    headers: {
      'Authorization': `Bearer ${jwtToken}`
    }
  }
);
const data = await response.json();
console.log(data.message); // "Notification marked as read"
```

---

### 5. Đánh Dấu TẤT CẢ Notifications (Toggle)

**Endpoint**: `PUT /api/notifications/read-all`

**Mô tả**: 
- Nếu có notification chưa đọc → đánh dấu TẤT CẢ là đã đọc
- Nếu tất cả đã đọc → đánh dấu TẤT CẢ là chưa đọc (toggle)

**Response**:
```json
{
  "code": 1000,
  "message": "Successfully toggled 10 notifications",
  "result": {
    "updatedCount": 10,
    "message": "All notifications toggled"
  }
}
```

**Ví dụ JavaScript**:
```javascript
const response = await fetch('http://localhost:8080/bej3/api/notifications/read-all', {
  method: 'PUT',
  headers: {
    'Authorization': `Bearer ${jwtToken}`
  }
});
const data = await response.json();
console.log(`Đã cập nhật ${data.result.updatedCount} notifications`);
```

---

## 👨‍💼 API Endpoints - Admin Endpoints

### 1. Gửi Notification Cho Một User

**Endpoint**: `POST /api/notifications/user/{userId}`

**Mô tả**: Admin gửi notification cho một user cụ thể

**Yêu cầu**: Role `ADMIN`

**Path Parameters**:
- `userId`: ID của user nhận notification

**Request Body**:
```json
{
  "type": "GENERAL_ANNOUNCEMENT",
  "title": "Thông báo quan trọng",
  "body": "Nội dung thông báo",
  "metadata": {
    "orderId": "123",
    "customKey": "customValue"
  }
}
```

**Response**:
```json
{
  "code": 1000,
  "message": "Notification event published for user: user-id-123"
}
```

**Notification Types**:
- `ORDER_PLACED`: Đơn hàng mới được tạo thành công
- `ORDER_STATUS_UPDATE`: Trạng thái đơn hàng bị thay đổi
- `REPAIR_REQUEST_RECEIVED`: Yêu cầu sửa chữa được tiếp nhận
- `REPAIR_STATUS_UPDATE`: Trạng thái sửa chữa bị thay đổi
- `REPAIR_TECHNICIAN_MESSAGE`: Kỹ thuật viên gửi tin nhắn hoặc báo giá
- `NEW_PROMOTION`: Có voucher/khuyến mãi mới
- `GENERAL_ANNOUNCEMENT`: Tin nhắn từ admin hoặc thông báo chung hệ thống

**Ví dụ cURL**:
```bash
curl -X POST "http://localhost:8080/bej3/api/notifications/user/user-id-123" \
  -H "Authorization: Bearer ADMIN_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "type": "GENERAL_ANNOUNCEMENT",
    "title": "Thông báo quan trọng",
    "body": "Nội dung thông báo",
    "metadata": {}
  }'
```

---

### 2. Gửi Notification Cho Nhiều Users

**Endpoint**: `POST /api/notifications/multiple-users`

**Mô tả**: Admin gửi notification cho nhiều users cùng lúc

**Yêu cầu**: Role `ADMIN`

**Request Body**:
```json
{
  "userIds": [
    "user-id-1",
    "user-id-2",
    "user-id-3"
  ],
  "notification": {
    "type": "NEW_PROMOTION",
    "title": "Khuyến mãi đặc biệt",
    "body": "Giảm 50% cho tất cả sản phẩm",
    "metadata": {
      "promotionId": "promo-123"
    }
  }
}
```

**Response**:
```json
{
  "code": 1000,
  "message": "Notifications sent to 3 users"
}
```

**Ví dụ JavaScript**:
```javascript
const response = await fetch('http://localhost:8080/bej3/api/notifications/multiple-users', {
  method: 'POST',
  headers: {
    'Authorization': `Bearer ${adminToken}`,
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    userIds: ['user-id-1', 'user-id-2', 'user-id-3'],
    notification: {
      type: 'PROMOTION',
      title: 'Khuyến mãi đặc biệt',
      body: 'Giảm 50% cho tất cả sản phẩm',
      metadata: {
        promotionId: 'promo-123'
      }
    }
  })
});
const data = await response.json();
console.log(data.message);
```

---

### 3. Gửi Broadcast Notification

**Endpoint**: `POST /api/notifications/broadcast`

**Mô tả**: Admin gửi notification cho TẤT CẢ users trong hệ thống

**Yêu cầu**: Role `ADMIN`

**Request Body**:
```json
{
  "type": "GENERAL_ANNOUNCEMENT",
  "title": "Thông báo hệ thống",
  "body": "Hệ thống sẽ bảo trì vào 02:00 sáng mai",
  "metadata": {
    "maintenanceTime": "2025-01-16T02:00:00Z"
  }
}
```

**Response**:
```json
{
  "code": 1000,
  "message": "Broadcast notification event published"
}
```

**Ví dụ cURL**:
```bash
curl -X POST "http://localhost:8080/bej3/api/notifications/broadcast" \
  -H "Authorization: Bearer ADMIN_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "type": "GENERAL_ANNOUNCEMENT",
    "title": "Thông báo hệ thống",
    "body": "Hệ thống sẽ bảo trì vào 02:00 sáng mai",
    "metadata": {}
  }'
```

---

## 🔔 Nhận Notifications Qua Message Broker (WebSocket/STOMP)

### Cấu Hình WebSocket

Hệ thống sử dụng **RabbitMQ STOMP broker** để gửi notifications real-time:

- **WebSocket Endpoint**: `ws://localhost:8080/bej3/ws`
- **Broker Prefix**: `/topic` (broadcast), `/queue` (personal)
- **Personal Queue**: `/user/{userId}/queue/notifications`
- **Broadcast Topic**: `/topic/notifications`

### Kết Nối WebSocket với JavaScript (SockJS + STOMP)

#### Bước 1: Cài Đặt Thư Viện

```bash
npm install sockjs-client @stomp/stompjs
```

hoặc sử dụng CDN:
```html
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@stomp/stompjs@7/bundles/stomp.umd.min.js"></script>
```

#### Bước 2: Kết Nối và Subscribe

```javascript
import SockJS from 'sockjs-client';
import { Client } from '@stomp/stompjs';

class NotificationService {
  constructor(jwtToken, userId) {
    this.jwtToken = jwtToken;
    this.userId = userId;
    this.stompClient = null;
  }

  connect() {
    // Tạo SockJS connection
    const socket = new SockJS('http://localhost:8080/bej3/ws');
    
    // Tạo STOMP client
    this.stompClient = new Client({
      webSocketFactory: () => socket,
      reconnectDelay: 5000,
      heartbeatIncoming: 4000,
      heartbeatOutgoing: 4000,
      connectHeaders: {
        // Có thể thêm JWT token nếu cần (tùy config server)
      },
      
      onConnect: (frame) => {
        console.log('✅ Connected to WebSocket:', frame);
        
        // Subscribe vào queue cá nhân của user
        this.subscribePersonalNotifications();
        
        // Subscribe vào topic broadcast (tùy chọn)
        this.subscribeBroadcastNotifications();
      },
      
      onStompError: (frame) => {
        console.error('❌ STOMP Error:', frame);
      },
      
      onWebSocketError: (event) => {
        console.error('❌ WebSocket Error:', event);
      },
      
      onDisconnect: () => {
        console.log('🔌 Disconnected from WebSocket');
      }
    });

    // Kích hoạt connection
    this.stompClient.activate();
  }

  // Subscribe vào queue cá nhân
  subscribePersonalNotifications() {
    // Queue path: /user/{userId}/queue/notifications
    const destination = `/user/${this.userId}/queue/notifications`;
    
    this.stompClient.subscribe(destination, (message) => {
      const notification = JSON.parse(message.body);
      console.log('📨 Personal Notification received:', notification);
      
      // Xử lý notification
      this.handleNotification(notification);
    });
  }

  // Subscribe vào topic broadcast
  subscribeBroadcastNotifications() {
    const destination = `/topic/notifications`;
    
    this.stompClient.subscribe(destination, (message) => {
      const notification = JSON.parse(message.body);
      console.log('📢 Broadcast Notification received:', notification);
      
      // Xử lý notification
      this.handleNotification(notification);
    });
  }

  // Xử lý notification khi nhận được
  handleNotification(notification) {
    // Ví dụ: Hiển thị toast notification
    this.showToast(notification);
    
    // Cập nhật UI
    this.updateNotificationList(notification);
    
    // Cập nhật badge unread count
    this.updateUnreadCount();
    
    // Phát âm thanh thông báo (tùy chọn)
    this.playNotificationSound();
  }

  showToast(notification) {
    // Ví dụ với một toast library
    toast.success(notification.title, {
      description: notification.body,
      duration: 5000,
    });
  }

  updateNotificationList(notification) {
    // Thêm notification vào đầu danh sách
    // Trigger re-render UI
  }

  updateUnreadCount() {
    // Gọi API để lấy số lượng unread mới
    fetch('http://localhost:8080/bej3/api/notifications/unread-count', {
      headers: {
        'Authorization': `Bearer ${this.jwtToken}`
      }
    })
    .then(res => res.json())
    .then(data => {
      // Cập nhật badge
      document.getElementById('notification-badge').textContent = data.result.unreadCount;
    });
  }

  playNotificationSound() {
    const audio = new Audio('/notification-sound.mp3');
    audio.play().catch(e => console.log('Cannot play sound:', e));
  }

  disconnect() {
    if (this.stompClient) {
      this.stompClient.deactivate();
    }
  }
}

// Sử dụng
const notificationService = new NotificationService(jwtToken, userId);
notificationService.connect();

// Khi user logout
window.addEventListener('beforeunload', () => {
  notificationService.disconnect();
});
```

### Kết Nối WebSocket với React Hook

```javascript
import { useEffect, useState } from 'react';
import SockJS from 'sockjs-client';
import { Client } from '@stomp/stompjs';

function useNotifications(jwtToken, userId) {
  const [notifications, setNotifications] = useState([]);
  const [stompClient, setStompClient] = useState(null);

  useEffect(() => {
    if (!jwtToken || !userId) return;

    const socket = new SockJS('http://localhost:8080/bej3/ws');
    const client = new Client({
      webSocketFactory: () => socket,
      reconnectDelay: 5000,
      heartbeatIncoming: 4000,
      heartbeatOutgoing: 4000,
      onConnect: () => {
        console.log('✅ Connected to WebSocket');
        
        // Subscribe personal notifications
        client.subscribe(`/user/${userId}/queue/notifications`, (message) => {
          const notification = JSON.parse(message.body);
          setNotifications(prev => [notification, ...prev]);
        });

        // Subscribe broadcast
        client.subscribe('/topic/notifications', (message) => {
          const notification = JSON.parse(message.body);
          setNotifications(prev => [notification, ...prev]);
        });
      },
      onStompError: (frame) => {
        console.error('STOMP Error:', frame);
      }
    });

    client.activate();
    setStompClient(client);

    return () => {
      client.deactivate();
    };
  }, [jwtToken, userId]);

  return { notifications, stompClient };
}

// Sử dụng trong component
function NotificationComponent() {
  const { jwtToken, userId } = useAuth();
  const { notifications } = useNotifications(jwtToken, userId);

  return (
    <div>
      <h2>Notifications ({notifications.length})</h2>
      {notifications.map(notif => (
        <div key={notif.messageId}>
          <h3>{notif.title}</h3>
          <p>{notif.body}</p>
        </div>
      ))}
    </div>
  );
}
```

### Kết Nối WebSocket với Vue.js

```javascript
import { ref, onMounted, onUnmounted } from 'vue';
import SockJS from 'sockjs-client';
import { Client } from '@stomp/stompjs';

export function useNotifications(jwtToken, userId) {
  const notifications = ref([]);
  let stompClient = null;

  const connect = () => {
    const socket = new SockJS('http://localhost:8080/bej3/ws');
    stompClient = new Client({
      webSocketFactory: () => socket,
      reconnectDelay: 5000,
      onConnect: () => {
        stompClient.subscribe(`/user/${userId}/queue/notifications`, (message) => {
          const notification = JSON.parse(message.body);
          notifications.value.unshift(notification);
        });
      }
    });
    stompClient.activate();
  };

  const disconnect = () => {
    if (stompClient) {
      stompClient.deactivate();
    }
  };

  onMounted(() => {
    if (jwtToken && userId) {
      connect();
    }
  });

  onUnmounted(() => {
    disconnect();
  });

  return { notifications, connect, disconnect };
}
```

---

## 🔄 Tự Động Gửi Notification Khi Order Status Update

Khi order status được cập nhật, hệ thống **TỰ ĐỘNG** gửi notification cho user sở hữu order:

### Flow Tự Động

1. **Admin/System** cập nhật order status:
   ```http
   PUT /api/orders/{orderId}/status
   ```

2. **OrderService** publish `OrderStatusUpdateEvent`:
   ```java
   eventPublisher.publishEvent(new OrderStatusUpdateEvent(...));
   ```

3. **NotificationEventListener** tự động bắt event:
   ```java
   @EventListener
   public void handleOrderStatusUpdateEvent(OrderStatusUpdateEvent event)
   ```

4. **Tự động gửi notification** qua:
   - ✅ Database (lưu vào bảng notification)
   - ✅ WebSocket (push real-time)
   - ✅ Firebase (push notification cho mobile)

### Ví Dụ Order Status Update

**API Update Order Status**:
```bash
PUT /api/orders/order-123/status
Content-Type: application/json
Authorization: Bearer ADMIN_TOKEN

{
  "status": 4,
  "note": "Đơn hàng đang được giao"
}
```

**Notification Tự Động Được Tạo**:
```json
{
  "type": "ORDER_STATUS_UPDATE",
  "title": "Cập nhật đơn hàng",
  "body": "Đơn hàng #order-123 đã được cập nhật: Đang giao hàng - Đơn hàng đang được giao",
  "metadata": {
    "orderId": "order-123",
    "oldStatus": "3",
    "newStatus": "4"
  }
}
```

**User sẽ nhận notification qua**:
1. WebSocket real-time (nếu đang online)
2. Firebase push (nếu có mobile app)
3. Lấy từ API `/api/notifications/my-notifications` khi refresh

---

## 📝 Notification Payload Structure

Khi nhận notification qua WebSocket, payload có cấu trúc:

```typescript
interface NotificationPayload {
  messageId: string;        // UUID của notification
  type: NotificationType;   // SYSTEM, ORDER_STATUS_UPDATE, PROMOTION, etc.
  title: string;            // Tiêu đề
  body: string;             // Nội dung
  timestamp: string;        // ISO 8601 format
  metadata?: {              // Metadata tùy chỉnh
    [key: string]: string;
  };
}
```

**Ví dụ payload**:
```json
{
  "messageId": "550e8400-e29b-41d4-a716-446655440000",
  "type": "ORDER_STATUS_UPDATE",
  "title": "Cập nhật đơn hàng",
  "body": "Đơn hàng #123 đã được cập nhật: Đang giao hàng",
  "timestamp": "2025-01-15T10:30:00Z",
  "metadata": {
    "orderId": "123",
    "oldStatus": "2",
    "newStatus": "4"
  }
}
```

---

## 🧪 Testing với Postman

### 1. Test Get Notifications

1. Tạo request mới trong Postman
2. Method: `GET`
3. URL: `http://localhost:8080/bej3/api/notifications/my-notifications`
4. Headers:
   - `Authorization: Bearer <your-jwt-token>`
   - `Content-Type: application/json`

### 2. Test Send Notification (Admin)

1. Method: `POST`
2. URL: `http://localhost:8080/bej3/api/notifications/user/{userId}`
3. Headers:
   - `Authorization: Bearer <admin-jwt-token>`
   - `Content-Type: application/json`
4. Body (raw JSON):
```json
{
  "type": "GENERAL_ANNOUNCEMENT",
  "title": "Test Notification",
  "body": "This is a test notification",
  "metadata": {}
}
```

### 3. Test WebSocket Connection

Sử dụng **Postman WebSocket** hoặc **WSCat**:

```bash
# Cài đặt wscat
npm install -g wscat

# Kết nối WebSocket
wscat -c ws://localhost:8080/bej3/ws

# Sau khi kết nối, gửi STOMP CONNECT frame
CONNECT
accept-version:1.1,1.0
heart-beat:10000,10000

# Subscribe vào queue
SUBSCRIBE
id:sub-0
destination:/user/{userId}/queue/notifications
```

---

## 🔍 Troubleshooting

### WebSocket không kết nối được

1. **Kiểm tra RabbitMQ đang chạy**:
   ```bash
   docker ps | grep rabbitmq
   ```

2. **Kiểm tra STOMP plugin đã enable**:
   - Vào RabbitMQ Management: `http://localhost:15672`
   - Kiểm tra tab "Plugins" → "rabbitmq_stomp" phải enabled

3. **Kiểm tra port 61613**:
   ```bash
   netstat -an | grep 61613
   ```

4. **Kiểm tra CORS**:
   - Đảm bảo CORS cho phép origin của frontend

### Notification không nhận được qua WebSocket

1. **Kiểm tra userId đúng**:
   - Queue path phải là: `/user/{userId}/queue/notifications`
   - userId phải là UUID của user, không phải phoneNumber

2. **Kiểm tra JWT token**:
   - Token phải hợp lệ và chưa hết hạn

3. **Kiểm tra logs backend**:
   ```bash
   docker logs spring_app | grep WebSocket
   ```

---

## 📚 Tài Liệu Tham Khảo

- [Spring WebSocket Documentation](https://docs.spring.io/spring-framework/docs/current/reference/html/web.html#websocket)
- [STOMP Protocol Specification](https://stomp.github.io/)
- [RabbitMQ STOMP Plugin](https://www.rabbitmq.com/stomp.html)
- [SockJS Client](https://github.com/sockjs/sockjs-client)
- [STOMP.js Library](https://stomp-js.github.io/)

---

**Version**: 1.0.0  
**Last Updated**: January 2025

