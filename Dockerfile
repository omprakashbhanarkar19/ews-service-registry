FROM openjdk:17-jdk-alpine

ARG artifact=target/ews-service-registry-0.0.1-SNAPSHOT.jar

WORKDIR /root/workspace/Docker-project/ews-service-registry

COPY ${artifact} ews-service-registry-0.0.1-SNAPSHOT.jar

#EXPOSE 8761

CMD ["java", "-jar", "ews-service-registry-0.0.1-SNAPSHOT.jar"]