# ===== STAGE 1: Build =====
FROM gradle:8.4-jdk21 AS builder
WORKDIR /app

# Copiem fișierele Gradle și rezolvăm dependențele mai întâi (cache friendly)
COPY build.gradle settings.gradle gradlew ./
COPY gradle ./gradle
RUN ./gradlew dependencies --no-daemon || return 0

# Copiem restul codului și construim aplicația
COPY . .
RUN ./gradlew bootJar --no-daemon

# ===== STAGE 2: Run =====
FROM eclipse-temurin:21-jdk-jammy
WORKDIR /app

# Copiem doar jar-ul final (din stage-ul anterior)
COPY --from=builder /app/build/libs/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
