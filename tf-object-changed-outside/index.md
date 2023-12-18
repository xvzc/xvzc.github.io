# Terraform 경고 메시지 "Objects have changed outside of Terraform"

`terraform plan` 을 실행했을 때 변경되지 않은 리소스에 대해 아래와 같은 메시지가 출력되는 현상을 겪었습니다. 이번 포스트에서는 해당 이슈의 원인과 해결 방안에 대해 알아보도록 하겠습니다.
<!--more-->

## 문제 상황

```text
Note: Objects have changed outside of Terraform
...
```

제가 겪은 이슈의 경우에는 보안 그룹 리소스에 대해 해당 메시지가 출력되었습니다.

## 원인

terraform 공식 문서에는 security group 리소스를 생성할 때 `cidr_blocks` 인자를 optional로 규정하고있습니다. 하지만 `cidr_blocks` 에 null 을 할당하게 되면, AWS 콘솔에서는 inbound rule이 존재하지 않는 것으로 확인되었습니다.

따라서 관리되고 있는 `terraform state` 가 실제 상태간에 차이점이 발생하게 되고,

테라폼이 관여하지 않은 변경사항이 발생한 것으로 인식되는 문제였습니다.

## 해결

`cidr_bock` 인자에 값을 할당해서 해결할 수 있었습니다.
