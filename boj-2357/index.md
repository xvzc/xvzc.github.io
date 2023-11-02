# BOJ 2357 해설 C++

<!--more-->
[2357번: 최솟값과 최댓값](https://www.acmicpc.net/problem/2357)

## 접근 방법

구간합 세그먼트 트리를 약간 바꾸어 생각해서, 부모는 자식의 합을 저장하는 것이 아닌 최댓값과 최솟값을 저장하도록 구현하여 해결할 수 있습니다.

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
int x;
vector<int> max_seg, min_seg;
/* ----------------------------------------------- */

/* - FUNCTIONS ----------------------------------- */
int query_max(int l, int r) {
    l+=x-1;
    r+=x-1;

    int value = 0;
    while(l <= r) {
        if(l%2 == 1) {
            value = max(max_seg[l], value);
        }

        if(r%2 == 0) {
            value = max(max_seg[r], value);
        }

        l = (l+1)/2;
        r = (r-1)/2;
    }
    
    return value;
}

int query_min(int l, int r) {
    l+=x-1;
    r+=x-1;

    int value = INT_MAX;
    while(l <= r) {
        if(l%2 == 1) {
            value = min(min_seg[l], value);
        }

        if(r%2 == 0) {
            value = min(min_seg[r], value);
        }

        l = (l+1)/2;
        r = (r-1)/2;

    }

    return value;
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
    int N, M; cin >> N >> M;

    max_seg = vector<int>(4 * N, 0);
    min_seg = vector<int>(4 * N, INT_MAX);

    for(x = 1; x <= N; x*=2);

    int temp;
    for(int i = x; i < x + N; ++i) {
        cin >> temp;
        max_seg[i] = temp;
        min_seg[i] = temp;
    }

    for(int i = x-1; i > 0; --i) {
        max_seg[i] = max(max_seg[i*2], max_seg[i*2 + 1]);
        min_seg[i] = min(min_seg[i*2], min_seg[i*2 + 1]);
    }

    int a, b;
    for(int i = 0; i < M; ++i) {
        cin >> a >> b;
        cout << query_min(a, b) << ' ' << query_max(a, b) << endl;
        
    }

    return 0;
}
```
