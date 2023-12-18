---
title: BOJ 2805 해설 C++
date: 2021-10-12T21:31:41+09:00
draft: false
tags:
  - algorithm
  - cpp
---
<!--more-->
[2805번: 나무 자르기](https://www.acmicpc.net/problem/2805)
## 접근 방법
awefawefaㅁㅈㄷㄹㅁㅈㄷㄹㅁㅈㄹㄷ
나무의 최대 갯수가 1,000,000개 이므로 $O(N \log M)$로 해결할 수 있습니다.

우선 **0 부터 가장 높은 나무의 높이 사이의 범위**를 이분탐색 합니다.

모든 탐색에서 **mid** 값으로 모든 나무를 잘랐을 때의 합을 타겟이 되는 M 값과 비교하여 이분 탐색을 진행해 주시면 되겠습니다.

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
    int N, M; cin >> N >> M;

    int _max;
    vector<int> v(N); 
    for(int i = 0; i < N; ++i) {
        cin >> v[i];
        _max = _max < v[i] ? v[i] : _max;
    }

    int ans = 0;
    int left = 0, right = _max, mid;
    while(left <= right) {
        mid = (left + right) / 2;

        ll sum = 0;
        for(int i = 0; i < N; ++i)
            sum += max(v[i] - mid, 0);

        if(sum >= M)
            ans = mid;

        if(sum < M)
            right = mid - 1;
        else
            left = mid + 1;
    }

    cout << ans;

    return 0;
}
```