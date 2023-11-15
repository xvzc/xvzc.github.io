---
title: BOJ 2667 해설 C++
date: 2021-11-24T21:31:41+09:00
draft: false
tags:
  - algorithm
  - cpp
---
<!--more-->
[2667번: 단지번호붙이기](https://www.acmicpc.net/problem/2667)

## 접근 방법

전체 2차원 벡터을 순회하면서 값이 0인 경우는 건너 뛰고, 값이 1인 경우에만 `BFS`를 수행합니다. 방문 처리는 별도의 2차원 벡터를 두지 않고 2차원 벡터의 **값을 0으로 치환**하는 방법을 사용합니다.

## 코드

```cpp
#include <bits/stdc++.h>

#define debug if constexpr (local) std::cout
#define endl '\\n'
#define fi first
#define se second

#ifdef LOCAL
constexpr bool local = true;
#else
constexpr bool local = false;
#endif

typedef long long ll;
typedef unsigned long long ull;

using namespace std;

/* - GLOBAL VARIABLES ---------------------------- */
int n; 
int dx[4] = {-1,  0, 0, 1};
int dy[4] = { 0, -1, 1, 0};
/* ----------------------------------------------- */

/* - FUNCTIONS ----------------------------------- */
bool is_out_of_index(int y, int x) {
    return y < 0 || y >= n || x < 0 || x >= n;
}
/* ----------------------------------------------- */

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);

    if constexpr (local) 
        (void)!freopen("input.txt", "r", stdin);

    cin >> n;
    vector<vector<int>> v(n);
    vector<int> answer;

    string temp;
    for (int i = 0; i < n; ++i) {
        cin >> temp;

        for (int j = 0; j < n; ++j)
            v[i].push_back(temp[j] - '0');
    }

    queue<pair<int, int>> q;
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            if(v[i][j] == 0)
                continue;

            int cnt = 0;

            q.push({i, j});
            v[i][j] = 0;
            cnt++;

            while (!q.empty()) {
                int y = q.front().fi;
                int x = q.front().se;

                for (int k = 0; k < 4; ++k) {
                    int ny = y + dy[k];
                    int nx = x + dx[k];

                    if (is_out_of_index(ny, nx))
                        continue;

                    if(v[ny][nx] == 0)
                        continue;

                    q.push({ny, nx});
                    v[ny][nx] = 0;
                    cnt++;
                }
                q.pop();
            }
            answer.push_back(cnt);
        }
    }

    sort(answer.begin(), answer.end());

    cout << answer.size() << endl;
    for (int i = 0; i < answer.size(); ++i) {
        cout << answer[i] << endl;
    }

    return 0;
}
```