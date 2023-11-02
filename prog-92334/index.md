# Programmers 신고 결과 받기 C++

<!--more-->
[코딩테스트 연습 - 신고 결과 받기](https://programmers.co.kr/learn/courses/30/lessons/92334)

## 접근 방법

### 필요한 자료구조  
- `unordered_set<string>`
	- `v` = 중복된 신고를 제거
- `unordered_map<string, vector<string>>` 
	- `k` = 신고 당한 id 
	- `v` = 신고자 id 리스트
- `unordered_map<string, int>`
	- `k`     = 유저 id
	- `v` = 메일을 받은 횟수

중복된 신고를 제거하고, report_record에 신고 현황을 저장합니다. 이후 report_record에 대한 루프를 돌면서 report_record[id].size() 가 k 보다 크다면 report_record[id]에 대한 루프를 돌면서 mail_count[report_record[id][i]]++ 를 합니다.

## 코드

```cpp
#include <bits/stdc++.h>

#define fi first
#define se second

using namespace std;

pair<string, string> split(string s) {
    stringstream ss(s);
    string from, to;
    ss >> from;
    ss >> to;
    return {from, to};
}

vector<int> solution(vector<string> id_list, vector<string> report, int k) {
    vector<int> answer;
    unordered_map<string, vector<string>> report_record;
    unordered_map<string, int> mail_count;
    unordered_set<string> set_report;
    
    for (auto r : report) {
        set_report.insert(r);
    }
    
    for (auto r : set_report) {
        pair<string, string> p = split(r);
        report_record[p.se].push_back(p.fi);
    }
    
    for (auto record : report_record) {
        vector<string> reporters = record.se;
        if (reporters.size() < k) {
            continue;
        }
        
        for (auto r : reporters) {
            mail_count[r]++;
        }
    }
    
    for (auto id : id_list) {
        answer.push_back(mail_count[id]);
    }
    
    return answer;
}
```
