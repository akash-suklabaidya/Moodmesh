## Use an official OpenJDK runtime as a parent image
#FROM eclipse-temurin:17-jdk-jammy
#
## Set the working directory in the container
#VOLUME /temp
#
## Copy the application JAR file into the container
#COPY target/*.jar app.jar
#
## Expose the port that your Spring Boot application will run on
#EXPOSE 8080
#
## Specify any environment variables if needed
## ENV VARIABLE_NAME=value
#
## Command to run the application when the container starts
#CMD ["java", "-jar", "/app.jar"]



# Stage 1: Build the application
FROM maven:3.8.5-eclipse-temurin-17 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the project files into the container
COPY . .

# Package the application (skip tests to speed up the build process)
RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM eclipse-temurin:17-jdk-jammy

# Set the working directory in the container
WORKDIR /app

# Copy the packaged JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the port that your Spring Boot application will run on
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "app.jar"]
