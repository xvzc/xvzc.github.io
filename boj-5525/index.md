# BOJ 5525 해설 C++

<!--more-->
[5525번: IOIOI](https://www.acmicpc.net/problem/5525)

## 접근 방법

처음에는 $O(N^2)$ 풀이로 접근하였으나 서브테스크에서 시간초과가 되었습니다.

다음과 같은 규칙을 생각하면 $O(N)$ 으로 해결할 수 있습니다.

$P = IOIOI$

$when$ $M = IOI$, $count = 0$

$when$ $M= IOIOI$, $count = 1$

$when$ $M = IOIOIOI$, $count = 2$

위와 같이 `현재 보고 있는 IOI 문자열의 길이`가 P의 길이와 같아지는 지점 부터는 길이가 늘어남에 따라 `count` 가 1씩 증가하게됩니다. 이와 같은 규칙을 이용한다면, **IOI 부분 문자열들의 길이**만으로 모든 경우의 수를 계산할 수 있게됩니다.

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
int DP[1000001] = {0, };
/* ----------------------------------------------- */

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);

    if constexpr (local) 
        (void)!freopen("input.txt", "r", stdin);

    int n, m; cin >> n >> m;
    string p, s; cin >> s;

    int answer = 0, length = 0;
    for (int i = 0; i <= m - 2; ++i) {
        if(s[i] == 'O') {
            continue;
        }
        else {
            if(s[i + 1] == 'O' && s[i + 2] == 'I') {
                ++i;
                ++length;

                if(length >= n)
                    answer++;

            } else {
                length = 0;
            }
        }
    }

    cout << answer << endl;

    return 0;
}
```
