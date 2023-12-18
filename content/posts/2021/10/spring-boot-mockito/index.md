---
title: "Spring Boot 가이드: Mockito 기반의 테스트 코드"
date: 2021-10-08T21:31:41+09:00
draft: false
tags:
  - spring-boot
  - java
---
이번 포스트에서는 Java, Spring Boot 환경에서 Mockito 기반의 테스트 코드를 작성하는 방법에 대해서 알아보겠습니다.
<!--more-->
Github에서 샘플 프로젝트의 전체 코드를 확인할 수 있습니다.

[GitHub - xvzc/spring-test: spring test repo](https://github.com/xvzc/spring-test)

---

## Mockito 기반의 단위 테스트

견고한 코딩을 하기위해서 테스트 코드 작성은 필수입니다. 아래는 Mockito 기반의 테스트 코드입니다.

```java
@ExtendWith(MockitoExtension.class)
public class UserServiceTest {
    @InjectMocks
    private UserService userService;

    @Mock
    private UserRepository userRepository;

    @DisplayName("유저 생성")
    @Test
    void addUser() {
        final UserDto.AddRequest dto = UserDto.AddRequest.builder()
                .username("username")
                .password("PaSsWoRd!2!#")
                .nickname("usernick")
                .bio("hello world")
                .email("user@email.com")
                .build();

        User user= dto.toEntity();
        doReturn(user).when(userRepository).save(any(User.class));

        assertThat(userService.addUser(dto), is(UserDto.Response.of(user)));
    }
}
```

Mocking이란 가상의 객체를 생성해 스프링 컨텍스트를 실행하지 않고 테스트하는 환경을 의미합니다. 위 코드에서`doReturn(user).when(userRepository).save(any(User.class));`은 `userRepository`의 구현체를 사용하지 않고 `save()` 메서드의 리턴 값을 가정한다는 의미입니다.

> 이러한 방식을 사용하는 이유는 Service 로직을 테스트 하는 경우에 userRepository의 정상 동작 여부는 상관이 없기 때문입니다. 데이터베이스 연결을 맺지 않고 userRepository가 정상적으로 동작한다는 가정하에 진행한다면 테스트 과정이 경량화 된다는 장점이 있습니다.

## 패키지 목록

아래는 위와 같은 테스트 코드 작성을 위한 패키지 import 목록입니다.

```java
/** Essential imports for Unit tests Start */
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.junit.Assert.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;
import static org.hamcrest.CoreMatchers.is;
/** Essential imports for Unit tests End */
```