---
title: "Spring Boot 가이드: Controller"
date: 2021-10-02T21:31:41+09:00
draft: false
tags:
  - spring-boot
  - java
---
이번 포스트에서는 Spring Boot에서 Controller의 사용법에 대해 알아보겠습니다.
<!--more-->
Github에서 샘플 프로젝트의 전체 코드를 확인할 수 있습니다.

[GitHub - xvzc/spring-test: spring test repo](https://github.com/xvzc/spring-test)

---

# 요청

Path variable에 포함되지 않는 나머지 Json 데이터는 `RequestBody`로 받을 수 있습니다.

```java
@AllArgsConstructor
@RestController
@RequestMapping("/users")
public class UserController {
    @PutMapping("/{id}")
    public SingleResponse updateUser(@RequestBody final UserDto.UpdateRequest dto, @PathVariable final Long id) {
			...
    }
}
```

# 전체 코드

컨트롤러는 특별한 경우가 아니라면 한 두줄 이내로 작성하는 것이 좋습니다.

```java
@AllArgsConstructor
@RestController
@RequestMapping("/users")
public class UserController {
    UserService userService;

    @GetMapping("{id}")
    public UnitResponse<UserDto.Response> getUser(@PathVariable final Long id) {
        return UnitResponse.of(userService.getUser(id));
    }

    @GetMapping("")
    public ListResponse<UserDto.Response> getUserList() {
        return ListResponse.of(userService.getUserList());
    }

    @PostMapping("")
    public UnitResponse<UserDto.Response> addUser(@RequestBody final UserDto.AddRequest dto) {
        return UnitResponse.of(userService.addUser(dto));
    }

    @PutMapping("/{id}")
    public UnitResponse<UserDto.Response> updateUser(
            @RequestBody final UserDto.UpdateRequest dto,
            @PathVariable final Long id
    ) {
        return UnitResponse.of(userService.updateUser(dto, id));
    }
}
```