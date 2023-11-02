# Programmers 숫자 문자열과 영단어 C++

<!--more-->
[코딩테스트 연습 - 숫자 문자열과 영단어](https://programmers.co.kr/learn/courses/30/lessons/81301)

## 접근 방법

c++의 regex_replace를 활용해서 쉽게 해결할 수 있습니다.

## 코드

```cpp
#include <bits/stdc++.h>

using namespace std;

int solution(string s) {
    s = regex_replace(s, regex("zero"), "0");
    s = regex_replace(s, regex("one"), "1");
    s = regex_replace(s, regex("two"), "2");
    s = regex_replace(s, regex("three"), "3");
    s = regex_replace(s, regex("four"), "4");
    s = regex_replace(s, regex("five"), "5");
    s = regex_replace(s, regex("six"), "6");
    s = regex_replace(s, regex("seven"), "7");
    s = regex_replace(s, regex("eight"), "8");
    s = regex_replace(s, regex("nine"), "9");
    
    return stoi(s);
}
```
