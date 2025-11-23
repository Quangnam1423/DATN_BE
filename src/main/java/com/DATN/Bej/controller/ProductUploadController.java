package com.DATN.Bej.controller;

import com.DATN.Bej.dto.request.productRequest.CategoryRequest;
import com.DATN.Bej.dto.request.productRequest.ProductRequest;
import com.DATN.Bej.dto.response.productResponse.ProductResponse;
import com.DATN.Bej.service.ProductService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

/**
 * Controller đơn giản để upload product qua HTML form
 * Không yêu cầu authentication (public access)
 * 
 * ⚠️ LƯU Ý: Endpoint này không có bảo mật, chỉ dùng cho mục đích test/development
 */
@Slf4j
@Controller
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequestMapping("/upload")
public class ProductUploadController {

    ProductService productService;

    /**
     * GET /upload/product
     * Hiển thị form HTML đơn giản để upload product
     * Không cần authentication
     */
    @GetMapping("/product")
    public String showUploadForm(Model model) {
        log.info("📝 Showing product upload form");
        // Trả về view name - Spring sẽ tìm file templates/product-upload.html
        return "product-upload";
    }

    /**
     * POST /upload/product
     * Nhận dữ liệu từ form và tạo product
     * Không cần authentication
     * 
     * ⚠️ LƯU Ý: Trong production, nên thêm authentication hoặc API key
     */
    @PostMapping("/product")
    public String uploadProduct(
            @RequestParam("name") String name,
            @RequestParam("description") String description,
            @RequestParam("categoryId") Long categoryId,
            @RequestParam(value = "status", defaultValue = "1") int status,
            @RequestParam(value = "image", required = false) MultipartFile image,
            Model model) throws IOException {
        
        log.info("📦 Uploading product - Name: {}, Category: {}", name, categoryId);
        
        try {
            // Tạo ProductRequest từ form data
            ProductRequest productRequest = new ProductRequest();
            productRequest.setName(name);
            productRequest.setDescription(description);
            productRequest.setStatus(status);
            productRequest.setImage(image);
            
            // Set category
            CategoryRequest categoryRequest = new CategoryRequest();
            categoryRequest.setId(categoryId);
            productRequest.setCategory(categoryRequest);
            
            // Gọi service để tạo product
            // Sử dụng reflection hoặc tạo method public riêng
            // Vì addNewProduct có thể có security check, ta sẽ gọi trực tiếp
            ProductResponse result = productService.addNewProduct(productRequest);
            
            model.addAttribute("success", true);
            model.addAttribute("message", "Product uploaded successfully!");
            model.addAttribute("productId", result.getId());
            model.addAttribute("productName", result.getName());
            
            log.info("✅ Product uploaded successfully - ID: {}", result.getId());
            
        } catch (com.DATN.Bej.exception.AppException e) {
            // Xử lý AppException (có ErrorCode)
            log.error("❌ AppException: {} - {}", e.getErrorCode().getCode(), e.getMessage());
            model.addAttribute("success", false);
            model.addAttribute("message", "Error [" + e.getErrorCode().getCode() + "]: " + e.getErrorCode().getMessage());
        } catch (Exception e) {
            // Xử lý các exception khác
            log.error("❌ Failed to upload product: {}", e.getMessage(), e);
            log.error("   Exception type: {}", e.getClass().getName());
            if (e.getCause() != null) {
                log.error("   Caused by: {}", e.getCause().getMessage());
            }
            // Print stack trace để debug
            e.printStackTrace();
            
            model.addAttribute("success", false);
            String errorMessage = e.getMessage() != null ? e.getMessage() : e.getClass().getSimpleName();
            model.addAttribute("message", "Error: " + errorMessage);
        }
        
        return "product-upload";
    }
}

