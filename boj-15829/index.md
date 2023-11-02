# BOJ 15829 해설 C++

<!--more-->
[15829번: Hashing](https://www.acmicpc.net/problem/15829)

## 접근 방법

모듈로 연산의 성질을 이용하여 매 연산마다 모듈로를 취해 계산해줍니다.

모듈로 연산은 **나눗셈을 제외**한 연산에 대해 다음과 같은 특성을 가집니다.

$(a + b)\mod n = (a \mod n + b \mod n) \mod n$

$(a - b)\mod n = (a \mod n - b \mod n) \mod n$

$(a * b)\mod n = (a \mod n * b \mod n) \mod n$

```yaml
(A + B) % M = ((A % M) + (B % M)) % M
(A * B) % M = ((A % M) * (B % M)) % M
(A - B) % M = ((A % M) - (B % M)) % M
```

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
    int M = 1234567891;
    int r = 31;

    int l;
    string s;
    cin >> l >> s;

    ll base = 1;
    ll ans = 0;
    for(int i = 0; i < l; ++i) {
        int num = s[i]-'a' + 1;
        ans = (ans % M + ((num % M) * (base % M)) % M) % M;
        base = ((base % M) * (r % M)) % M;
    }
    cout << ans;

    return 0;
}
```
