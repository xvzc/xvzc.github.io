# AWS VPC 내부에서 Public Rest API Gateway 호출 시 403 Error 발생

이번 포스트에서는 VPC 내부에서 Public API Gateway를 호출할 때 403 응답을 받는 이슈에 대해 알아보고, 해결방안을 알아보겠습니다.
<!--more-->
## 문제 상황

- MSA 환경에서 서비스 목적으로 Public regional API Gateway 를 사용하며, Micro services 간의 통신을 위해 별도의 Private API Gateway를 사용 중입니다.
- 인스턴스 또는 컨테이너 내부에서 Private API Gateway를 사용할 때는 VPC Endpoint를 통해 통신합니다.
- VPN에 연결된 상태에서 Public API Gateway를 호출하면 403 Forbidden Error 응답을 수신합니다.

## 원인
- Route 53 레코드를 확인한 결과, API Gateway domain name이 **CNAME 레코드로 등록**되어있는 것을 확인할 수 있었습니다.
- AWS 문서 [API Gateway에 대한 트래픽을 개인 도메인을 활용해서 라우팅 하는 방법](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-to-api-gateway.html)에 의하면 커스텀 도메인에 대한 Route 53 레코드를 등록할 때 A 레코드를 사용하는 것을 권장하고있습니다.


## 해결
- 일반적으로 A 레코드는 IP 주소만을 입력할 수 있도록 되어있으나 Alias 옵션을 켜면 API Gateway 커스텀 도메인을 등록할 수 있습니다.
- **레코드 네임이 커스텀 도메인과 동일하지 않으면 레코드를 등록할 수 없습니다.**
