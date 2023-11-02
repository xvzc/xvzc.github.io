---
title: Programmers 신규 아이디 추천 C++
date: 2022-04-04T21:31:41+09:00
draft: false
tags:
  - algorithm
  - cpp
---
<!--more-->
[코딩테스트 연습 - 신규 아이디 추천](https://programmers.co.kr/learn/courses/30/lessons/72410)

## 접근 방법

복잡해 보일 수 있지만 차근차근 한단계 씩 해나가면 간단히 해결할 수 있는 문제입니다. c++의 regex를 활용하면 조금 더 수월하게 풀 수 있습니다.

## 코드

```cpp
#include <bits/stdc++.h>

using namespace std;

string solution(string new_id) {
    string step1;
    for (auto c : new_id) {
        step1 += tolower(c);
    }
    
    cout << "step1 : " << step1 << endl;
    
    string step2;
    for (auto c : step1) {
        if ('a' <= c and c <= 'z') {
            step2 += c;
            continue;
        }
        
        if ('0' <= c and c <= '9') {
            step2 += c;
            continue;
        }
        
        if (c == '-' or c == '_' or c == '.') {
            step2 += c;
        }
    }
    
    cout << "step2 : " << step2 << endl;
    
    string step3 = regex_replace(step2, regex("[.]+"), ".");
    cout << "step3 : " << step3 << endl;
    
    string step4 = regex_replace(step3, regex("^[.]|[.]$"), "");
    cout << "step4 : " << step4 << endl;
    
    string step5 = step4;
    if (step5 == "") {
        step5 = "a";
    }
    
    string step6 = step5;
    if (step6.length() >= 16) {
        step6 = step6.substr(0, 15);
        step6 = regex_replace(step6, regex("[.]$"), "");
    }
    
    string step7 = step6;
    if (step7.length() <= 2) {
        while (step7.length() != 3) {
            step7.push_back(step7.back());
        }
    }
    
    return step7;
}
```