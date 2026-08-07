# Stage 1: Build the application
FROM maven:3.8.4-openjdk-17-slim AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/KodewalaAcademy-1.0-SNAPSHOT.war app.war
EXPOSE 8080
ENTRYPOINT ["java", "-Dserver.port=${PORT:-8080}", "-jar", "app.war"]
