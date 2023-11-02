#  MySQL 임의의 연속된 날짜 데이터 Select 하기

일별 통계를 뽑아낼 때, 특정 날짜에 데이터가 존재하지 않는 경우 통계 데이터에서 해당 날짜가 비어있는 경우가있습니다. 다음 쿼리로 먼저 연속된 날짜를 `SELECT`해서 `JOIN` 하면 연속된 날짜로 만들어 줄 수 있습니다.
<!--more-->

```sql
with recursive calendar as (
		select (select createdAt from Strategy where id = ?1
	) as createdAt
union all
select createdAt + interval 1 day as d
	from calendar
where createdAt + interval 1 day < now())
select * from calendar
```
