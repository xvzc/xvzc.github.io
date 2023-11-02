# Spring Boot 가이드: 값 검증

이번 포스트에서는 Spring Boot에서 값을 검증하는 방식에 대해 알아보겠습니다.
<!--more-->
Github에서 샘플 프로젝트의 전체 코드를 확인할 수 있습니다.

[GitHub - xvzc/spring-test: spring test repo](https://github.com/xvzc/spring-test)

---

# 값 검증의 방식

값 검증에 주로 사용되는 Bean Validation에는 크게 두가지 방식이 있습니다.

- 요청 Dto 검증

요청 Dto 검증은 Controller에 요청된 RequestDto를 검증하는 방식입니다. 이 방식은 Controller에서 Service로 값을 넘겨주기 직전에 값을 검증합니다.

```java
@PostMapping("")
public UnitResponse<UserDto.Response> addUser(@Valid @RequestBody final UserDto.AddRequest dto) {
    return UnitResponse.of(userService.addUser(dto));
}
```

위와 같이 `@Valid` 애너테이션을 사용하면 Dto에 정의된 Validation annotaion을 참조하여 값을 검증합니다. 아래는 `UserDto.AddRequest`의 예시입니다.

```java
... // 생략
public static class AddRequest {
        private String username;
        @Size(min = 6, max = 20)
				... // 생략
        @Email
        private String email;
    }
```

위에 보이는 것 처럼 `@Size` , `@Email` 애너테이션에 따라 값이 검증되며 조건에 맞지 않는 경우에는 예외가 발생하게됩니다. Dto 값 검증에서 발생한 예외는 필드 정보 등이 포함되어있어 에러 응답에 포함시켜서 응답할 수 있습니다. 발생한 예외는 `GlobalExceptionHandler`에서 처리됩니다.

- 엔티티 컬럼 검증

엔티티 컬럼 검증 방식은 엔티티 객체에 값을 대입할 때 수행됩니다. 다음은 User 클래스의 예시입니다.

```java
@Entity
@Table(name = "USERS")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@EqualsAndHashCode
public class User {
		... // 생략

    @Size(min = 6, max = 12)
    @Column(nullable = false, unique = true, length = 30)
    private String username;

    @Valid
    @Embedded
    private Password password;

		... // 생략

    @Valid
    @Embedded
    private Email email;
    /**
     * 만약 컬럼명이 Email 클래스에 정의된 것과 다르다면
     * @AttributeOverride(name="value", column=@Column(name="mail"))로 덮어쓰기 가능
     */

		... // 생략
}
```

엔티티 값 검증에 실패하면 `ConstraintViolationException` 이 발생합니다. 해당 예외는 엔티티 레벨에서 발생한 예외이므로 필드 정보가 따로 포함되어있지 않습니다.

`@Emebeded` 컬럼의 경우 **부모 엔티티에 `@Valid` 애너테이션을 사용**해야만 검증이 수행됩니다. 아래는 Password 클래스의 예시 입니다.

```java
@Embeddable
@Getter
@EqualsAndHashCode
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Password {
    @Size(min = 6, max = 20)
    @Column(name = "password", nullable = false, unique = true)
    private String value;

    @Builder
    protected Password(String value) {
        this.value = value;
    }

    public static Password of(String password) {
        return new Password(password);
    }
}
```
