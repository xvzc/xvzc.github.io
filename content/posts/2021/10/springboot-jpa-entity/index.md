---
title: "Spring Boot 가이드: Entity"
date: 2021-10-01T21:31:41+09:00
draft: false
tags:
  - java
  - spring-boot
---
이번 포스트에서는 Spring Boot에서 Entity의 간단한 사용법에 대해서 알아보겠습니다.
<!--more-->

Github에서 샘플 프로젝트의 전체 코드를 확인할 수 있습니다.

[GitHub - xvzc/spring-test: spring test repo](https://github.com/xvzc/spring-test)

---

# Sample

다음은 샘플 엔티티 `USER`의 코드입니다.

```java
@Entity
@Table(name = "USER")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@EqualsAndHashCode
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 30)
    private String username;

    @Valid
    @Embedded
    private Password password;

    @Column(nullable = false, unique = true, length = 30)
    private String nickname;

    @Column(nullable = false, length = 191)
    private String bio;

    @Valid
    @Embedded
    private Email email;
    /**
     * 만약 컬럼명이 Email 클래스에 정의된 것과 다르다면
     * @AttributeOverride(name="value", column=@Column(name="mail"))로 덮어쓰기 가능
     */

    @CreatedDate
    private LocalDateTime created;

		... // 생략
}
```

`Password` 의 경우 해당 컬럼만의 특정한 기능이 필요합니다. 예를들면 암호화, 해싱, 단일 컬럼 업데이트 등이 이에 속합니다. 이러한 경우 새로운 클래스를 정의해서 **Embeded 컬럼**으로 사용하는 것이 좋습니다.

# JPA Auditing

JPA Auditing을 사용하면 생**성 및 수정 날짜를 직접 입력하지 않고도 자동으로 최신화** 시킬 수 있습니다. 아래는 샘플 엔티티인 Post 클래스에서 JPA Auditing을 사용한 예시입니다.

```java
@Entity
@Table(name = "POST")
public class Post {

		... // 생략

    @CreatedDate
    private LocalDateTime created;

    @LastModifiedDate
    private LocalDateTime modified;

    @PrePersist
    public void onPrePersist(){
        this.created = LocalDateTime.parse(
                LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")),
                DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")
        );
        this.modified = this.created;
    }

    @PreUpdate
    public void onPreUpdate(){
        this.modified= LocalDateTime .parse(
                        LocalDateTime.now() .format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")),
                        DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")
                );
    }
}
```