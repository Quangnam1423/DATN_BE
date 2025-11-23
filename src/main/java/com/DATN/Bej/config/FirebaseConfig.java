package com.DATN.Bej.config;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
public class FirebaseConfig {
    
    @Bean
    public FirebaseApp firebaseApp() throws IOException {
        // Kiểm tra xem FirebaseApp đã được khởi tạo chưa
        // (Tránh lỗi khi Spring DevTools hot reload)
        try {
            FirebaseApp existingApp = FirebaseApp.getInstance();
            log.info("✅ FirebaseApp already exists, reusing existing instance: {}", existingApp.getName());
            return existingApp;
        } catch (IllegalStateException e) {
            // FirebaseApp chưa tồn tại, tiếp tục khởi tạo
            log.info("🔥 Initializing Firebase...");
        }
        
        // Đường dẫn tới file service account JSON
        String filePath = "src/main/resources/datn-e3c62-firebase-adminsdk-fbsvc-8b853f1fc7.json";
        
        // Thử tìm file từ các vị trí khác nhau
        java.io.File file = new java.io.File(filePath);
        
        if (!file.exists()) {
            // Thử từ target/classes
            filePath = "target/classes/datn-e3c62-firebase-adminsdk-fbsvc-8b853f1fc7.json";
            file = new java.io.File(filePath);
        }
        
        if (!file.exists()) {
            // Thử từ classpath
            filePath = "datn-e3c62-firebase-adminsdk-fbsvc-8b853f1fc7.json";
            file = new java.io.File(filePath);
        }
        
        if (!file.exists()) {
            String errorMsg = "❌ Firebase service account key file not found. Checked locations:\n" +
                "- src/main/resources/datn-e3c62-firebase-adminsdk-fbsvc-8b853f1fc7.json\n" +
                "- target/classes/datn-e3c62-firebase-adminsdk-fbsvc-8b853f1fc7.json\n" +
                "- datn-e3c62-firebase-adminsdk-fbsvc-8b853f1fc7.json";
            log.error(errorMsg);
            throw new IOException(errorMsg);
        }
        
        log.info("✅ Firebase config file found: {}", file.getAbsolutePath());
        
        InputStream serviceAccount = new FileInputStream(file);
        
        FirebaseOptions options = FirebaseOptions.builder()
            .setCredentials(GoogleCredentials.fromStream(serviceAccount))
            .build();
        
        FirebaseApp app = FirebaseApp.initializeApp(options);
        log.info("✅ Firebase initialized successfully");
        
        return app;
    }
}