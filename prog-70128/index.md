# Programmers 내적 C++

<!--more-->
[코딩테스트 연습 - 내적](https://programmers.co.kr/learn/courses/30/lessons/70128)

## 접근 방법

주어진 조건 대로만 풀면 쉽게 해결할 수 있습니다.

## 코드

```cpp
#include <string>
#include <vector>

using namespace std;

int solution(vector<int> a, vector<int> b) {
    int answer = 0;
    
    for (int i = 0; i < a.size(); ++i) {
        answer += a[i]*b[i];
    }
    
    return answer;
}
```
