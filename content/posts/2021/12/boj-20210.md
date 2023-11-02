---
title: BOJ 20210 해설 C++
date: 2021-12-07T21:31:41+09:00
draft: false
tags:
  - algorithm
  - cpp
---
<!--more-->
[20210번: 파일 탐색기](https://www.acmicpc.net/problem/20210)

## 접근 방법

정렬 조건을 결정하는 함수를 구현하는게 까다로운 문제입니다. 우선 주어진 문자열들을 알파벳 하나로 이루어진 문자열과, 숫자로만 이루어진 문자열로 tokenize하고, 문자 하나하나를 비교하는 함수를 작성해주시며 됩니다.

다루어야하는 경우는 다음과 같이 네가지가 있습니다.

1. 알파벳 vs 알파벳 : 문제에서 주어진 조건 (AaBbCcDdEe....Zz) 순으로 정렬합니다.
2. 알파벳 vs 숫자 : 숫자가 우선입니다.
3. 숫자 vs 알파벳 : 숫자가 우선입니다.
4. 숫자 vs 숫자 : 숫자로 이루어진 문자열의 정수 값이 작은 것이 우선이며, 선행하는 0이 존재한다면 0의 갯수가 적은 것이 우선입니다. 다만 문제에 주어진 조건과 같이 숫자가 $2^{64}$ 을 넘을 수 있기 때문에 문자열로 처리해 주어야합니다.

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

/***************************************************************/
vector<string> tokenize(string s) {
    vector<string> v;
    string temp = "";
    for(auto c : s) {
        if( c < '0' || '9' < c ){
            if(!temp.empty()) {
                v.push_back(temp);
                temp.clear();
            }
 
            string s; s.push_back(c);
            v.push_back(s);
            continue;
        }
 
        temp.push_back(c);
    }
 
    if(!temp.empty())
        v.push_back(temp);
 
    return v;
}

bool is_number(char c) {
    return '0' <= c && c <= '9';
}

bool is_charactor(char c) {
    return c < '0' || '9' < c;
}

int count_leading_zero(string s) {
    int ret = 0;
    for(auto c : s) {
        if(c != '0')
            break;

        ret++;
    }

    return ret;
}

string remove_leading_zero(string s) {
    int i = 0;
    for(; i < s.length(); ++i) {
        if(s[i] == '0')
            continue;

        break;
    }

    if(i == s.length())
        return "0";

    return s.substr(i);
}

int compare_strnum(string s1, string s2) {
    if(s1.length() != s2.length()) {
        if(s1.length() < s2.length())
            return 1;
        else
            return -1;
    }

    for(int i = 0; i < s1.length(); ++i) {
        if(s1[i] == s2[i])
            continue;

        if(s1[i] - '0' < s2[i] - '0')
            return 1;
        else
            return -1;
    }

    return 0;
}

bool compare_charactor(char c1, char c2) {
    string s1, s2;
    if(c1 == c2)
        return false;
    else {
        if(tolower(c1) == tolower(c2))
            return c1 < c2;
        else
            return tolower(c1) < tolower(c2);
    }

    return false;
}

bool sorting(vector<string> v1, vector<string> v2) {
    for(int i = 0; i < min(v1.size(), v2.size()); ++i) {
        char v1_first = v1[i][0];
        char v2_first = v2[i][0];

        if( is_charactor(v1_first) && is_charactor(v2_first) ) {
            if(v1_first == v2_first)
                continue;
            else
                return compare_charactor(v1_first, v2_first);
        }

        else if( is_number(v1_first) && is_charactor(v2_first) )
            return true;
        else if( is_charactor(v1_first) && is_number(v2_first) )
            return false;
        
        // ELSE
        string num1 = remove_leading_zero(v1[i]);
        string num2 = remove_leading_zero(v2[i]);

        int compare_result = compare_strnum(num1, num2);

        if(compare_result == 1)
            return true;
        if(compare_result == -1)
            return false;

        int count_leading_zero_v1 = count_leading_zero(v1[i]);
        int count_leading_zero_v2 = count_leading_zero(v2[i]);

        if(count_leading_zero_v1 < count_leading_zero_v2)
            return true;
        else if(count_leading_zero_v1 > count_leading_zero_v2)
            return false;
        else
            continue;

    }

    return v1.size() < v2.size();
}

/***************************************************************/

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);

    if constexpr (local) 
        (void)!freopen("input.txt", "r", stdin);
    int n; cin >> n;

    vector<vector<string>> v;
    string temp;
    while(n--) {
        cin >> temp;
        v.push_back(tokenize(temp));
    }

    sort(v.begin(), v.end(), sorting);

    for(auto vs : v) {
        for(auto s : vs) {
            cout << s;
        } cout << endl;
    }

    return 0;
}
```