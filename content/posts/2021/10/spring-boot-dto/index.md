---
title: "Spring Boot 가이드: DTO"
date: 2021-10-05T21:31:41+09:00
draft: false
tags:
  - spring-boot
  - java
---
이번 포스트에서는 Spring Boot에서 DTO의 사용법에 대해 알아보겠습니다.
<!--more-->
Github에서 샘플 프로젝트의 전체 코드를 확인할 수 있습니다.

[GitHub - xvzc/spring-test: spring test repo](https://github.com/xvzc/spring-test)

---

## 요청 DTO

요청과 응답에 관련된 DTO의 경우, **메인 DTO 클래스의 서브 클래스**로 정의하면 DTO 클래스들을 조금 더 깔끔하게 관리할 수 있습니다. Post 요청의 DTO는 추가적으로 DTO를 Entity로 변환하는 로직을 `toEntity()` 메서드로 감싸주면 더욱 보기좋은 코드를 작성할 수 있습니다.

> Mockito 기반의 Unit Test를 진행할 때 Equals를 사용해서 Assertion을 하는 경우가 많기 때문에 equals()와 hashcode()를 오버라이드 합니다.

```java
package com.example.project.domain.user.dto;

import com.example.project.domain.user.entity.Email;
import com.example.project.domain.user.entity.User;
import lombok.*;

public class UserDto {

    @Getter
    @Builder
    @EqualsAndHashCode
    public static class AddRequest {
        private String username;
        private String password;
        private String nickname;
        private String bio;
        private String email;

        public User toEntity() {
            return User.builder()
                    .username(username)
                    .password(password)
                    .nickname(nickname)
                    .bio(bio)
                    .email(Email.of(email))
                    .build();
        }
    }

	... // 생략

}
```

## 응답 DTO

응답 DTO의 경우 엔티티를 인자로 받아 응답 객체로 반환하는 `of()` 메서드를 구현하면 서비스 레이어에서 더욱 보기좋은 코드를 작성할 수 있습니다.

```java
package com.example.project.domain.user.dto;

import com.example.project.domain.user.entity.Email;
import com.example.project.domain.user.entity.User;
import lombok.*;

public class UserDto {
		... // 생략

    @Getter
    @Builder
    @EqualsAndHashCode
    public static class Response {
        private String username;
        private String nickname;
        private String bio;
        private String email;

        public static Response of(final User user) {
            return Response.builder()
                    .username(user.getUsername())
                    .nickname(user.getNickname())
                    .bio(user.getBio())
                    .email(user.getEmail().getValue())
                    .build();
        }
    }
}
```