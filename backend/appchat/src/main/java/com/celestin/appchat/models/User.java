package com.celestin.appchat.models;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;

import com.celestin.appchat.enums.AuthProvider;
import com.celestin.appchat.enums.Role;

@Entity
@Table(name = "users")
@Data
@EqualsAndHashCode(of = "id")
public class User {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(name = "username", nullable = false, unique = true)
  private String username;

  @Column(name = "password", nullable = true)
  private String password;

  @Column(name = "email", nullable = false, unique = true)
  private String email;

  @Column(name = "phone", unique = true)
  private String phone;

  @Enumerated(EnumType.STRING)
  @Column(nullable = false)
  private Role role;

  @Enumerated(EnumType.STRING)
  @Column(name = "auth_provider", nullable = true)
  private AuthProvider authProvider;

  @Column(name = "google_id", unique = true)
  private String googleId;

  @Column(name = "created_at", nullable = false, updatable = false)
  private LocalDateTime createdAt;
}