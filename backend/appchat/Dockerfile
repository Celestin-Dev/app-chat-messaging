# Étape 1 : build du jar avec Maven
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app

# Copie uniquement le pom.xml
COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src
RUN mvn package -DskipTests -B

# Étape 2 : image finale, légère, sans Maven
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]