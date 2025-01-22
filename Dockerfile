FROM openjdk:17-jdk-alpine

WORKDIR /root/workspace/Docker-project/ews-service-registry

COPY target/ews-service-registry-0.0.3-SNAPSHOT.jar ews-service-registry-0.0.3-SNAPSHOT.jar

EXPOSE 8761

CMD ["java", "-jar", "ews-service-registry-0.0.3-SNAPSHOT.jar"]