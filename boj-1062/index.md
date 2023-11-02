# BOJ 1062 해설 C++

<!--more-->
[1062번: 가르침](https://www.acmicpc.net/problem/1062)

# 비트마스킹 풀이

## 접근 방법

선택할 글자, 그리고 확인하고자 하는 단어들을 모두 비트로 표현하면 해당 단어가 선택된 글자들에 포함되는지 여부는 &(and) 연산으로 빠르게 확인할 수 있습니다.

예를 들면 필수 문자들인 “antatica” 를 포함하는 비트는 다음과 같이 구할 수 있습니다.

> 중복된 알파벳은 생략할 수 있습니다. 아래 $antatica$변수는 “antatica”를 표현하기위해 필요한 최소한의 문자를 비트로 표현한 것이기 때문입니다.

```java
int antatica = 0;
antatica |= 1 << ('a' - 'a');
antatica |= 1 << ('a' - 'n');
antatica |= 1 << ('a' - 't');
antatica |= 1 << ('a' - 'i');
antatica |= 1 << ('a' - 'c');

// antatica = 532741
```

위와 같은 방법으로 주어진 단어들도 모두 비트로 표현해줍니다. 이후 과정은 &(and) 연산을 이용해서 쉽게 해결할 수 있게됩니다. 이후 $i < (1 << 26)$ 범위까지 반복문을 돌면 가르칠 수 있는 단어의 모든 부분집합을 순회할 수 있고, $i$ & $word$ == $word$ 인 경우를 카운트 해줍니다.

또한, 켜져있는 비트의 갯수, 필수 글자들의 포함 여부를 체크해 불필요한 연산을 줄여주면 더욱 효율적으로 풀 수 있습니다.

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

using namespace std;

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);

    if constexpr (local) 
        (void)!freopen("input.txt", "r", stdin);

    const int antatica = 532741;

    int n, k; cin >> n >> k;
    vector<int> v(n);
    string temp;

    for(int i = 0; i < n; ++i) {
        cin >> temp;
        int bits = antatica;
        for(auto c : temp)
            bits |= 1 << ((int)c - 'a');

        v[i] = bits;
    }

    int answer = 0;
    for(unsigned int i = 0; i < (1 << 26); ++i) {
        if((i & antatica) != antatica)
            continue;

        if(__builtin_popcount(i) != k)
            continue;

        int cnt = 0;
        for(auto word_bits : v) {
            if((i & word_bits) == word_bits) 
                cnt++;
        }

        answer = cnt > answer ? cnt : answer;
    }

    cout << answer << endl;

    return 0;
}
```

# 백트래킹 풀이

## 접근 방법

$learned[i]$는 i 번째 알파벳을 배웠는지의 여부를 나타냅니다. 예를들어 $learned[0]$이 true 라면 ‘a’ 알파벳을 배웠다는 의미입니다 $learned[]$ 배열에 대해 배울 수 있는 모든 경우의 수에 대해 백트래킹을 수행하며 배운 알파벳의 갯수가 K개가 되면 우선 해당 경우가 정답일 가능성이 있는지를 체크한 뒤 읽을 수 있는 단어의 수를 카운트합니다.

> 입력되는 단어는 반드시 “anta”로 시작하며 “tica”로 끝나기 때문에 “antatica”를 모두 배우지 않은 경우는 카운트하지 않습니다.

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

/* - GLOBAL VARIABLES ---------------------------- */
int N, K;
bool word[50][26];
bool learned[26];
int answer = 0;
/* ----------------------------------------------- */

/* - FUNCTIONS ----------------------------------- */
int count() {
    int cnt = 0;
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < 26; ++j) {
            if (!learned[j] && word[i][j]) {
                cnt--;
                break;
            }
        }
        cnt++;
    }
    return cnt;
}

bool is_promising() {
    if (!learned['a'-'a'])
        return false;

    if (!learned['n'-'a'])
        return false;

    if (!learned['t'-'a'])
        return false;

    if (!learned['i'-'a'])
        return false;

    if (!learned['c'-'a'])
        return false;

    return true;
}

void gogosing(int idx, int cnt) {
    if (cnt == K) {
        if(!is_promising()) {
            return;
        }

        answer = max(answer, count());
        return;
    }

    for (int i = idx+1; i < 26; ++i) {
        learned[i] = true;
        gogosing(i, cnt + 1);
        learned[i] = false;
    }
}
/* ----------------------------------------------- */

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);

    if constexpr (local) 
        (void)!freopen("input.txt", "r", stdin);

    cin >> N >> K;
    string temp;
    for (int i = 0; i < N ; ++i) {
        cin >> temp;
        for (auto c : temp) {
            word[i][c - 'a'] = true;
        }
    }

    for (int i = 0; i < 26; ++i) {
        learned[i] = true;
        gogosing(i, 1);
        learned[i] = false;
    }

    cout << answer;

    return 0;
}
```
