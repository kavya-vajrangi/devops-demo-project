FROM openjdk:21-jdk-slim

WORKDIR /app

COPY target/demo-app-1.0.jar app.jar

CMD ["java", "-jar", "app.jar"]
