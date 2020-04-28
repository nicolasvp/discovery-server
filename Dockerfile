FROM maven:3.5-alpine as builder
COPY . /microservice
RUN cd /microservice && mvn clean package -DskipTests=true

FROM openjdk:8-alpine
MAINTAINER nicolasverapalominos@gmail.com
LABEL version=1.0
LABEL description="Discovery service, eureka"
LABEL vendor="Nicolas"
COPY --from=builder /microservice/target/discovery-server-0.0.1-SNAPSHOT.jar /opt/discovery-server.jar
EXPOSE 2222
CMD java -jar /opt/discovery-server.jar