---
title: Programmers 키패드 누르기 C++
date: 2022-04-04T21:31:41+09:00
draft: false
tags:
  - algorithm
  - cpp
---
<!--more-->
[코딩테스트 연습 - 키패드 누르기](https://programmers.co.kr/learn/courses/30/lessons/67256)

## 접근 방법

`unordered_map<int, pair<int, int>>` 를 활용해 번호를 키 값으로 키 패드의 좌표를 얻어낼 수 있는 자료구조를 만들었습니다. 이후 주어진 조건에 맞게 조건 분기를 해결합니다.

## 코드

```cpp
#include <bits/stdc++.h>

#define fi first
#define se second

using namespace std;

string solution(vector<int> numbers, string hand) {
    unordered_map<int, pair<int, int>> keypad = {
        {1,  {0, 0}}, {2, {0, 1}},  {3,  {0, 2}}, 
        {4,  {1, 0}}, {5, {1, 1}},  {6,  {1, 2}}, 
        {7,  {2, 0}}, {8, {2, 1}},  {9,  {2, 2}}, 
        {10, {3, 0}}, {0, {3, 1}},  {11, {3, 2}}
    };
    
    pair<int, int> left  = keypad[10];
    pair<int ,int> right = keypad[11];
    
    string answer = "";
    
    for (auto num : numbers) {
        if (num == 1 or num == 4 or num == 7) {
            left = keypad[num];
            answer += "L";
            continue;
        }
        
        if (num == 3 or num == 6 or num == 9) {
            right = keypad[num];
            answer += "R";
            continue;
        }
        
        pair<int ,int> target = keypad[num];
        int dl = abs(left.fi  - target.fi) + abs(left.se  - target.se);
        int dr = abs(right.fi - target.fi) + abs(right.se - target.se);
        
        if (dl < dr) {
            left = keypad[num];
            answer += "L";
            continue;
        }
        
        if (dr < dl) {
            right = keypad[num];
            answer += "R";
            continue;
        }
        
        if (dr == dl) {
            if (hand == "left") {
                left = keypad[num];
                answer += "L";
            } else {
                right = keypad[num];
                answer += "R";
            }
            continue;
        }
    }
    
    return answer;
}
```