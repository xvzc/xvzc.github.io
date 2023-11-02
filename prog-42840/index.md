# Programmers 모의고사 C++

<!--more-->
[코딩테스트 연습 - 모의고사](https://programmers.co.kr/learn/courses/30/lessons/42840)

## 접근 방법

단순한 구현 문제입니다. 모듈로 연산을 활용하여 반복되는 패턴을 정답과 비교하여 맞은 문제의 수를 카운트합니다.

## 코드

```cpp
#include <bits/stdc++.h>

using namespace std;

int strategy1[5] = {1,2,3,4,5};
int strategy2[8] = {2,1,2,3,2,4,2,5};
int strategy3[10] = {3,3,1,1,2,2,4,4,5,5};

vector<int> solution(vector<int> answers) {
    vector<int> answer;
    vector<int> persons = {0, 0, 0};
    
    
    for (int i = 0; i < answers.size(); ++i) {
        if(strategy1[i % 5] == answers[i]) {
            persons[0]++;
        }
        
        if(strategy2[i % 8] == answers[i]) {
            persons[1]++;
        }
        
        if(strategy3[i % 10] == answers[i]) {
            persons[2]++;
        }
    }
    
    int maxi = *max_element(persons.begin(), persons.end());
    for (int i = 0; i < persons.size(); ++i) {
        if (maxi == persons[i]) {
            answer.push_back(i+1);
        }
    }
    
    return answer;
}
```
