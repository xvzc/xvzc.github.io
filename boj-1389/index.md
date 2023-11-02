# BOJ 1389 해설 C++

<!--more-->
[1389번: 케빈 베이컨의 6단계 법칙](https://www.acmicpc.net/problem/1389)

## 접근 방법

최단 경로 알고리즘을 사용하는 방법도 있지만, 부모 노드의 depth를 기억하고 자식노드에게 증가된 값을 부여하는 방식의 `너비 우선 탐색`으로 접근했습니다. 친구 관계는 중복되어 주어질 수 있으므로 노드간의 관계는 `set`을 사용해서 구현하였습니다.

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

    int n, m; cin >> n >> m;

    vector<set<int>> v(n+1);

    int x, y;
    for(int i = 0; i < m; i++) {
        cin >> x >> y;
        v[x].insert(y);
        v[y].insert(x);
    }

    pair<int, int> answer = {INT_MAX, INT_MAX};
    for(int i = 1; i < v.size(); ++i) {
        vector<bool> visited(n+1, false);

        queue<pair<int, int>> q;

        int kevin_bacon = 0;

        q.push({i, 0});
        visited[i] = true;
        kevin_bacon += q.front().se;

        while(!q.empty()) {
            for(auto n : v[q.front().fi]) {
                if(!visited[n]) {
                    q.push({n, q.front().se + 1});
                    visited[n] = true;
                }
            }

            kevin_bacon += q.front().se;
            q.pop();
        }

        if(answer.se > kevin_bacon)
            answer = {i, kevin_bacon};
    }

    cout << answer.fi << endl;;

    return 0;
}
```
