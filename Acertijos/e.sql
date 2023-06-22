
--Adrián Pérez Peinador

create view euler(N, fact, e) as select 0, 1, 1.0 from dual union select N+1, fact*(N+1), e + (1/fact) from euler;

create view aux(a, e) as select top 1 N, e from euler;
create view e(n) as select e from aux;

select * from e;