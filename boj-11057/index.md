# BOJ 11057 해설 C++

<!--more-->
[11057번: 오르막 수](https://www.acmicpc.net/problem/11057)

## 접근 방법

2차원 적으로 접근해보겠습니다. **arr[i][j] 는 길이가 i이고 j로 끝나는 숫자의 갯수**를 의미합니다. 아래와 같이 표를 그려보면 `arr[i][j] = arr[i-1][j] + arr[i][j-1]` 이라는 점화식을 유도해 낼 수 있습니다.

$\def\arraystretch{1.4}\begin{array}{|l|l|l|l|l|l|l|l|l|l|l|}\hline\textsf{\textbf{\ \\}} & \textsf{\textbf{0}} & \textsf{\textbf{1}} & \textsf{\textbf{2}} & \textsf{\textbf{3}} & \textsf{\textbf{4}} & \textsf{\textbf{5}} & \textsf{\textbf{6}} & \textsf{\textbf{7}} & \textsf{\textbf{8}} & \textsf{\textbf{9}}\\\hline\textsf{0} & \textsf{0} & \textsf{0} & \textsf{0} & \textsf{0} & \textsf{0} & \textsf{0} & \textsf{0} & \textsf{0} & \textsf{0} & \textsf{0}\\\hline\textsf{1} & \textsf{1\ } & \textsf{1\ } & \textsf{1} & \textsf{1} & \textsf{1} & \textsf{1} & \textsf{1} & \textsf{1} & \textsf{1} & \textsf{1}\\\hline\textsf{2} & \textsf{1} & \textsf{2} & \textsf{3} & \textsf{4} & \textsf{5} & \textsf{6} & \textsf{7} & \textsf{8} & \textsf{9} & \textsf{10}\\\hline\textsf{3} & \textsf{1} & \textsf{3} & \textsf{6} & \textsf{10} & \textsf{15} & \textsf{21} & \textsf{28} & \textsf{36} & \textsf{45} & \textsf{55}\\\hline\textsf{...} & \textsf{} & \textsf{} & \textsf{} & \textsf{} & \textsf{} & \textsf{} & \textsf{} & \textsf{} & \textsf{} & \textsf{}\\\hline\textsf{1000} & \textsf{} & \textsf{} & \textsf{} & \textsf{} & \textsf{} & \textsf{} & \textsf{} & \textsf{} & \textsf{} & \textsf{}\\\hline\end{array}$

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
int DP[1001][11];
/* ----------------------------------------------- */

#define SUBMIT
int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);

#ifndef SUBMIT
    (void)!freopen("input.txt", "r", stdin);
    cout << "# From the test case" << endl;
#endif
    int N; cin >> N;
    int mod = 10007;

    for(int i = 1; i <= 1000; ++i) {
        int sum = 1;
        DP[i][0] = 1;
        for(int j = 1; j <= 9; ++j) {
            DP[i][j] = ((DP[i-1][j] % mod) + (DP[i][j-1] % mod)) % mod;
            sum = ((sum % mod) + (DP[i][j] % mod)) % mod;
        }
        DP[i][10] = sum;
    }

    cout << DP[N][10] << endl;
    return 0;
}
```
