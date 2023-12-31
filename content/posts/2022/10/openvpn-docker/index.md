---
title: Docker를 활용하여 OpenVPN 서버 실행하기
date: 2023-10-27T21:31:41+09:00
draft: false
tags:
  - docker
---
이번 포스트에서는 `Docker`를 활용하여 OpenVPN 서버를 구축하는 방법에 대해서 알아보겠습니다.
<!--more-->
## 환경 변수 등록하기

```bash
export OVPN_DATA="/home/{username}/openvpn"
```

---
## OpenVPN 설정 및 실행

```bash
docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u udp://{HOST}

docker run -v $OVPN_DATA:/etc/openvpn --rm -it kylemanna/openvpn ovpn_initpki

docker run -v $OVPN_DATA:/etc/openvpn -d -p 1194:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn
```

## 사용법

```bash
docker run -v $OVPN_DATA:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full {USER_NAME} nopass # 클라이언트 생성

docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient {USER_NAME}> {USER_NAME}.ovpn # ovpn 파일 가져오기

docker run --rm -it -v $OVPN_DATA:/etc/openvpn kylemanna/openvpn ovpn_revokeclient {USER_NAME} remove # 클라이언트 삭제

docker run -v $OVPN_DATA:/etc/openvpn --rm -it kylemanna/openvpn vi /etc/openvpn/openvpn.conf # OpenVPN 설정 열기
```

## 설정 파일 예시
```bash
...
duplicate-cn # enable multiple connections with sigle cert
max-clients 30
### Route Configurations Below
route 192.168.254.0 255.255.255.0
data
### Push Configurations Below
#push "block-outside-dns"
#push "dhcp-option DNS 8.8.8.8"
#push "dhcp-option DNS 8.8.4.4"
push "comp-lzo no"
push "route {VPC_CIDR} {SUBNET_MASK}"

# example of 10.1.0.0/16
# push "route 10.1.0.0 255.255.0.0"
```