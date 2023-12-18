# Spring boot App을 실행하는 방법들

Spring Boot App을 실행하는 여러가지 방법들에 대해 소개합니다.
<!--more-->
## **IntelliJ**를 활용한 실행

`IntelliJ IDE` 를 사용중이라면 버튼 클릭 한번으로 손쉽게 실행할 수 있습니다.

> VM Option에 새로운 포트를 입력해주면 다른 포트로 인스턴스를 한개 더 띄울 수 있습니다. `-Dserver.port=8081`

## **Maven**을 활용하여 커맨드 라인에서 실행

```java
./mvnw spring-boot:run -Dspring-boot.run.jvaArguments='-Dserver.port=9003'
```

## 빌드를 하고 직접 실행시키는 방법

```
$ ./mvnw clean
$ ./mvnw compile package
$ java -jar -Dserver.port=9004 ./target/user-service-0.0.1-SNAPSHOT.jar

```

> `applicaion.yml` 에서 `server.port=0`을 할당하면 매 실행 마다 **랜덤한 포트**로 실행됩니다.
