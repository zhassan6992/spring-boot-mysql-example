FROM maven:latest as mvn
WORKDIR /maha
COPY . .

RUN ["mvn","clean","install","-T100","-DskipTests"]

FROM openjdk:latest
RUN mkdir -p /maha/app
COPY --from=mvn /maha/target/spring-boot-mysql-0.0.1-SNAPSHOT.jar /maha/app/
WORKDIR /maha/app/
EXPOSE 8080

CMD ["java", "-jar","spring-boot-mysql-0.0.1-SNAPSHOT.jar"]

