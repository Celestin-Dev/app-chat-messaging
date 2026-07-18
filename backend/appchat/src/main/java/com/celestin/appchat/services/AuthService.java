package com.celestin.appchat.services;

import java.util.Optional;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.celestin.appchat.config.JwtUtils;
import com.celestin.appchat.dtos.auth.GoogleAuthRequest;
import com.celestin.appchat.dtos.auth.LoginRequest;
import com.celestin.appchat.dtos.auth.ResponseRequest;
import com.celestin.appchat.dtos.auth.RegisterRequest;
import com.celestin.appchat.models.User;
import com.celestin.appchat.repositories.UserRepository;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.celestin.appchat.enums.AuthProvider;
import com.celestin.appchat.enums.Role;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserRepository usersRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtils jwtUtils;
    private final AuthenticationManager authenticationManager;
    private final GoogleIdTokenVerifier googleIdTokenVerifier;

    // ─── Register ─────────────────────────────────────────────────────────

    public ResponseRequest register(RegisterRequest request) {

        // 1. Vérifier si username ou email déjà pris
        if (usersRepository.existsByUsername(request.getUsername())) {
            throw new RuntimeException("Username déjà utilisé");
        }
        if (usersRepository.existsByEmail(request.getEmail())) {
            throw new RuntimeException("Email déjà utilisé");
        }

        // 2. Créer et sauvegarder l'utilisateur
        User user = new User();
        user.setUsername(request.getUsername());
        user.setEmail(request.getEmail());
        user.setPassword(passwordEncoder.encode(request.getPassword()));
        user.setRole(Role.USER);
        user.setAuthProvider(AuthProvider.LOCAL);
        user.setCreatedAt(java.time.LocalDateTime.now());
        //user.setPhone("+261341013246");

        usersRepository.save(user);

        // 3. Générer et retourner le token
        String token = jwtUtils.generateToken(user.getUsername());
        return new ResponseRequest(token);
    }

    // ─── Login ────────────────────────────────────────────────────────────

    public ResponseRequest login(LoginRequest request) {

        // 1. Spring Security vérifie username + password automatiquement
        //    Lance une exception si les credentials sont incorrects
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getUsername(),
                        request.getPassword()
                )
        );

        // 2. Charger l'utilisateur et générer le token
        Optional<User> userOptional = usersRepository.findByUsername(request.getUsername());
        User user = userOptional.orElseThrow(() -> new RuntimeException("Utilisateur introuvable"));

        String token = jwtUtils.generateToken(user.getUsername());
        return new ResponseRequest(token);
    }


    // ─── Connexion avec Google ────────────────────────────────────────────────
    public ResponseRequest loginWithGoogle(GoogleAuthRequest request) {
        try {
            GoogleIdToken idToken = verifyGoogleToken(request.getToken());
            if (idToken == null) {
                throw new RuntimeException("Connexion Google invalide");
            }

            GoogleIdToken.Payload payload = idToken.getPayload();
            String googleId = payload.getSubject(); // rcupere l'identifiant unique de l'utilisateur Google
            String email = payload.getEmail();
            Boolean emailVerified = Boolean.valueOf(payload.getEmailVerified());
            String name = (String) payload.get("name");

            if(email == null || !emailVerified) {
                throw new RuntimeException("Informations utilisateur Google non valides");
            }

            // Vérifier si l'utilisateur existe déjà
            Optional<User> existingByGoogleId = usersRepository.findByGoogleId(googleId);
            User user;
            if (existingByGoogleId.isPresent()) {
                user = existingByGoogleId.get();
                return new ResponseRequest(jwtUtils.generateToken(user.getUsername()));
            }

            // Vérifier si l'utilisateur existe déjà par email
            Optional<User> existingByEmail = usersRepository.findByEmail(email);
            if (existingByEmail.isPresent()) {
                user = existingByEmail.get();
                user.setGoogleId(googleId);
                usersRepository.save(user);
                return new ResponseRequest(jwtUtils.generateToken(user.getUsername()));
            }

            // Créer un nouvel utilisateur
            User newUser = new User();
            newUser.setUsername(generateUniqueUsername(email, name));
            newUser.setEmail(email);
            newUser.setGoogleId(googleId);
            newUser.setRole(Role.USER);
            newUser.setPassword(null); // Pas de mot de passe pour les utilisateurs Google
            newUser.setAuthProvider(AuthProvider.GOOGLE);
            newUser.setCreatedAt(java.time.LocalDateTime.now());
            usersRepository.save(newUser);
            return new ResponseRequest(jwtUtils.generateToken(newUser.getUsername()));
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la connexion avec Google: " + e.getMessage());
        }
    }

    private GoogleIdToken verifyGoogleToken(String token) {
        try {
            GoogleIdToken idToken = googleIdTokenVerifier.verify(token);
            if (idToken == null) {
                throw new RuntimeException("Connexion Google invalide ou expirée");
            }
            return idToken;
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la vérification du token Google: " + e.getMessage());
        }
    }

    private String generateUniqueUsername(String email, String name) {
        String baseUsername = (name != null && !name.isBlank()) 
                        ? name.replaceAll("\\s+", "") 
                        : email.split("@")[0];
        String username = baseUsername;
        int counter = 1;

        while (usersRepository.existsByUsername(username)) {
            username = baseUsername + counter;
            counter++;
        }

        return username;
    }

}