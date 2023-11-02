# Programmers 소수 만들기 C++

<!--more-->
[코딩테스트 연습 - 소수 만들기](https://programmers.co.kr/learn/courses/30/lessons/12977)

## 접근 방법

주어진 벡터에서 3개의 숫자를 중복되지 않게 선택할 수 있는 모든 경우의 수를 구하기 위한 루프를 돕니다. $O(N^3)$의 복잡도가 소요되며 입력된 벡터의 길이가 50개 이므로 충분한 시간내에 수행할 수 있습니다.

이후 3개의 숫자를 더한 값에 대해 $\sqrt N$ 까지 나누어 보는 것으로 소수판정을 합니다.

## 코드

```cpp
#include <bits/stdc++.h>

using namespace std;

bool check(int num) {
    for (int i = 2; i <= sqrt(num); ++i) {
        if (num % i == 0) {
            return false;
        }
    }
    
    return true;
}

int solution(vector<int> nums) {
    int answer = 0;
    
    for (int i = 0; i < nums.size(); ++i) {
        for (int j = i + 1; j < nums.size(); ++j) {
            for (int k = j + 1; k < nums.size(); ++k) {
                int sum = nums[i] + nums[j] + nums[k];
                if (check(sum)) {
                    answer++;
                }
            }
        }
    }

    return answer;
}
```
