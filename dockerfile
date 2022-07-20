FROM maven:3.6.3-openjdk-14-slim AS build
RUN mkdir -p /workspace
WORKDIR /workspace
COPY pom.xml /workspace
COPY src /workspace/src
RUN mvn -B package -Pdev --file pom.xml -DskipTests

FROM openjdk:14-slim
COPY --from=build /workspace/target/*.jar app/
ENTRYPOINT ["java","-jar","app/app.jar"]
