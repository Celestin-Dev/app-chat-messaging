package com.celestin.appchat.config;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SwaggerConfig {

    @Bean
    public OpenAPI openAPI() {
        return new OpenAPI()
                //  Informations générales 
                .info(new Info()
                        .title("MadaBus API")
                        .description("API REST pour la gestion des bus urbains de Fianarantsoa")
                        .version("1.0.0")
                        .contact(new Contact()
                                .name("Celestin Nomenjanahary")
                                .email("avotranomena04@gmail.com")
                        )
                )
                //  Sécurité JWT 
                .addSecurityItem(new SecurityRequirement()
                        .addList("Bearer Authentication")
                )
                .components(new Components()
                        .addSecuritySchemes("Bearer Authentication",
                                new SecurityScheme()
                                        .type(SecurityScheme.Type.HTTP)
                                        .scheme("bearer")
                                        .bearerFormat("JWT")
                                        .description("Entrer le token JWT")
                        )
        );
    }
}