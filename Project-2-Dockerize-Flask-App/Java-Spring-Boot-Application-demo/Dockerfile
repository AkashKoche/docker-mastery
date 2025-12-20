#Build Stage
FROM maven:3.8.5-jdk-11 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package


#Production Stage
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/my-app.jar /app/my-app.jar
EXPOSE 8080
CMD ["java", "-jar", "my-app.jar"]


#HEALTHCHECK --interval=30s --timeout=10s \
  CMD curl -f http://localhost/ || exit 1
