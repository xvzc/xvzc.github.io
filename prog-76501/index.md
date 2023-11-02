# Programmers 음양 더하기 C++

<!--more-->
[코딩테스트 연습 - 음양 더하기](https://programmers.co.kr/learn/courses/30/lessons/76501)

## 접근 방법

단순한 문제입니다. signs의 값이 true라면 양수를, false 라면 음수를 더해줍니다.

## 코드

```cpp
#include <string>
#include <vector>

using namespace std;

int solution(vector<int> absolutes, vector<bool> signs) {
    int answer = 0;
    
    for (int i = 0; i < signs.size(); ++i) {
        answer += signs[i] ? absolutes[i] : -absolutes[i];
    }
    
    return answer;
}
```
