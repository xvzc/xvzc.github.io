# BOJ 1927 해설 C++

<!--more-->
[1927번: 최소 힙](https://www.acmicpc.net/problem/1927)

## 접근 방법

입력 값이 들어올 때마다 최소한의 시간안에 정렬을 할 수 있는 자료구조인 힙을 사용합니다. **C++ STL**의 `priority_queue`를 사용하면 쉽게 해결할 수 있습니다.

## 코드

```cpp
#include <bits/stdc++.h>

#define endl '\\n'

#define fi first
#define se second

typedef long long ll;
typedef unsigned long long ull;

using namespace std;

#define SUBMIT
int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);

#ifndef SUBMIT
    (void)!freopen("input.txt", "r", stdin);
    cout << "# From the test case" << endl;
#endif
    priority_queue<int, vector<int>, greater<int>> pq;

    int x, n; cin >> n;
    for(int i = 0; i < n; ++i) {
        cin >> x;
        if(x)
            pq.push(x);

        if(!x) {

            if(pq.empty()) {
                cout << 0 << endl;
                continue;
            }

            cout << pq.top() << endl;
            pq.pop();
        }
    }

    return 0;
}
```
