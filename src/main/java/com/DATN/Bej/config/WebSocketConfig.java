package com.DATN.Bej.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    @Value("${spring.rabbitmq.host}")
    private String host;

    // Lưu ý: Đọc biến môi trường mới tạo
    @Value("${spring.rabbitmq.stomp.port}") 
    private int stompPort;

    @Value("${spring.rabbitmq.username}")
    private String username;

    @Value("${spring.rabbitmq.password}")
    private String password;

    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        registry.enableStompBrokerRelay("/topic", "/queue")
                .setRelayHost(host)
                .setRelayPort(stompPort)
                .setClientLogin(username)
                .setClientPasscode(password)
                .setSystemLogin(username)
                .setSystemPasscode(password);

        registry.setApplicationDestinationPrefixes("/app");
        // Cấu hình user destination prefix để convertAndSendToUser hoạt động với RabbitMQ
        registry.setUserDestinationPrefix("/user");
    }

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/ws").withSockJS();
    }
}