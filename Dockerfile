# Use a minimal base image for building
FROM openjdk:11-jdk-slim AS build

# Set the working directory
WORKDIR /app

# Copy only the build files needed for dependency resolution
COPY build.gradle settings.gradle ./

# Download and resolve dependencies using the Gradle Wrapper
COPY gradlew .
COPY gradle gradle

# Give execute permission to the Gradle Wrapper
RUN chmod +x gradlew

# Run Gradle task to download dependencies
RUN ./gradlew dependencies

# Copy the rest of the source code
COPY . .

# Give execute permission to the Gradle Wrapper for the gradle user
RUN chmod +x ./gradlew

# Run the Gradle build explicitly setting the output directory
RUN ./gradlew build --stacktrace --no-daemon -PoutputDir=/app/build/libs

# Use a minimal base image for the runtime
FROM adoptopenjdk:11-jre-hotspot

# Set the working directory
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/build/libs/demo-0.0.1-SNAPSHOT.jar app.jar

# Expose the port your app runs on
EXPOSE 8080

# Define the command to run your application
CMD ["java", "-jar", "app.jar"]
