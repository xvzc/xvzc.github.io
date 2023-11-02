# BOJ 2042 해설 C++

<!--more-->
[2042번: 구간 합 구하기](https://www.acmicpc.net/problem/2042)

## 접근 방법

누적합을 이용하여 풀 수도 있다고 생각했었지만, 그렇게 풀게 되면 값을 바꾸는 연산이 존재하기 때문에 $O(N^2)$ 이 되어 TLE를 맞이하게 됩니다.. 따라서 세그먼트 트리를 사용해 update및 query를 $O(logN)$ 으로 해결합니다.

## 코드

```cpp
#include <bits/stdc++.h>

#define endl '\\n'

#define fi first
#define se second

typedef long long ll;
typedef unsigned long long ull;

using namespace std;

/* - GLOBAL VARIABLES ---------------------------- */
vector<ll> segment_tree;
int x;
/* ----------------------------------------------- */

/* - FUNCTIONS ----------------------------------- */
void update(int idx, ll value) {
    idx += x-1;
    segment_tree[idx] = value;

    idx/=2;
    while(idx > 0) {
        segment_tree[idx] = segment_tree[idx*2] + segment_tree[idx*2 + 1];
        idx/=2;
    }
}

ll query(int left, int right) {
    left+=x-1;
    right+=x-1;

    ll sum = 0;

    while(left <= right) {
        if(left%2 == 1) {
            sum+=segment_tree[left];
        }

        if(right%2 == 0) {
            sum+=segment_tree[right];
        }

        right = (right-1)/2;
        left = (left+1)/2;
    }

    return sum;
}
/* ----------------------------------------------- */

#define SUBMIT
int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);

#ifndef SUBMIT
    (void)!freopen("input.txt", "r", stdin);
    cout << "# From the test case" << endl;
#endif

    int N, M, K; cin >> N >> M >> K;
    segment_tree = vector<ll>(4 * N, 0);

    for(x = 1; x < N; x*=2);

    for(int i = x; i < x + N; ++i)
        cin >> segment_tree[i];

    for(int i = x-1; i > 0; --i) {
        segment_tree[i] = segment_tree[2*i] + segment_tree[2*i +1];
    }

    ll a, b, c;
    for(int i = 0; i < M + K; ++i) {
        cin >> a >> b >> c;
        if(a == 1) { // update
            update(b, c);
            continue;
        }

        if(a == 2) { // query
            cout << query(b, c) << endl;
            continue;
        }
    }

    return 0;
}
```
