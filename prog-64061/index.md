# Programmers 크레인 인형뽑기 게임 C++

<!--more-->
[코딩테스트 연습 - 크레인 인형뽑기 게임](https://programmers.co.kr/learn/courses/30/lessons/64061)

## 접근 방법

Stack 자료구조를 활용해서 쉽게 해결할 수 있습니다. 입력으로 주어진 moves 배열의 컬럼 값이 1부터 시작한다는 점에 유의합니다.

## 코드

```cpp
#include <bits/stdc++.h>

using namespace std;

int solution(vector<vector<int>> board, vector<int> moves) {
    int answer = 0;
    stack<int> stk;
    for (auto col : moves) {
        int target = 0;
        for (int i = 0; i < board.size(); ++i) {
            if (board[i][col-1]) {
                target = board[i][col-1];
                board[i][col-1] = 0;
                break;
            }
        }
        
        if (target == 0) {
            continue;
        }
        
        if (!stk.empty() and stk.top() == target) {
            stk.pop();
            answer += 2;
            continue;
        }
        
        stk.push(target);
    }
    return answer;
}
```
