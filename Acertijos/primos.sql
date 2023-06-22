
--Adrián Pérez Peinador

/set cota 20

create view nat(N) as select 1 from dual union select N+1 from nat;

create view n(N) as select top $cota$  N from nat where N != 1;
create view m(M) as select top $cota$  N from nat where N != 1;

create view primos(x) as select * from n except select N from n, m where N > M and N mod M = 0;
