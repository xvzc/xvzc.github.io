# BOJ 2637 해설 C++

<!--more-->
[2637번: 장난감 조립](http://boj.kr/2637)

## 접근 방법

위상 정렬을 하면서 $i$ 부품으로 $j$ 부품을 만들 때 소요되는 $i$의 갯수를 다이나믹프로그래밍을 활용하여 구합니다. 현재 바라보고 있는 $cnt[i][cur]$이 0이 아니라면 $i$ 부품으로 $cur$ 부품을 만들었다는 의미이므로, $cur[i][next]$ = $cur[i][next]$ + $cur[i][cur]*need$ 라는 식을 얻을 수 있습니다.

> $need$는 $next$ 부품을 만들기 위해 필요한 $cur$의 갯수를 의미합니다.

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
int cnt[101][101];
int indeg[101];
vector<pair<int, int>> parts[101];
/* ----------------------------------------------- */

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);

    if constexpr (local) 
        (void)!freopen("input.txt", "r", stdin);

    int N, M; cin >> N >> M;

    while (M--) {
        int x, y, z; cin >> x >> y >> z;
				// x 부품을 만들기 위해 필요한 y의 갯수는 z개
        parts[y].push_back({x, z});
        indeg[x]++;
    }

    queue<int> q;
    for (int i = 1; i <= N; ++i) {
        if (indeg[i] == 0) {
            q.push(i);
            cnt[i][i] = 1;
        }
    }

    while (!q.empty()) {
        int cur = q.front(); q.pop();
        for (auto p : parts[cur]) {
            int next = p.fi;
            int need = p.se;
            if (--indeg[next] == 0) {
                q.push(next);
            }

            for (int i = 1; i <= N; ++i) {
                if (cnt[i][cur]) {
                    cnt[i][next] += cnt[i][cur]*need;
                }
            }
        }
    }

    for (int i = 1; i <= N; ++i) {
        if (cnt[i][i]) {
            cout << i << ' ' << cnt[i][N] << endl;
        }
    }

    return 0;
}
```
