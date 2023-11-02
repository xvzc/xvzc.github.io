---
title: Programmers 로또의 최고 순위와 최저 순위 C++
date: 2022-04-04T21:31:41+09:00
draft: false
tags:
  - algorithm
  - cpp
---
<!--more-->
[코딩테스트 연습 - 로또의 최고 순위와 최저 순위](https://programmers.co.kr/learn/courses/30/lessons/77484)

## 접근 방법

arr[i]는 i개의 번호가 맞았을 때 등수를 의미합니다.

unordered_set에 win_nums를 저장하고 현재 가지고 있는 번호들 중 맞은 번호의 갯수와 0의 갯수를 카운트합니다. 가장 높은 등수의 경우는 현재 맞은 번호의 갯수 + 모든 0의 갯수, 가장 낮은 등수의 경우는 현재 맞은 번호의 갯수가 됩니다.

## 코드

```cpp
#include <bits/stdc++.h>

using namespace std;

int arr[] = {6, 6, 5, 4, 3, 2, 1};

vector<int> solution(vector<int> lottos, vector<int> win_nums) {
    vector<int> answer;
    unordered_set<int> hset;
    
    for (auto i : win_nums) {
        hset.insert(i);
    }
    
    int count = 0;
    int zero = 0;
    for (auto i : lottos) {
        if (i == 0) {
            zero++;
            continue;
        }
        
        if (hset.find(i) != hset.end()) {
            count++;
        }
    }
    
    answer.push_back(arr[count+zero]);
    answer.push_back(arr[count]);
    
    return answer;
}
```