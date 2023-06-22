/duplicates on
/sql
CREATE TABLE t(x) AS
  SELECT 1 UNION ALL  
  SELECT 1 UNION ALL 
  SELECT 1 UNION ALL
  SELECT 2 UNION ALL 
  SELECT 3 UNION ALL 
  SELECT 3;

CREATE TABLE s(x) AS
  SELECT 1 UNION ALL 
  SELECT 1 UNION ALL 
  SELECT 2 UNION ALL 
  SELECT 4;

--INTERSECCIÓN
create view a as select x, n, m from (select x, count(x) as n from t group by x),(select x as y, count(x) as m from s group by x) where x = y;

create view b as (select x, n as mi from a where n < m) union (select x, m as mi from a where n > m) union (select x, 0 as mi from a where n = m);

create view c as select distinct * from b natural join a;

create view intersect as (select x from c natural join t where mi = n) union all (select x from c natural join s where mi = m or mi = 0);

--DIFERENCIA
create view d as select x, n, m from (select x, count(x) as n from t group by x)natural full join (select x, count(x) as m from s group by x) where n is not null;

create view e as (select x, n-m as n from d where m is not null and n>m) union (select x, 0 as n from d where m is not null and n<=m) union (select x, n from d where m is null);

create view maximo(maxi) as select max(n) from e;

create view num(N) as select 0 from dual union (select N+1 from num, maximo where N<maxi);

create view except as select x from e, num where n > num.N;
