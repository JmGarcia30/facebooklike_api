# Build stage
# Using a Maven image with Temurin JDK 21
FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Package stage
# Using a Temurin JDK 21 Alpine image for a smaller runtime environment
FROM eclipse-temurin:21-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/facebooklike-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]