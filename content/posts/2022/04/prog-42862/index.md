---
title: Programmers 체육복 C++
date: 2022-04-21T21:31:41+09:00
draft: false
tags:
  - algorithm
  - cpp
---
<!--more-->
[코딩테스트 연습 - 체육복](https://programmers.co.kr/learn/courses/30/lessons/42862)

## 접근 방법

탐욕 알고리즘을 사용하여 해결해야합니다.

여분의 체육복을 가지고 온 경우를 O, 체육복이 없는 경우를 X인 경우를 배열로 나타내면 `{O, X, O, X}` 입니다. 이 때 3번째 학생이 2번째 학생에게 체육복을 빌려주게 되면 4번째 학생은 1번째 학생에게 체육복을 빌려줄 수 없게 됩니다. 따라서 앞에 있는 학생을 우선으로 빌려주어야만 그리디하게 문제를 해결할 수 있습니다.

> 여분의 체육복이 있는 학생도 체육복을 도난당할 수 있다는 점에 유의합니다.

## 코드

```cpp
#include <bits/stdc++.h>

using namespace std;

int solution(int n, vector<int> lost, vector<int> reserve) {
    int answer = 0;
    
    set<int> set_lost(lost.begin(), lost.end());
    set<int> set_reserve(reserve.begin(), reserve.end());
    
    vector<int> common;
    for (auto i : lost) {
        if (set_reserve.find(i) != set_reserve.end()) {
            common.push_back(i);
        }
    }
    
    for (auto i : common) {
        set_lost.erase(i);
        set_reserve.erase(i);
    }
    
    n -= set_lost.size();
    
    for (auto i : set_reserve) {
        if (set_lost.find(i-1) != set_lost.end()) {
            set_lost.erase(i-1);
            set_lost.erase(i);
            n++;
            continue;
        } 
        
        if (set_lost.find(i+1) != set_lost.end()) {
            set_lost.erase(i+1);
            set_lost.erase(i);
            n++;
            continue;
        } 
        
    }
    
    return n;
}
```