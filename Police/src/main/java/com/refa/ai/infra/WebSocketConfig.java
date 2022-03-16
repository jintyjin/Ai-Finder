package com.refa.ai.infra;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.AbstractWebSocketMessageBrokerConfigurer;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig extends AbstractWebSocketMessageBrokerConfigurer {
	@Override
    public void configureMessageBroker(final MessageBrokerRegistry config) {
        System.out.println("configureMessageBroker");
        config.enableSimpleBroker("/");
    }
	
    @Override
    public void registerStompEndpoints(final StompEndpointRegistry registry) {
        System.out.println("registerStompEndpoints");
        //registry.addEndpoint(new String[] { "/websocket" }).setAllowedOrigins(new String[] { "*" }).withSockJS();
        registry.addEndpoint("/websocket").setAllowedOrigins("*").withSockJS();
    }
}
