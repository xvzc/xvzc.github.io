# BOJ 1238 해설 C++

<!--more-->
[1238번: 파티](https://www.acmicpc.net/problem/1238)

## 접근 방법

다익스트라 알고리즘을 활용해서 모든 노드에 대해 다익스트라를 수행합니다.

i 번째 학생이 X의 집으로 파티를 가는 경우의 왕복 거리는 distance[i][X] + distance[X][i] 가 됩니다.

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
vector<pair<int, int>> edges[10001];
int N, M, X, dist[1001][1001];
/* ----------------------------------------------- */

/* - FUNCTIONS ----------------------------------- */
void clear_dist() {
    for (int i = 0; i < 1001; ++i) {
        for (int j = 0; j < 1001; ++j) {
            dist[i][j] = INT_MAX;
        }
    }
}

void dijkstra(int start) {
    priority_queue<pair<int, int>>  pq;

    dist[start][start] = 0;
    pq.push({dist[start][start], start});

    while(!pq.empty()) {
        int dist_to_cur = -pq.top().fi;
        int cur_idx = pq.top().se;

        pq.pop();

        if (dist_to_cur > dist[start][cur_idx]) {
            continue;
        }

        for (int i = 0; i < edges[cur_idx].size(); ++i) {
            int dist_to_next = dist_to_cur + edges[cur_idx][i].se;
            int next_idx = edges[cur_idx][i].fi;

            if (dist_to_next < dist[start][next_idx]) {
                dist[start][next_idx] = dist_to_next;
                pq.push({-dist_to_next, next_idx});
            }
        }
    }
}
/* ----------------------------------------------- */

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);

    if constexpr (local) 
        (void)!freopen("input.txt", "r", stdin);

    cin >> N >> M >> X;

    int start, end, price;
    while(M--) {
        cin >> start >> end >> price;
        edges[start].push_back({end, price});
    }

    clear_dist();

    for (int i = 1 ; i <= N; ++i) {
        dijkstra(i);
    }

    int max_dist = INT_MIN;
    int round_trip = INT_MIN;
    for (int i = 1; i <= N; ++i) {
        round_trip = dist[i][X] + dist[X][i];
        if(round_trip > max_dist) {
            max_dist = round_trip;
        }
    }

    cout << max_dist << endl;

    return 0;
}
```
