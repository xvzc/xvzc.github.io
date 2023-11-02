# BOJ 1051 해설 C++

<!--more-->
[1051번: 숫자 정사각형](http://boj.kr/1051)

## 접근 방법

단순 구현 문제입니다. size를 늘려가며 $O(N^3)$ 으로 완전탐색합니다.

## 코드

```cpp
#include <bits/stdc++.h>

#define debug if constexpr (local) std::cout
#define endl '\\n'
#define fi first
#define se second
#define all(x) x.begin(),x.end()

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
/* ----------------------------------------------- */

/* - FUNCTIONS ----------------------------------- */
bool is_out_of_index(int i, int j, int size) {
    return i + size >= N || j + size >= M;
}
/* ----------------------------------------------- */

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);

    if constexpr (local) 
        (void)!freopen("input.txt", "r", stdin);

    cin >> N >> M;
    vector<string> v(N);
    for (int i = 0; i < N; ++i) {
        cin >> v[i];
    }

    int answer = 0;
    for (int size = 0; size < min(N, M); ++size) {
        for (int i = 0; i < N; ++i) {
            for (int j = 0; j < M; ++j) {
                if (is_out_of_index(i, j, size)) {
                    continue;
                }

                if (v[i][j] == v[i+size][j] && v[i][j+size] == v[i+size][j+size] && v[i][j] == v[i][j+size]) {
                    answer = max(answer, (size + 1)*(size + 1));
                }
            }
        }
    }

    cout << answer; 

    return 0;
}
```
