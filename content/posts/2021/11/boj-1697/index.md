---
title: BOJ 1697 해설 C++
date: 2021-11-07T21:31:41+09:00
draft: false
tags:
  - algorithm
  - cpp
---
<!--more-->
[1697번: 숨바꼭질](https://www.acmicpc.net/problem/1697)

## 접근 방법

$X-1$, $X + 1$, $2X$로 가는 경우들을 생각해서 BFS를 해줍니다. $N$의 최대, 최소 범위를 넘지 않도록 고려해야합니다.

## 코드

```cpp
#include <bits/stdc++.h>

#define endl '\\n'

#define fi first
#define se second

using namespace std;

#define SUBMIT
int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);

#ifndef SUBMIT
    (void)!freopen("input.txt", "r", stdin);
    cout << "# From the test case" << endl;
#endif
    int n, k; cin >> n >> k;

    queue<pair<int, int>> q;
    vector<bool> visited(100001, false);

    q.push({n, 0});
    visited[n] = true;

    int answer = 0;
    while(!q.empty()) {
        if(q.front().fi == k) {
            answer = q.front().se;
            break;
        }

        if(q.front().fi - 1 >= 0) {
            if(!visited[q.front().fi - 1]) {
                q.push({q.front().fi - 1, q.front().se + 1});
                visited[q.front().fi] = true;
            }
        }

        if(q.front().fi + 1 <= 100000) {
            if(!visited[q.front().fi + 1]) {
                q.push({q.front().fi + 1, q.front().se + 1});
                visited[q.front().fi] = true;
            }
        }

        if(q.front().fi * 2 <= 100000) {
            if(!visited[q.front().fi * 2]) {
                q.push({q.front().fi * 2, q.front().se + 1});
                visited[q.front().fi] = true;
            }
        }

        q.pop();
    }

    cout << answer << endl;

    return 0;
}
```