---
title: AWS ECR에 도커 이미지를 올리는 방법
date: 2022-12-27T21:31:41+09:00
draft: false
tags:
  - aws
---
이번 포스트에서는 AWS ECR에 도커 이미지를 Push 하는 방법에 대해서 알아봅시다.
<!--more-->
# Install AWS CLI

우선 아래 링크를 참고하여 `AWS CLI` 를 설치합니다.

[Installing or updating the latest version of the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)


# AWS CLI 설정

AWS CLI에 계정정보를 설정하기 위해 다음 명령어를 실행하고 정보를 입력합니다.

```bash
aws configure
```

**Command line output**

```
AWS Access Key ID [None]: IAM_AWS_ACCESS_KEY
AWS Secret Access Key [None]: IAM_AWS_SECRET_KEY
Default region name [None]: AWS_REGION_NAME
Default output format [None]: json
```

---

# Login to Docker

`Docker CLI` 에 로그인 하기위해 다음 명령어를 실행합니다.

> `{aws_account_id}` 는 ‘-’ 를 제외하고 숫자만을 입력해주세요

```bash
aws ecr get-login-password --region {aws_region} | docker login --username AWS --password-stdin {aws_account_id}.dkr.ecr.{aws_region}.amazonaws.com
```

**Command line output**

```
Login Succeeded
```

# Get the image id

먼저 아래 명령어를 통해 ECR에 push 하고자하는 이미지의 ID를 확인합니다.

```bash
docker images
```

---

# Image Tag 추가

아래 명령어를 실행하여 해당 이미지의 태그를 설정합니다.

`ECR URI`는 `AWS Conolse` → `Amazon Elastic Container Registry` → `Repositories` 에서 확인할 수 있습니다.

```bash
docker tag {image_id} {ECR_URI}:{TAG}
```

---

# 이미지 Push

마지막으로 아래 명령어를 실행하여 ECR에 push 합니다.

```bash
docker push {ECR_URI}:{TAG}
```
