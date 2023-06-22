/abolish
/duplicates off
/multiline on

-- Base relation
/SET bound 5

CREATE TABLE r(x INT);
INSERT INTO r WITH n(x) AS SELECT 1 UNION SELECT x+1 FROM n WHERE x<$bound$ SELECT * FROM n;
--CREATE TABLE r(x string);
--insert into r values ('a');
--insert into r values ('b');


create view s as 
with aux(rank, x) as (select 1, x from r union select rank+1, r.x from aux, r where r.x > aux.x)
select * from aux order by rank desc;

create view u(x) as select top 1 rank from s;
create view t(x) as select x mod 2 from u;

create view even_or_odd as select 
case x
when 1 then 'r is odd'
else 'r is even'
end
as s from t;

select * from even_or_odd;