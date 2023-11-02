---
title: BOJ 1107 해설 C++
date: 2021-11-06T21:31:41+09:00
draft: false
tags:
  - algorithm
  - cpp
---
<!--more-->
[1107번: 리모컨](https://www.acmicpc.net/problem/1107)

## 접근 방법

완전탐색으로 모든 경우를 확인합니다. 다만 다른 채널을 경유해서 도달하는 경우, 해당 채널이 500000 이상으로 넘어갈 수 있다는 점을 고려해야합니다.

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

    int target; cin >> target;
    int n; cin >> n;

    char c;
    string disabled;
    for(int i = 0; i < n; ++i) {
        cin >> c; disabled.push_back(c);
    }

    int answer = abs(target - 100);
    for(int i = 0; i < 1000000; ++i) {
        bool is_possible = true;

        for(int j = 0; j < disabled.size(); ++j) {
            if(to_string(i).find(disabled[j]) != string::npos) {
                is_possible = false;
                break;
            }
        }

        if(!is_possible)
            continue;

        answer = min(answer, abs(i - target) + (int)to_string(i).size());
    }

    cout << answer << endl;

    return 0;
}
```