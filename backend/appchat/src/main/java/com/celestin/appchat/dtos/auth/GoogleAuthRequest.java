package com.celestin.appchat.dtos.auth;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class GoogleAuthRequest {
  @NotBlank(message = "Token is required")
  private String token;
}
