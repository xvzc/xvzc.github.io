# BOJ 1074 해설 C++

<!--more-->
[1074번: Z](https://www.acmicpc.net/problem/1074)
## 접근 방법

N의 범위가 $1 \le N \le 15$ 이므로 `Brute forcing`으로 푼다면 최대 연산 횟수가 10억을 넘어 시간을 초과하게 됩니다.

좌표 공간을 4등분 해서, 찾고자 하는 r, c 값을 포함하는 범위에 대해 재귀를 수행하는 방법으로 풀면 시간 내에 충분히 해결할 수 있습니다.

## 코드

```cpp
#iclude <bits/stdc++.h>

#define endl '\\n'

#define fi first
#define se second

typedef long long ll;
typedef unsigned long long ull;

using namespace std;

/* - GLOBAL VARIABLES ---------------------------- */
int N, cnt, r, c;
int ans;
/* ----------------------------------------------- */

/* - FUNCTIONS ----------------------------------- */
void find(int len, int r_base, int c_base) {
    if(r_base == r && c_base == c) {
				// 좌표 공간을 나누는 기준 점이 r, c와 같다면 해당 지점을 찾아낸 것이므로
				// 값을 저장합니다.
        ans = cnt;
    }

    if(r >= r_base && r < r_base + len && c >= c_base && c < c_base + len) {
				// Z 모양을 그리며 수행해야 하므로, 함수 호출 순서도 답에 영향이 있습니다.
        find(len / 2, r_base, c_base);
        find(len / 2, r_base, c_base + len / 2);
        find(len / 2, r_base + len / 2, c_base);
        find(len / 2, r_base + len / 2, c_base + len / 2);
    } else
        cnt += len * len;
				// 만약 r, c 값이 범위에 포함되지 않는다면 해당 범위는 진행한 것으로 가정하고
        // 해당 범위의 좌표 갯수(길이의 제곱)를 더해줍니다.

    return;
}
/* ----------------------------------------------- */

// #define SUBMIT
int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);

    cin >> N >> r >> c;

    find(pow(2, N), 0, 0);
    cout << ans << endl;

    return 0;
}
```
