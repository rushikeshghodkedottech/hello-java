# FROM openjdk:21-jdk

# WORKDIR /app

# COPY target/*.jar app.jar 

# EXPOSE 8080

# CMD ["java", "-jar", "app.jar"]

# Use maven image to build the application
FROM maven:3.9-eclipse-temurin-24-alpine AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Use JDK for running the application
FROM eclipse-temurin:24-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]