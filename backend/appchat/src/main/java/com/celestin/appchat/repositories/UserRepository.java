package com.celestin.appchat.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.celestin.appchat.models.User;


public interface UserRepository extends JpaRepository<User, Long> {

  // Récupère un utilisateur par son username (ex: pour le login)
  Optional<User> findByUsername(String username);

  // Récupère un utilisateur par son email (ex: login par email, mot de passe oublié)
  Optional<User> findByEmail(String email);

  // Récupere un utilsateur compte google par son id
  Optional<User> findByGoogleId(String googleId);

  // Permet de vérifier l'unicité à l'inscription sans charger toute l'entité
  boolean existsByUsername(String username);

  boolean existsByEmail(String email);

  // Utile si tu autorises la connexion via username OU email dans le même champ
  Optional<User> findByUsernameOrEmail(String username, String email);

}
