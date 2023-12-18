# Spring Boot 가이드: Service

이번 포스트에서는 Spring Boot에서 Service의 사용법에 대해 알아보겠습니다..
<!--more-->

Github에서 샘플 프로젝트의 전체 코드를 확인할 수 있습니다.

[GitHub - xvzc/spring-test: spring test repo](https://github.com/xvzc/spring-test)

---

## 객체 지향적 개발

도메인과 관련된 로직은 최대한 도메인 영역에 숨기는 것이 좋습니다.

```java
@Transactional
public UserDto.Response updateUser(final UserDto.UpdateRequest dto, final Long id) {
    User user = userRepository.findById(id)
            .orElseThrow(() -> new ResourceNotFoundException(ErrorCode.USER_NOT_FOUND));

    user.update(dto);               // 엔티티에 직접 정의한 메서드

    return UserDto.Response.of(user);
}
```

# Interface 의존성 주입 방식의 개선 방안

기존 Interface 의존성 주입 방식의 경우 메서드를 변경할 때 인터페이스와 구현체를 둘다 바꿔야 한다는 번거로움이 있습니다. **단일 서비스 인터페이스에 하나의 구현체만 존재한다면, 인터페이스 의존성 주입방식을 사용하지 않습니다.** 다형성을 활용해야하는 상황이 생긴다면 해당 기능만 인터페이스로 분리하는 것도 좋은 아이디어가 될 수 있습니다.

```java
@Service
@AllArgsConstructor
public class UserService {
	...
    public UserDto.Response getUser(final Long id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException(ErrorCode.USER_NOT_FOUND));

        return UserDto.Response.of(user);
    }
	...
}
```
