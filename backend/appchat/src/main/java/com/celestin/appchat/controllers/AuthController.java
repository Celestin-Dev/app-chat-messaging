package com.celestin.appchat.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.celestin.appchat.dtos.auth.GoogleAuthRequest;
import com.celestin.appchat.dtos.auth.LoginRequest;
import com.celestin.appchat.dtos.auth.ResponseRequest;
import com.celestin.appchat.dtos.auth.RegisterRequest;
import com.celestin.appchat.services.AuthService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
@Tag(name = "Authentication", description = "Register et Login")
public class AuthController {

    private final AuthService authService;
    @PostMapping("/register")
    @Operation(summary = "Créer un compte", description = "Inscription d'un nouvel utilisateur")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Compte créé — token retourné"),
        @ApiResponse(responseCode = "400", description = "Données invalides")
    })
    public ResponseEntity<ResponseRequest> register(@Valid @RequestBody RegisterRequest request) {
        return ResponseEntity.ok(authService.register(request));
    }

    @PostMapping("/login")
    @Operation(summary = "Se connecter", description = "Retourne un token JWT")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Connexion réussie"),
        @ApiResponse(responseCode = "403", description = "Identifiants incorrects")
    })
    public ResponseEntity<ResponseRequest> login(@Valid @RequestBody LoginRequest request) {
        return ResponseEntity.ok(authService.login(request));
    }

    @PostMapping("/google")
    @Operation(summary = "Se connecter avec Google", description = "Retourne un token JWT")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Connexion réussie"),
        @ApiResponse(responseCode = "403", description = "Identifiants incorrects")
    })
    public ResponseEntity<ResponseRequest> loginWithGoogle(@Valid @RequestBody GoogleAuthRequest request) {
        return ResponseEntity.ok(authService.loginWithGoogle(request));
    }
    
}