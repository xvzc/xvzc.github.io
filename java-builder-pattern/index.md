# Spring Boot 가이드: Java Builder Pattern

이번 포스트에서는 Java Builder Pattern과 그 사용법에 대해서 알아보겠습니다.
<!--more-->

Github에서 샘플 프로젝트의 전체 코드를 확인할 수 있습니다.

[GitHub - xvzc/spring-test: spring test repo](https://github.com/xvzc/spring-test)

---

## 생성자 사용의 단점

```java
@Getter
@Builder
public class Person {
		String name;
		String city;
		int age;
}
```

위와 같은 Person 클래스의 객체를 생성할 때 **생성자**를 사용한다면 다음과 같습니다.

```java
new Person("Jerry", "Seoul", 29);
```

이 방식은 어떤 값이 어느 변수에 들어가는지 직관적으로 확인할 수 없다는 단점이 있습니다.

## 빌더 패턴

다음과 같이 빌더 패턴을 사용한다면 코드를 훨씬 쉽게 이해할 수 있습니다.

```java
Person person = new Person()
             .Builder()
             .name("Jerry")
             .city("Seoul")
             .age(29)
             .build();
```

> 물론 **Setter**를 사용하는 방법도 있지만 멀티스레드 환경에서 동시성과 관련된 문제가 발생할 수 있기 때문에 빌더 패턴을 사용하는 것이 더욱 안전합니다.
