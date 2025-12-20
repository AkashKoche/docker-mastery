FROM gradle:7.6-jdk17-alpine AS builder

WORKDIR /app

COPY build.gradle .
COPY setting.gradle .
COPY gradle.properties .
COPY src ./src

RUN gradle build --no-daemon -x test

FROM eclipse-temurin:17-jre-alpine

RUN apk add --no-cache curl

RUN addgroup -S spring && adduser -s spring -G spring

RUN mkdir -p /app && chown spring:spring /app
WORKDIR /app

COPY --from=builder --chown=spring:spring /app/build/libs/*.jar app.jar

USER spring

ENV JAVA_OPTS="-X:+UseContainerSupport -XX:MaxRAMPercentage=75.0 -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:ParallelGCThreads=2 -XX:ConcGCThreads=2 -Djava.security.egd=file:/dev/./urandom"

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:8080/actuator/health || exit 1

ENTERYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
