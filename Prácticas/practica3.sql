/sql
create table programadores(dni string primary key, nombre string, direcci�n string, tel�fono string);
insert into programadores values('1','Jacinto','Jazm�n 4','91-8888888');
insert into programadores values('2','Herminia','Rosa 4','91-7777777');
insert into programadores values('3','Calixto','Clavel 3','91-1231231');
insert into programadores values('4','Teodora','Petunia 3','91-6666666');

create table analistas(dni string primary key, nombre string, direcci�n string, tel�fono string);
insert into analistas values('4','Teodora','Petunia 3','91-6666666');
insert into analistas values('5','Evaristo','Luna 1','91-1111111');
insert into analistas values('6','Luciana','J�piter 2','91-8888888');
insert into analistas values('7','Nicodemo','Plut�n 3',NULL);

create table distribuci�n(c�digoPr string, dniEmp string, horas int, primary key (c�digoPr, dniEmp));
insert into distribuci�n values('P1','1',10);
insert into distribuci�n values('P1','2',40);
insert into distribuci�n values('P1','4',5);
insert into distribuci�n values('P2','4',10);
insert into distribuci�n values('P3','1',10);
insert into distribuci�n values('P3','3',40);
insert into distribuci�n values('P3','4',5);
insert into distribuci�n values('P3','5',30);
insert into distribuci�n values('P4','4',20);
insert into distribuci�n values('P4','5',10);

create table proyectos(c�digo string primary key, descripci�n string, dniDir string);
insert into proyectos values('P1','N�mina','4');
insert into proyectos values('P2','Contabilidad','4');
insert into proyectos values('P3','Producci�n','5');
insert into proyectos values('P4','Clientes','5');
insert into proyectos values('P5','Ventas','6');

create view vista1(dni) as select dni from programadores union select dni from analistas;

create view vista2(dni) as select dni from programadores intersect select dni from analistas;

create view vista3(dni) as (select * from vista1 except select dniEmp as dni from distribuci�n) except select dniDir as dni from proyectos;

create view vista4(c�digo) as (select c�digo as c�digoPr from proyectos) except (select c�digoPr from analistas join distribuci�n on dni = dniEmp);

create view vista5(dni) as (select dni from analistas except select dni from programadores) intersect (select dniDir as dni from proyectos);

create view vista6(descripci�n, nombre, horas) as select descripci�n, nombre, horas from ((select dni as dniEmp, nombre from programadores) natural join (select * from distribuci�n) natural join (select c�digo as c�digoPr, descripci�n from proyectos));

create view vista7(tel�fono) as select tel�fono from (select * from programadores union select * from analistas) group by tel�fono having count(tel�fono) > 1;

create view vista8(dni) as select dni from (select * from programadores natural join select * from analistas);

create view vista9(dni, horas) as select dniEmp, sum(horas) as horas from distribuci�n group by dniEmp;

create view vista10(dni, nombre, proyecto) as select dni, nombre, c�digoPr from (select dni, nombre from programadores union select dni, nombre from analistas) left join select dniEmp, c�digoPr from distribuci�n on dni = dniEmp;

create view vista11(dni, nombre) as select dni, nombre from programadores where tel�fono is null union select dni, nombre from analistas where tel�fono is null;

create view v12(m) as select avg(n) from (select c�digoPr, sum(horas)/count(*) as n from distribuci�n group by c�digoPr);
create view b12(dni, h) as select dniEmp, SUM(horas) / count(*) from distribuci�n group by dniEmp;
create view vista12(dni) as select dni from b12, v12 where h < m;

create view prEvaristo (c�digoPr) as select c�digoPr from ((select dniEmp, c�digoPr from distribuci�n) natural join select dni as dniEmp, nombre from (select * from analistas union select * from programadores)) where nombre = 'Evaristo';
create view vista13(dni) as select dniEmp from ((select c�digoPr , dniEmp from distribuci�n) division select * from prEvaristo);

create view numero(dni, n) as select dniEmp, count(c�digoPr) from distribuci�n, prEvaristo where prEvaristo.c�digoPr = distribuci�n.c�digoPr group by dniEmp;
create view vista14 (dni) as select dni from (select max(n) as m from numero), numero where n = m;

create view trabConEv(dni) as select dniEmp from prEvaristo, distribuci�n where prEvaristo.c�digoPr = distribuci�n.c�digoPr;
create view vista15(c�digoPr, dni, horas) as select c�digoPr, dni, horas*1.2 from ((select dniEmp as dni from distribuci�n) except select * from trabConEv), distribuci�n where dni = dniEmp;

create view es_jefe(jefe, emp) as select dniDir, dniEmp from proyectos join distribuci�n on c�digo = c�digoPr;
create view jefe(jefe, emp) as (select * from es_jefe) union (select j2, e1 from (select jefe as j1, emp as e1 from es_jefe) join (select jefe as j2, emp as e2 from es_jefe) on j1 = e2);
create view dniEv(dni) as (select dni from analistas where nombre = 'Evaristo') union (select dni from programadores  where nombre = 'Evaristo');
create view dniEmpleados(dni) as select emp from jefe, dniEv where emp != dni and jefe = dni;
create view vista16(nombre) as select nombre from (select dni, nombre from dniEmpleados natural join analistas) union (select dni, nombre from dniEmpleados natural join programadores);

select * from vista1;
select * from vista2;
select * from vista3;
select * from vista4;
select * from vista5;
select * from vista6;
select * from vista7;
select * from vista8;
select * from vista9;
select * from vista10;
select * from vista11;
select * from vista12;
select * from vista13;
select * from vista14;
select * from vista15;
select * from vista16;
