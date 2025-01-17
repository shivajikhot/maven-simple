# Use an official OpenJDK runtime as the base for the final image
FROM openjdk:17-jdk-slim
 
# Set the working directory inside the container
WORKDIR /app
 
# Copy the packaged JAR file from the build stage
COPY target/*.jar app.jar
 
# Expose the application port (adjust if needed)
EXPOSE 8080
 
# Run the application
CMD ["java", "-jar", "app.jar"]
