---
title: Programmers K 번째 수 C++
date: 2022-04-12T21:31:41+09:00
draft: false
tags:
  - algorithm
  - cpp
---
<!--more-->
[코딩테스트 연습 - K번째수](https://programmers.co.kr/learn/courses/30/lessons/42748)

## 접근 방법

단순히 sub vector를 추출하여 정렬한 뒤 인덱스를 넣어 해결할 수도 있지만, 우선순위 큐를 활용하는 방법으로 풀어보았습니다.

## 코드

```cpp
#include <bits/stdc++.h>

using namespace std;

vector<int> solution(vector<int> array, vector<vector<int>> commands) {
    vector<int> answer;
    for (auto v : commands) {
        int i = v[0];
        int j = v[1];
        int k = v[2];
        
        vector<int> sub(array.begin()+i-1, array.begin()+j);
        
        priority_queue<int> pq;
        for (auto n : sub) {
            if (pq.size() < k) {
                pq.push(n);
                continue;
            }
            
            if (pq.top() > n) {
                pq.pop();
                pq.push(n);
            }
        }
        
        answer.push_back(pq.top());
    }
    return answer;
}
```