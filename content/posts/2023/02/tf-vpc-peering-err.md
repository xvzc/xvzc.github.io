---
title: Terraform AWS 계정 간 VPC Peering 생성할 때 에러
date: 2023-02-13T21:31:41+09:00
draft: false
tags:
  - terraform
  - aws
  - troubleshoot
---
테라폼으로 서로 다른 계정간 VPC Peering Connection을 맺을 때 `Error: Unable to modify EC2 VPC Peering Connection Options`라는 에러가 출력되는 경우가 있습니다. 이번 포스트에서는 해당 이슈의 원인과 해결 방안에 대해 알아보도록 하겠습니다.
<!--more-->
# 문제 상황

> Error: Unable to modify EC2 VPC Peering Connection Options. EC2 VPC Peering Connection(pcx-xxxxxxxxx)
> Please set the `auto_accept` attribute to `true` or activate the EC2 VPC Peering Connection manually.

# 원인

언뜻 보기엔 단순히 `auto_accept` 옵션을 `true` 로 할당하라는 안내 메시지인 것 같지만 서로 다른 계정 사이에서는 `auto_accept` 옵션이 동작하지않습니다. 조금 더 조사를 해본 결과 inner block인 `accepter`, `requester` block이 원인이였다는 것을 알 수 있었습니다.

# 해결

몇번의 apply 실패 과정을 통해 `aws_vpc_peering_connection` 에 최소한의 옵션만 남겨두고 다 지워보았습니다.

```terraform
resource "aws_vpc_peering_connection" "to_owner" {
  vpc_id        = module.network.vpc.id
  peer_owner_id = owner.account_id
  peer_vpc_id   = owner.vpc_id
  auto_accept   = false

  # accepter {
  #   allow_remote_vpc_dns_resolution = true
  # }

  # requester {
  #   allow_remote_vpc_dns_resolution = true
  # }

  tags = {
    Name = "vpc-peer-to-owner"
  }
}
```

이후 apply는 성공합니다. 문제가 발생하는 부분은 `accepter`, `requester` 설정이였습니다. 에러로그와 함께 생각해보면, `aws_vpc_peering_connection` 블럭은 내부적으로 connection을 생성한 뒤 `accepter`, `requester` 옵션을 변경하는 API를 호출한다고 추측할 수 있습니다. 따라서 ”`Active` 상태가 아닌 Peering에 대한 옵션 수정을 수행할 수 없다” 가 위 에러메시지의 정확한 의미라고 볼 수 있습니다.

문제가 발생한 부분은 아래와 같이 별도의 리소스 블럭으로 변경할 수 있습니다.

```terraform
resource "aws_vpc_peering_connection_options" "to_owner" {
  vpc_peering_connection_id = aws_vpc_peering_connection.to_owner.id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}
```

테라폼을 활용하여 서로 다른 계정간 Peering을 하기 위해선 다음과 같은 단계로 여러번에 나누어 apply를 해야합니다.

1. 최소한의 설정으로 Peering Connection Request.
2. Accepter 계정에서 Connection 수락.
3. 라우팅 설정 및 dns resolution 설정.