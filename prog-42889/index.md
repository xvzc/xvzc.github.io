# Programmers 실패율 C++

<!--more-->
[코딩테스트 연습 - 실패율](https://programmers.co.kr/learn/courses/30/lessons/42889)

## 접근 방법

스테이지에 도달한 유저의 수, 해당 스테이지를 아직까지 시도중인 유저의 수를 각각 다른 해시맵에 기록하고, 스테이지 별 실패율을 계산하여 `vector<pair<int, double>>` 에 저장합니다. 이 때 아무도 도달하지 못한 스테이지가 있다면 분모가 0이 되는 경우가 발생할 수 있으므로 예외처리를 해주어야합니다. 최종적으로 정렬함수를 정의하여 실패율이 높은 순서대로 정렬한 뒤 인덱스를 리턴합니다.

## 코드

```cpp
#include <bits/stdc++.h>

using namespace std;

bool comp(pair<int, float> p1, pair<int, float> p2) {
    if (p1.second > p2.second) {
        return true;
    } 
    
    if (p1.second == p2.second) {
        return p1.first < p2.first;
    }
    
    return false;
}

vector<int> solution(int N, vector<int> stages) {
    vector<int> answer;
    unordered_map<int, int> trying;
    unordered_map<int, int> entered;
    
    for (auto s : stages) {
        trying[s]++;
        for (int i = 1; i <= s; ++i) {
            entered[i]++;
        }
    }
    
    vector<pair<int, double>> v;
    for (int i = 1; i <= N; ++i) {
        v.push_back({i, entered[i] == 0 ? 0 : ((double)trying[i]/entered[i])});
    }
    
    sort(v.begin(), v.end(), comp);
    for (auto p : v) {
        answer.push_back(p.first);
    }
    
    return answer;
}
```
