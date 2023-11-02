---
title: BOJ 7576 해설 C++
date: 2021-11-18T21:31:41+09:00
draft: false
tags:
  - algorithm
  - cpp
---
<!--more-->
[7576번: 토마토](https://www.acmicpc.net/problem/7576)

## 접근 방법

2차원 벡터 값 하나에 토마토가 익을 때 까지 걸린 시간을 기록하는 방법으로 풀 수 있습니다. `주변 토마토 값 = 부모 토마토 값 + 1` 을 하면 2차원 벡터 내의 최댓값이 최종 상태까지 걸린 날짜가 됩니다.

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
int N, M;
int dx[4] = { 0, -1, 1, 0};
int dy[4] = {-1,  0, 0, 1};
/* ----------------------------------------------- */

/* - FUNCTIONS ----------------------------------- */
bool is_out_of_index(int i, int j) {
    if(i < 0 || N <= i)
        return true;

    if(j < 0 || M <= j)
        return true;

    return false;
}
/* ----------------------------------------------- */

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);

    if constexpr (local) 
        (void)!freopen("input.txt", "r", stdin);

    cin >> M >> N;

		// 입력을 받고 box내 값이 1인 경우 큐에 넣습니다.
    queue<pair<int, int>> q;
    vector<vector<int>> box(N, vector<int>(M, 0));
    for(int i = 0; i < N; ++i) {
        for(int j = 0; j < M; ++j) {
            cin >> box[i][j];
            if(box[i][j] == 1)
                q.push({i, j});
        }
    }

    while(!q.empty()) {
        int y = q.front().fi;
        int x = q.front().se;
				
				// 상, 하, 좌, 우에 대한 반복문
        for(int i = 0; i < 4; ++i) {
            int ny = y + dy[i];
            int nx = x + dx[i];

            if(is_out_of_index(ny, nx))
                continue;

						// 이미 익은 토마토이거나, 빈칸이라면 건너 뜁니다.
            if(box[ny][nx] != 0)
                continue;

						// 주변 토마토들을 부모토마토의 소요 날짜 + 1로 채웁니다.
            q.push({ny, nx});
            box[ny][nx] = box[y][x] + 1;
        }

        q.pop();
    }

    int result = -1e9;
    for(int i = 0; i < N; ++i) {
        for(int j = 0; j < M; ++j) {
						// 값이 0인 칸이 하나라도 존재하면 -1을 출력합니다.
            if(box[i][j] == 0) {
                cout << -1 << endl;
                return 0;
            }

            result = max(box[i][j], result);
        }
    }

		// 소요된 날짜 출력
    cout << result - 1 << endl;

    return 0;
}
```