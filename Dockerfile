# Use an official Maven image as the base image
FROM maven:3.8.5-openjdk-17 AS build
 
# Set the working directory inside the container
WORKDIR /app
 
# Copy the pom.xml file and download dependencies (this step is cached)
COPY pom.xml .
RUN mvn dependency:go-offline -B
 
# Copy the entire project into the container
COPY . .
 
# Build the application
RUN mvn package -DskipTests
 
# Use an official OpenJDK runtime as the base for the final image
FROM openjdk:17-jdk-slim
 
# Set the working directory inside the container
WORKDIR /app
 
# Copy the packaged JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar
 
# Expose the application port (adjust if needed)
EXPOSE 8080
 
# Run the application
CMD ["java", "-jar", "app.jar"]
