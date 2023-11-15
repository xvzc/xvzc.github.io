---
title: BOJ 11689 해설 C++
date: 2022-02-06T21:31:41+09:00
draft: false
tags:
  - algorithm
  - cpp
---
<!--more-->
[11689번: GCD(n, k) = 1](https://www.acmicpc.net/problem/11689)

## 접근 방법

$n$ 보다 작거나 같으면서 $gcd(n, k)$를 만족하는 모든 자연수는 **$n$ 보다 같거나 작으면서 $n$과 서로소인 자연수의 개수**와 같습니다. 즉 **오일러 함수**를 사용해서 $\phi(n)$을 구하는 문제가 되겠습니다. **오일러 함수**에는 몇가지 규칙이 있는데 그 중에서도 이 문제에서 우리가 사용할 규칙은 다음과 같습니다.

1. $\phi(p^a) = p^{a} - p^{a-1}$
2. $\phi(mn) = \phi(m)\phi(n)$

풀이에 대해 간략하게 설명을 하겠습니다.

우선 에라토스테네스의 체 알고리즘을 사용해서 $\sqrt{n}$ 까지의 모든 소수를 구합니다.

> 최악의 경우 $n = 10^{12}$ 이 입력으로 들어오면 1,000,000 까지의 소수를 구하므로 시간적으로 충분합니다.

그 다음으로, 구해진 소수를 하나씩 확인하면서 해당 $n$이 현재 바라보고 있는 소수로 더이상 나누어 떨어지지 않을 때 까지 다음을 반복합니다.

```cpp
a = 0;
p = prime[i]
while(n % p == 0) {
	n /= p;
	a++;
}
```

위 과정을 한번 반복하면 $n$은 $p^{a}$ 라는 소인수를 갖고 있다는 사실을 알 수 있습니다. 따라서 위 오일러 함수 1번 규칙을 사용해서 값을 얻어낼 수 있습니다. 이러한 과정을 반복하면서 위에서 언급된 2번 규칙에 따라 answer 변수에 $\phi(p^a)$의 값을 곱하면 해를 얻을 수 있습니다.

## 코드

```cpp
#include <bits/stdc++.h>

#define debug if constexpr (local) std::cout
#define endl '\\n'
#define fi first
#define se second
#define MAX 1000001

#ifdef LOCAL
constexpr bool local = true;
#else
constexpr bool local = false;
#endif

typedef long long ll;
typedef unsigned long long ull;

using namespace std;

/* - GLOBAL VARIABLES ---------------------------- */
ll N;
bool is_prime[MAX];
/* ----------------------------------------------- */

/* - FUNCTIONS ----------------------------------- */
ll exponent(int p, int a) {
    ll ret = 1;

    for (int i = 0; i < a; ++i) {
        ret *= p;
    }

    return ret;
}

ll totient(ll p, ll a) {
    return exponent(p, a-1)*(p - 1);
}
/* ----------------------------------------------- */

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);

    if constexpr (local) 
        (void)!freopen("input.txt", "r", stdin);

    cin >> N;

    memset(is_prime, true, sizeof(is_prime));

    is_prime[0] = false;
    is_prime[1] = false;

    for (int i = 2; i*i < MAX; ++i) {
        if (!is_prime[i]) {
            continue;
        }

        for (int j = i*i; j < MAX; j+=i) {
            is_prime[j] = false;
        }
    }

    if (2 <= N && N < MAX && is_prime[N]) {
        cout << N - 1 << endl;
        return 0;
    }

    ll answer = 1;

    for (ll i = 2; i*i <= N; ++i) {
        if (!is_prime[i]) {
            continue;
        }

        ll prime = i;
        ll n = 0;
        while (N % prime == 0) {
            n++;
            N /= prime;
        }

        if (n >= 1) {
            answer *= totient(prime, n);
        }
    }

    if (N > 1) {
        answer *= N-1;
    }

    cout << answer << endl;

    return 0;
}
```