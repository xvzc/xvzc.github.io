# Spring Boot 가이드: 예외 처리

이번 포스트에서는 Spring Boot 에서 예외처리를 하는 방법에 대해서 알아보겠습니다.
<!--more-->
Github에서 샘플 프로젝트의 전체 코드를 확인할 수 있습니다.

[GitHub - xvzc/spring-test: spring test repo](https://github.com/xvzc/spring-test)

---

## Controller Advice

아래 코드는 서비스 레이어에서 발생하는 모든 예외를 처리하는 `GlobalExceptionHandler` 입니다. 개발자가 처리하지 못한 예외가 발생하는 경우, Exception 객체의 핸들러가 동작합니다. 이상적인 ****목표는 가능한 모든 예외를 핸들링 하여 `internal server error`를 응답하지 않는 것입니다.

```java
@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    /** Custom Exceptions START */

    // 자원을 찾을 수 없는 경우
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(ResourceNotFoundException.class)
    protected ErrorResponse handleResourceNotFoundException(ResourceNotFoundException e) {
        log.error("handleMethodArgumentNotValidException", e);
        return ErrorResponse.of(BasicError.of(e.errorCode));
    }

    // Unique
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(AlreadyExistsException.class)
    protected ErrorResponse handleAlreadyExistsException(AlreadyExistsException e) {
        log.error("handleAlreadyExistsException", e);
        return ErrorResponse.of(BasicError.of(e.errorCode));
    }

    /** Custom Exceptions END*/

    /** Built in Exceptions START */

    // Bean Validation 실패
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(MethodArgumentNotValidException.class)
    protected ErrorResponse handleMethodArgumentNotValidException(MethodArgumentNotValidException e) {
	    ...
		}

    // Bean Validation 실패
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(DataIntegrityViolationException.class)
    protected ErrorResponse handleDataIntegrityViolationException(DataIntegrityViolationException e) {
			...
    }

		...

    // 나머지 모든 예외들
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    @ExceptionHandler(Exception.class)
    protected ErrorResponse handleException(Exception e) {
        log.error("handleEntityNotFoundException", e);
        return ErrorResponse.of(BasicError.of(ErrorCode.INTERNAL_SERVER_ERROR));
    }

    /** Built in Exceptions END */
}
```

## ErrorCode

`ErrorCode` 클래스는 에러 메시지와 코드를 정의합니다.

```java
@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum ErrorCode {

    // GLOBAL
    INTERNAL_SERVER_ERROR(500, "G-000", "Server Error"),
    INVALID_INPUT_VALUE(400, "G-001", " Invalid Input Value"),
    METHOD_NOT_ALLOWED(405, "G-002", " Method not allowed"),
    INVALID_TYPE_VALUE(400, "G-003", " Invalid Type Value"),
    ACCESS_DENIED(403, "G-004", "Access is Denied"),

    // User
    EMAIL_DUPLICATION(400, "USER-001", "Email already exists"),
    LOGIN_FAILED(400, "USER-002", "Login failed"),
    USER_NOT_FOUND(404, "USER-003", "User not found"),
    USER_DUPLICATION(400, "USER-004", "User Already Exists")
    ; 

    private final String code;
    private final String message;
    private int status;

    ErrorCode(final int status, final String code, final String message) {
        this.status = status;
        this.message = message;
        this.code = code;
    }

    public String getMessage() {
        return this.message;
    }

    public String getCode() {
        return code;
    }

    public int getStatus() {
        return status;
    }
}
```

이런 방식을 사용하게 되면 `UserNotFoundException`, `GrabNotFoundException`등을 다음과 같이 처리할 수 있습니다.

```java
User user = userRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException(ErrorCode.USER_NOT_FOUND));

// OR

Grab grab = grabRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException(ErrorCode.GRAB_NOT_FOUND));
```

## ErrorResponse

효율적인 에러 처리를 위해 예외 응답을 통일합니다.

```java
@Getter
public class ErrorResponse {
    Object data = null;
    BasicError error;

    private ErrorResponse(BasicError error) {
        this.data = null;
        this.error = error;
    }

    public static ErrorResponse of(BasicError error) {
        return new ErrorResponse(error);
    }
}
```

## 에러 객체

아래는 에러 객체의 정의입니다.

```java
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class BasicError {

    private String message;
    private int status;
    private List<FieldError> fields;
    private String code;

    private BasicError(final ErrorCode code, final List<FieldError> fields) {
        this.message = code.getMessage();
        this.status = code.getStatus();
        this.fields = fields;
        this.code = code.getCode();
    }

    private BasicError(final ErrorCode code) {
        this.message = code.getMessage();
        this.status = code.getStatus();
        this.code = code.getCode();
        this.fields = new ArrayList<>();
    }

    public static BasicError of(final ErrorCode code, final BindingResult bindingResult) {
        return new BasicError(code, FieldError.of(bindingResult));
    }

    public static BasicError of(final ErrorCode code) {
        return new BasicError(code);
    }

		...
}
```
