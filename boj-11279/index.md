# BOJ 11279 해설 C++

<!--more-->
[11279번: 최대 힙](https://www.acmicpc.net/problem/11279)

## 접근 방법

간단합니다. `Heap`을 구현하는 `priority_queue` 를 사용해서 쉽게 풀 수 있습니다. `Heap` 자료구조는 삽입, 삭제 연산이 발생할 때 마다 $O(logN)$ 복잡도를 갖는 정렬을 수행하므로, 최종 복잡도는 $O(NlogN)$ 입니다.

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

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);

    if constexpr (local) 
        (void)!freopen("input.txt", "r", stdin);

    int N; cin >> N;
    priority_queue<int, vector<int>, less<int>> pq;

    int temp;
    for(int i = 0; i < N; ++i) {
        cin >> temp;
        if(temp == 0) {
            if(pq.empty())
                cout << 0 << endl;
            else {
                cout << pq.top() << endl;
                pq.pop();
            }
            continue;
        }

        pq.push(temp);
    }

    return 0;
}
```
