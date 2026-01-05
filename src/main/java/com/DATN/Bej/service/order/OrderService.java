package com.DATN.Bej.service.order;

import com.DATN.Bej.dto.request.cartRequest.CreateOrderRequest;
import com.DATN.Bej.dto.request.cartRequest.OrderItemsUpdateRequest;
import com.DATN.Bej.dto.request.order.UpdateOrderStatusRequest;
import com.DATN.Bej.dto.response.OrderStatisticsResponse;
import com.DATN.Bej.dto.response.RevenueStatisticsResponse;
import com.DATN.Bej.dto.response.TopProductResponse;
import com.DATN.Bej.dto.response.TopRepairServiceResponse;
import com.DATN.Bej.dto.response.WeeklyRevenueResponse;
import com.DATN.Bej.dto.response.cart.OrderDetailsResponse;
import com.DATN.Bej.dto.response.order.OrderStatusUpdateResponse;
import com.DATN.Bej.entity.cart.OrderItem;
import com.DATN.Bej.entity.cart.OrderNote;
import com.DATN.Bej.entity.cart.Orders;
import com.DATN.Bej.entity.identity.User;
import com.DATN.Bej.entity.product.ProductAttribute;
import com.DATN.Bej.event.OrderStatusUpdateEvent;
import com.DATN.Bej.exception.AppException;
import com.DATN.Bej.exception.ErrorCode;
import com.DATN.Bej.mapper.product.OrderMapper;
import com.DATN.Bej.repository.UserRepository;
import com.DATN.Bej.repository.product.CartItemRepository;
import com.DATN.Bej.repository.product.OrderItemRepository;
import com.DATN.Bej.repository.product.OrderRepository;
import com.DATN.Bej.repository.product.ProductAttributeRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.time.temporal.WeekFields;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Transactional
public class OrderService {
    private final ProductAttributeRepository productAttributeRepository;
    private final UserRepository userRepository;
    CartItemRepository cartItemRepository;

    OrderMapper orderMapper;

    OrderRepository orderRepository;
    OrderItemRepository orderItemRepository;
    SimpMessagingTemplate messagingTemplate;
    ApplicationEventPublisher eventPublisher;

    /**
     * Cập nhật trạng thái đơn hàng và broadcast qua WebSocket
     * @param orderId ID đơn hàng
     * @param request UpdateOrderStatusRequest chứa status mới
     * @return OrderStatusUpdateResponse
     */
    public OrderStatusUpdateResponse updateOrderStatus(String orderId, UpdateOrderStatusRequest request) {
        log.info("📦 Updating order status - Order: {}, New status: {}", orderId, request.getStatus());
        
        Orders order = orderRepository.findById(orderId)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED));
        var context = SecurityContextHolder.getContext();
        String name = context.getAuthentication().getName();
        User user = userRepository.findByPhoneNumber(name).orElseThrow(
                () -> new AppException(ErrorCode.USER_NOT_EXISTED));;
        
        int oldStatus = order.getStatus();
        int newStatus = request.getStatus();
        
        // Validate status transition (có thể thêm logic phức tạp hơn)
        if (newStatus < 0 || newStatus > 5) {
            throw new AppException(ErrorCode.INVALID_KEY);
        }

        if (request.getNote() != null){
            OrderNote newNote = new OrderNote();
            newNote.setOrder(order);
            newNote.setNote(request.getNote());
            newNote.setUpdateTime(LocalDateTime.now());
            newNote.setUpdateBy(user);
            order.getOrderNotes().add(newNote);
        }
        
        // Cập nhật trạng thái
        order.setStatus(newStatus);
        order.setUpdatedAt(LocalDate.now());
        orderRepository.save(order);
        
        // Tạo response
        OrderStatusUpdateResponse response = OrderStatusUpdateResponse.builder()
                .orderId(orderId)
                .oldStatus(oldStatus)
                .newStatus(newStatus)
                .statusName(getStatusName(newStatus))
                .updatedAt(LocalDate.now())
                .note(request.getNote())
                .message("Order status updated successfully")
                .build();
        
        // Broadcast qua WebSocket đến user sở hữu đơn hàng
        String userId = order.getUser().getId();
        String destination = "/topic/orders/" + userId + "/" + orderId;
        
        Map<String, Object> message = new HashMap<>();
        message.put("type", "ORDER_STATUS_UPDATE");
        message.put("orderId", orderId);
        message.put("oldStatus", oldStatus);
        message.put("newStatus", newStatus);
        message.put("statusName", getStatusName(newStatus));
        message.put("updatedAt", LocalDate.now().toString());
        message.put("note", request.getNote());
        
        messagingTemplate.convertAndSend(destination, message);
        
        // Broadcast đến topic chung cho admin
        messagingTemplate.convertAndSend("/topic/orders/admin", message);
        
        // Publish event để gửi thông báo qua Firebase và lưu vào database
        OrderStatusUpdateEvent statusUpdateEvent = new OrderStatusUpdateEvent(
                orderId,
                userId,
                oldStatus,
                newStatus,
                getStatusName(newStatus),
                request.getNote()
        );
        
        eventPublisher.publishEvent(statusUpdateEvent);
        
        log.info("✅ Order status updated, broadcasted via WebSocket and event published - Order: {}, Status: {} -> {}", 
                orderId, oldStatus, newStatus);
        
        return response;
    }

    public OrderDetailsResponse updateOrderItems(String orderId, OrderItemsUpdateRequest request){
        Orders order = orderRepository.findById(orderId).orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED));
        var context = SecurityContextHolder.getContext();
        String name = context.getAuthentication().getName();
        User user = userRepository.findByPhoneNumber(name).orElseThrow(
                () -> new AppException(ErrorCode.USER_NOT_EXISTED));;

        double price = 0;
        for (var itemReq : request.getItems()){
            ProductAttribute productAtt = productAttributeRepository
                    .findById(itemReq.getProductAttId())
                    .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED));
            OrderItem orderItem = orderMapper.toOrderItem(itemReq);
            orderItem.setProductA(productAtt);
            orderItem.setOrder(order);
            orderItem.setPrice(productAtt.getFinalPrice());
            price += productAtt.getFinalPrice();
            order.getOrderItems().add(orderItem);
        }
        OrderNote newNote = new OrderNote();
        newNote.setOrder(order);
        newNote.setNote("Cập nhật linh kiện sử dụng");
        newNote.setUpdateTime(LocalDateTime.now());
        newNote.setUpdateBy(user);
        order.getOrderNotes().add(newNote);

        order.setUpdatedAt(LocalDate.now());
        double totalPrice = order.getTotalPrice();
        order.setTotalPrice(totalPrice + price);
        return orderMapper.toOrderDetailsResponse(orderRepository.save(order));
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
    
    /**
     * Thống kê doanh thu theo tháng
     * @param year Năm cần thống kê
     * @param month Tháng cần thống kê (1-12), null nếu thống kê cả năm
     * @return RevenueStatisticsResponse chứa thông tin thống kê
     */
    public RevenueStatisticsResponse getRevenueStatistics(int year, Integer month) {
        log.info("📊 Getting revenue statistics - Year: {}, Month: {}", year, month);
        
        if (month != null && (month < 1 || month > 12)) {
            throw new AppException(ErrorCode.INVALID_KEY);
        }
        
        if (month != null) {
            // Thống kê theo tháng cụ thể
            return getMonthlyRevenue(year, month);
        } else {
            // Thống kê cả năm
            return getYearlyRevenue(year);
        }
    }
    
    /**
     * Thống kê doanh thu theo tháng cụ thể
     */
    private RevenueStatisticsResponse getMonthlyRevenue(int year, int month) {
        YearMonth yearMonth = YearMonth.of(year, month);
        LocalDate startDate = yearMonth.atDay(1);
        LocalDate endDate = yearMonth.atEndOfMonth();
        
        Double totalRevenue = orderRepository.sumTotalPriceByOrderAtBetweenAndStatus(startDate, endDate);
        Long totalOrders = orderRepository.countByOrderAtBetween(startDate, endDate);
        Long repairOrder = orderRepository.countByOrderAtBetweenAndType(startDate, endDate, 1);
        Long saleOrder = orderRepository.countByOrderAtBetweenAndType(startDate, endDate, 0);
        
        if (totalRevenue == null) {
            totalRevenue = 0.0;
        }
        
        return RevenueStatisticsResponse.builder()
                .year(year)
                .month(month)
                .totalRevenue(totalRevenue)
                .totalOrders(totalOrders != null ? totalOrders : 0)
                .repairOrder(repairOrder)
                .saleOrder(saleOrder)
                .monthlyRevenues(null)
                .build();
    }
    
    /**
     * Thống kê doanh thu cả năm (theo từng tháng)
     */
    private RevenueStatisticsResponse getYearlyRevenue(int year) {
        List<RevenueStatisticsResponse.MonthlyRevenue> monthlyRevenues = new ArrayList<>();
        double totalYearRevenue = 0.0;
        long totalYearOrders = 0;
        
        // Tính doanh thu cho từng tháng
        for (int m = 1; m <= 12; m++) {
            YearMonth yearMonth = YearMonth.of(year, m);
            LocalDate monthStart = yearMonth.atDay(1);
            LocalDate monthEnd = yearMonth.atEndOfMonth();
            
            Double monthRevenue = orderRepository.sumTotalPriceByOrderAtBetweenAndStatus(monthStart, monthEnd);
            Long monthOrders = orderRepository.countByOrderAtBetweenAndStatus(monthStart, monthEnd);
            
            if (monthRevenue == null) {
                monthRevenue = 0.0;
            }
            if (monthOrders == null) {
                monthOrders = 0L;
            }
            
            totalYearRevenue += monthRevenue;
            totalYearOrders += monthOrders;
            
            monthlyRevenues.add(RevenueStatisticsResponse.MonthlyRevenue.builder()
                    .month(m)
                    .monthName("Tháng " + m)
                    .revenue(monthRevenue)
                    .orderCount(monthOrders)
                    .build());
        }
        
        return RevenueStatisticsResponse.builder()
                .year(year)
                .month(null)
                .totalRevenue(totalYearRevenue)
                .totalOrders(totalYearOrders)
                .monthlyRevenues(monthlyRevenues)
                .build();
    }
    
    /**
     * Thống kê doanh thu theo tuần
     * @param year Năm
     * @param week Số tuần trong năm (1-53)
     * @return WeeklyRevenueResponse
     */
    public WeeklyRevenueResponse getWeeklyRevenueStatistics(int year, int week) {
        log.info("📊 Getting weekly revenue statistics - Year: {}, Week: {}", year, week);
        
        if (week < 1 || week > 53) {
            throw new AppException(ErrorCode.INVALID_KEY);
        }
        
        WeekFields weekFields = WeekFields.of(Locale.getDefault());
        LocalDate firstDayOfYear = LocalDate.of(year, 1, 1);
        LocalDate weekStart = firstDayOfYear.with(weekFields.weekOfWeekBasedYear(), week)
                                            .with(weekFields.dayOfWeek(), 1);
        LocalDate weekEnd = weekStart.plusDays(6);
        
        // Đảm bảo không vượt quá năm hiện tại
        if (weekStart.getYear() != year) {
            weekStart = LocalDate.of(year, 1, 1);
        }
        if (weekEnd.getYear() != year) {
            weekEnd = LocalDate.of(year, 12, 31);
        }
        
        Double totalRevenue = orderRepository.sumTotalPriceByOrderAtBetweenAndStatus(weekStart, weekEnd);
        Long totalOrders = orderRepository.countByOrderAtBetweenAndStatus(weekStart, weekEnd);
        
        if (totalRevenue == null) {
            totalRevenue = 0.0;
        }
        if (totalOrders == null) {
            totalOrders = 0L;
        }
        
        // Tính doanh thu theo từng ngày trong tuần
        List<WeeklyRevenueResponse.DailyRevenue> dailyRevenues = new ArrayList<>();
        for (int i = 0; i < 7; i++) {
            LocalDate day = weekStart.plusDays(i);
            if (day.isAfter(weekEnd)) break;
            
            Double dayRevenue = orderRepository.sumTotalPriceByOrderAtBetweenAndStatus(day, day);
            Long dayOrders = orderRepository.countByOrderAtBetweenAndStatus(day, day);
            
            if (dayRevenue == null) {
                dayRevenue = 0.0;
            }
            if (dayOrders == null) {
                dayOrders = 0L;
            }
            
            dailyRevenues.add(WeeklyRevenueResponse.DailyRevenue.builder()
                    .day(day.getDayOfMonth())
                    .date(day.toString())
                    .revenue(dayRevenue)
                    .orderCount(dayOrders)
                    .build());
        }
        
        String weekRange = weekStart.toString() + " - " + weekEnd.toString();
        
        return WeeklyRevenueResponse.builder()
                .year(year)
                .week(week)
                .weekRange(weekRange)
                .totalRevenue(totalRevenue)
                .totalOrders(totalOrders)
                .dailyRevenues(dailyRevenues)
                .build();
    }
    
    /**
     * Thống kê số đơn mua bán và sửa chữa
     * @param year Năm (tùy chọn)
     * @param month Tháng (tùy chọn)
     * @param week Tuần (tùy chọn)
     * @return OrderStatisticsResponse
     */
    public OrderStatisticsResponse getOrderStatistics(Integer year, Integer month, Integer week) {
        log.info("📊 Getting order statistics - Year: {}, Month: {}, Week: {}", year, month, week);
        
        LocalDate startDate;
        LocalDate endDate;
        
        if (week != null && year != null) {
            // Thống kê theo tuần
            WeekFields weekFields = WeekFields.of(Locale.getDefault());
            LocalDate firstDayOfYear = LocalDate.of(year, 1, 1);
            startDate = firstDayOfYear.with(weekFields.weekOfWeekBasedYear(), week)
                                      .with(weekFields.dayOfWeek(), 1);
            endDate = startDate.plusDays(6);
            if (startDate.getYear() != year) {
                startDate = LocalDate.of(year, 1, 1);
            }
            if (endDate.getYear() != year) {
                endDate = LocalDate.of(year, 12, 31);
            }
        } else if (month != null && year != null) {
            // Thống kê theo tháng
            YearMonth yearMonth = YearMonth.of(year, month);
            startDate = yearMonth.atDay(1);
            endDate = yearMonth.atEndOfMonth();
        } else if (year != null) {
            // Thống kê theo năm
            startDate = LocalDate.of(year, 1, 1);
            endDate = LocalDate.of(year, 12, 31);
        } else {
            // Thống kê tất cả
            startDate = LocalDate.of(2000, 1, 1);
            endDate = LocalDate.now();
        }
        
        Long purchaseOrders = orderRepository.countByOrderAtBetweenAndStatusAndType(startDate, endDate, 0);
        Long repairOrders = orderRepository.countByOrderAtBetweenAndStatusAndType(startDate, endDate, 1);
        
        if (purchaseOrders == null) purchaseOrders = 0L;
        if (repairOrders == null) repairOrders = 0L;
        
        return OrderStatisticsResponse.builder()
                .totalPurchaseOrders(purchaseOrders)
                .totalRepairOrders(repairOrders)
                .totalOrders(purchaseOrders + repairOrders)
                .year(year)
                .month(month)
                .week(week)
                .build();
    }
    
    /**
     * Thống kê các sản phẩm bán chạy nhất
     * @param year Năm (tùy chọn)
     * @param month Tháng (tùy chọn)
     * @param limit Số lượng sản phẩm cần lấy (mặc định 10)
     * @return TopProductResponse
     */
    public TopProductResponse getTopProducts(Integer year, Integer month, Integer limit) {
        log.info("📊 Getting top products - Year: {}, Month: {}, Limit: {}", year, month, limit);
        
        if (limit == null || limit <= 0) {
            limit = 10;
        }
        
        LocalDate startDate;
        LocalDate endDate;
        
        if (month != null && year != null) {
            YearMonth yearMonth = YearMonth.of(year, month);
            startDate = yearMonth.atDay(1);
            endDate = yearMonth.atEndOfMonth();
        } else if (year != null) {
            startDate = LocalDate.of(year, 1, 1);
            endDate = LocalDate.of(year, 12, 31);
        } else {
            // Lấy 1 năm gần nhất
            endDate = LocalDate.now();
            startDate = endDate.minusYears(1);
        }
        
        List<Object[]> results = orderItemRepository.findTopProductsByDateRange(startDate, endDate);
        
        List<TopProductResponse.TopProductItem> products = new ArrayList<>();
        int count = 0;
        
        for (Object[] result : results) {
            if (count >= limit) break;
            
            String productAttributeId = (String) result[0];
            Long totalSold = ((Number) result[1]).longValue();
            Double totalRevenue = ((Number) result[2]).doubleValue();
            
            ProductAttribute productAttribute = productAttributeRepository.findById(productAttributeId)
                    .orElse(null);
            
            if (productAttribute != null && productAttribute.getVariant() != null 
                && productAttribute.getVariant().getProduct() != null) {
                String productId = productAttribute.getVariant().getProduct().getId();
                String productName = productAttribute.getVariant().getProduct().getName();
                String productAttributeName = productAttribute.getName();
                String image = productAttribute.getVariant().getProduct().getImage();
                
                products.add(TopProductResponse.TopProductItem.builder()
                        .productId(productId)
                        .productName(productName)
                        .productAttributeId(productAttributeId)
                        .productAttributeName(productAttributeName)
                        .totalSold(totalSold)
                        .totalRevenue(totalRevenue)
                        .image(image)
                        .build());
                count++;
            }
        }
        
        return TopProductResponse.builder()
                .products(products)
                .limit(limit)
                .build();
    }
    
    /**
     * Thống kê các dịch vụ sửa chữa được dùng nhiều nhất
     * @param year Năm (tùy chọn)
     * @param month Tháng (tùy chọn)
     * @param limit Số lượng dịch vụ cần lấy (mặc định 10)
     * @return TopRepairServiceResponse
     */
    public TopRepairServiceResponse getTopRepairServices(Integer year, Integer month, Integer limit) {
        log.info("📊 Getting top repair services - Year: {}, Month: {}, Limit: {}", year, month, limit);
        
        if (limit == null || limit <= 0) {
            limit = 10;
        }
        
        LocalDate startDate;
        LocalDate endDate;
        
        if (month != null && year != null) {
            YearMonth yearMonth = YearMonth.of(year, month);
            startDate = yearMonth.atDay(1);
            endDate = yearMonth.atEndOfMonth();
        } else if (year != null) {
            startDate = LocalDate.of(year, 1, 1);
            endDate = LocalDate.of(year, 12, 31);
        } else {
            // Lấy 1 năm gần nhất
            endDate = LocalDate.now();
            startDate = endDate.minusYears(1);
        }
        
        List<Object[]> results = orderRepository.findTopRepairServicesByDateRange(startDate, endDate);
        
        List<TopRepairServiceResponse.TopRepairServiceItem> services = new ArrayList<>();
        int count = 0;
        
        for (Object[] result : results) {
            if (count >= limit) break;
            
            String description = (String) result[0];
            Long usageCount = ((Number) result[1]).longValue();
            Double totalRevenue = ((Number) result[2]).doubleValue();
            
            services.add(TopRepairServiceResponse.TopRepairServiceItem.builder()
                    .serviceDescription(description)
                    .usageCount(usageCount)
                    .totalRevenue(totalRevenue)
                    .build());
            count++;
        }
        
        return TopRepairServiceResponse.builder()
                .services(services)
                .limit(limit)
                .build();
    }


    public OrderDetailsResponse createNewOrder(CreateOrderRequest request) {
        User user = userRepository.findById(request.getUserId()).orElseThrow(
                () -> new AppException(ErrorCode.USER_NOT_EXISTED));

        Orders orders = orderMapper.toOrder(request);
        orders.setUser(user);

        List<OrderItem> orderItems = new ArrayList<>();
        for (var itemReq : request.getItems()) {
            log.info(itemReq.getCartItemId());
            ProductAttribute productAtt = productAttributeRepository
                    .findById(itemReq.getProductAttId())
                    .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED));
            OrderItem orderItem = orderMapper.toOrderItem(itemReq);
            orderItem.setProductA(productAtt);
            orderItem.setOrder(orders);
            orderItem.setPrice(productAtt.getFinalPrice());
//            cartItemRepository.deleteById(itemReq.getCartItemId());

//            productAttributeRepository.increaseSoldQuantity(UUID.fromString(productAtt.getId()), orderItem.getQuantity());

            orderItems.add(orderItem);
        }
        double totalPrice = orderItems.stream()
                .mapToDouble(OrderItem::getPrice)
                .sum();

        orders.setTotalPrice(totalPrice);
        orders.setOrderItems(orderItems);
        orders.setOrderAt(LocalDate.now());

        Orders saved = orderRepository.save(orders);
        return orderMapper.toOrderDetailsResponse(saved);
    }
}

