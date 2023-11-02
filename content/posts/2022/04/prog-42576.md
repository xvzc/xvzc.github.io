---
title: Programmers 완주하지 못한 선수 C++
date: 2022-04-07T21:31:41+09:00
draft: false
tags:
  - algorithm
  - cpp
---
<!--more-->
[코딩테스트 연습 - 완주하지 못한 선수](https://programmers.co.kr/learn/courses/30/lessons/42576)

## 접근 방법

처음에는 `unordered_set` 을 사용하여 풀 수 있을 거라고 생각했지만 중복된 이름이 존재할 수 있기 때문에 `unordered_map<string, int>` 자료구조를 사용하여 참가자 이름을 count하고, completion에 존재하는 이름들을 한명씩 빼는 방식으로 해결합니다.

## 코드

```cpp
#include <bits/stdc++.h>

using namespace std;

string solution(vector<string> participant, vector<string> completion) {
    string answer = "";
    unordered_map<string, int> hmap;
    for (auto s : participant) {
        hmap[s]++;
    }
    
    for (auto s : completion) {
        hmap[s]--;
    }
    
    for (auto p : hmap) {
        if (p.second != 0) {
            answer = p.first;
        }
    }
    
    return answer;
}
```