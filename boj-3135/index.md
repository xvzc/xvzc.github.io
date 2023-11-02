# BOJ 3135 해설 C++

<!--more-->
[3135번: 라디오](http://boj.kr/3135)

## 접근 방법

즐겨찾기에 등록되어있는 주파수 중 목적지 주파수와 가장 가까운 위치에 있는 주파수를 $K$라 할 때, $K$ 를 경유하여 B에 도달하기 까지 눌러야하는 버튼의 횟수는 $abs(K - B) + 1$ 입니다.

다만, 즐겨찾기에 등록되어있는 모든 주파수로 부터 B 까지의 거리가 $abs(A - B)$ 보다 큰 경우가 있을 수 있다는 것을 고려하면, 정답은 $min(abs(B - A), abs(B - K))$ 라는 사실을 알 수 있습니다.

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

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);

    if constexpr (local) 
        (void)!freopen("input.txt", "r", stdin);

    int A, B, N; cin >> A >> B >> N;

    vector<int> v(N);
    for (int i = 0; i < N; ++i) {
        cin >> v[i];
    }

    int closest = INT_MAX;
    for (auto i : v) {
        int cur = abs(closest - B);
        int nxt = abs(i - B);
        if (nxt < cur) {
            closest = i;
        }
    }

    cout << min(abs(B - A), abs(B - closest) + 1) << endl;

    return 0;

```
