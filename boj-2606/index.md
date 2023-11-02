# BOJ 2606 해설 C++

<!--more-->
[2606번: 바이러스](https://www.acmicpc.net/problem/2606)

## 접근 방법

1번 컴퓨터가 바이러스에 감염되었을 때 연쇄적으로 감염되는 컴퓨터의 수를 구하는 문제입니다. 따라서 최초 큐에 1번 컴퓨터의 인덱스를 넣고 시작하는 `BFS`를 구현합니다. 답의 갯수에서는 1번 컴퓨터를 제외하고 출력해야하는 점을 생각하고 구현해주시면 되겠습니다.

## 코드

```cpp
#include <bits/stdc++.h>

#define SUBMIT
#define debug if constexpr (!submit) std::cout
#define endl '\\n'
#define fi first
#define se second

#ifdef SUBMIT
constexpr bool submit = true;
#else
constexpr bool submit = false;
#endif

using namespace std;

/* - GLOBAL VARIABLES ---------------------------- */
bool visited[101] = {false, };
/* ----------------------------------------------- */

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);

    if constexpr (!submit) {
        (void)!freopen("input.txt", "r", stdin);
        cout << "# From the test case" << endl;
    }

    int n, m; cin >> n >> m;
    vector<vector<int>> v(n+1);

    int x, y;
    for(int i = 0; i < m; ++i) {
        cin >> x >> y;
        v[x].push_back(y);
        v[y].push_back(x);
    }

    queue<int> q;
    int answer = 0;

    q.push(1);
    visited[1] = true;

    while(!q.empty()) {

        for(int i = 0; i < v[q.front()].size(); ++i) {
            if(visited[v[q.front()][i]])
                continue;

            q.push(v[q.front()][i]);
            visited[v[q.front()][i]] = true;
            answer++;
        }

        debug << q.front() << endl;
        q.pop();
    }

    cout << answer << endl;

    return 0;
}
```
