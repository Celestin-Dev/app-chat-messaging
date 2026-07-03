package com.celestin.appchat.config;

import java.util.Collections;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;

@Configuration
public class GoogleAuthConfig {

  @Value("${google.oauth.client-id}")
  private String googleClientId;

  @Bean
  public GoogleIdTokenVerifier googleIdTokenVerifier() throws Exception {
    return new GoogleIdTokenVerifier.Builder(GoogleNetHttpTransport.newTrustedTransport(), 
        GsonFactory.getDefaultInstance())
        .setAudience(Collections.singletonList(googleClientId))
        .build();
  }
  
}
