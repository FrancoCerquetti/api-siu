FROM gradle:7.2.0-jdk11 AS build
WORKDIR /src
# Dependency resolution
COPY build.gradle.kts .
RUN gradle --no-daemon dependencies
# Build
COPY . .
RUN gradle --no-daemon build

FROM amazoncorretto:11.0.13-alpine3.14
EXPOSE 8080:8080
COPY --from=build /src/build/libs/*.jar /app/app.jar
ENTRYPOINT ["java", "-jar", "/app/app.jar"]