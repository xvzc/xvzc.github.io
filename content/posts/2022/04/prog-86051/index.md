---
title: Programmers 없는 숫자 더하기 C++
date: 2022-04-13T21:31:41+09:00
draft: false
tags:
  - algorithm
  - cpp
---
<!--more-->
[코딩테스트 연습 - 없는 숫자 더하기](https://programmers.co.kr/learn/courses/30/lessons/86051)

## 접근 방법

`unordered_set<int>` 자료구조에 0 ~ 9 까지의 정수를 넣고 numbers에 존재하는 모든 수를 지우고, 남은 값을 모두 더합니다.

## 코드

```cpp
#include <bits/stdc++.h>

using namespace std;

int solution(vector<int> numbers) {
    int answer = 0;
    unordered_set<int> hset = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
    
    for (auto i : numbers) {
        hset.erase(i);
    }
    
    for (auto i : hset) {
        answer += i;
    }
    
    return answer;
}
```