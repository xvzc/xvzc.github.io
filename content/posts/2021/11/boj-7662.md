---
title: BOJ 7662 해설 C++
date: 2021-11-05T21:31:41+09:00
draft: false
tags:
  - algorithm
  - cpp
---
<!--more-->
[7662번: 이중 우선순위 큐](https://www.acmicpc.net/problem/7662)

## 접근 방법

두개의 우선순위 큐를 사용하는 풀이도 있지만, 우선순위 큐는 가장 위에 있는 값만 지울 수 있어 유연하지 못합니다. 그래서 이진 탐색 트리로 구현된 `multiset`을 사용하였습니다. C++의 multiset은 반복자를 활용해 삭제연산을 할 수 있습니다.

## 코드

```cpp
#include <bits/stdc++.h>

#define endl '\\n'

using namespace std;

#define SUBMIT
int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);

#ifndef SUBMIT
    (void)!freopen("input.txt", "r", stdin);
    cout << "# From the test case" << endl;
#endif

    int T; cin >> T;
    while(T--) {
        multiset<int> ms;

        int N; 
        cin >> N;

        char c;
        int value;
        for(int i = 0; i < N; ++i) {
            cin >> c >> value;

            if(c == 'I') {
                ms.insert(value);
                continue;
            } 

            if(c == 'D' && value == 1) {
                if(!ms.empty())
                    ms.erase(prev(ms.end()));

                continue;
            }

            if(c == 'D' && value == -1) {
                if(!ms.empty())
                    ms.erase(ms.begin());

                continue;
            }
        }

        if(ms.empty())
            cout << "EMPTY" << endl;
        else
            cout << *ms.rbegin() << ' ' << *ms.begin() << endl;

    }

    return 0;
}
```