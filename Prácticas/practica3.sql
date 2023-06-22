/sql
create table programadores(dni string primary key, nombre string, dirección string, teléfono string);
insert into programadores values('1','Jacinto','Jazmín 4','91-8888888');
insert into programadores values('2','Herminia','Rosa 4','91-7777777');
insert into programadores values('3','Calixto','Clavel 3','91-1231231');
insert into programadores values('4','Teodora','Petunia 3','91-6666666');

create table analistas(dni string primary key, nombre string, dirección string, teléfono string);
insert into analistas values('4','Teodora','Petunia 3','91-6666666');
insert into analistas values('5','Evaristo','Luna 1','91-1111111');
insert into analistas values('6','Luciana','Júpiter 2','91-8888888');
insert into analistas values('7','Nicodemo','Plutón 3',NULL);

create table distribución(códigoPr string, dniEmp string, horas int, primary key (códigoPr, dniEmp));
insert into distribución values('P1','1',10);
insert into distribución values('P1','2',40);
insert into distribución values('P1','4',5);
insert into distribución values('P2','4',10);
insert into distribución values('P3','1',10);
insert into distribución values('P3','3',40);
insert into distribución values('P3','4',5);
insert into distribución values('P3','5',30);
insert into distribución values('P4','4',20);
insert into distribución values('P4','5',10);

create table proyectos(código string primary key, descripción string, dniDir string);
insert into proyectos values('P1','Nómina','4');
insert into proyectos values('P2','Contabilidad','4');
insert into proyectos values('P3','Producción','5');
insert into proyectos values('P4','Clientes','5');
insert into proyectos values('P5','Ventas','6');

create view vista1(dni) as select dni from programadores union select dni from analistas;

create view vista2(dni) as select dni from programadores intersect select dni from analistas;

create view vista3(dni) as (select * from vista1 except select dniEmp as dni from distribución) except select dniDir as dni from proyectos;

create view vista4(código) as (select código as códigoPr from proyectos) except (select códigoPr from analistas join distribución on dni = dniEmp);

create view vista5(dni) as (select dni from analistas except select dni from programadores) intersect (select dniDir as dni from proyectos);

create view vista6(descripción, nombre, horas) as select descripción, nombre, horas from ((select dni as dniEmp, nombre from programadores) natural join (select * from distribución) natural join (select código as códigoPr, descripción from proyectos));

create view vista7(teléfono) as select teléfono from (select * from programadores union select * from analistas) group by teléfono having count(teléfono) > 1;

create view vista8(dni) as select dni from (select * from programadores natural join select * from analistas);

create view vista9(dni, horas) as select dniEmp, sum(horas) as horas from distribución group by dniEmp;

create view vista10(dni, nombre, proyecto) as select dni, nombre, códigoPr from (select dni, nombre from programadores union select dni, nombre from analistas) left join select dniEmp, códigoPr from distribución on dni = dniEmp;

create view vista11(dni, nombre) as select dni, nombre from programadores where teléfono is null union select dni, nombre from analistas where teléfono is null;

create view v12(m) as select avg(n) from (select códigoPr, sum(horas)/count(*) as n from distribución group by códigoPr);
create view b12(dni, h) as select dniEmp, SUM(horas) / count(*) from distribución group by dniEmp;
create view vista12(dni) as select dni from b12, v12 where h < m;

create view prEvaristo (códigoPr) as select códigoPr from ((select dniEmp, códigoPr from distribución) natural join select dni as dniEmp, nombre from (select * from analistas union select * from programadores)) where nombre = 'Evaristo';
create view vista13(dni) as select dniEmp from ((select códigoPr , dniEmp from distribución) division select * from prEvaristo);

create view numero(dni, n) as select dniEmp, count(códigoPr) from distribución, prEvaristo where prEvaristo.códigoPr = distribución.códigoPr group by dniEmp;
create view vista14 (dni) as select dni from (select max(n) as m from numero), numero where n = m;

create view trabConEv(dni) as select dniEmp from prEvaristo, distribución where prEvaristo.códigoPr = distribución.códigoPr;
create view vista15(códigoPr, dni, horas) as select códigoPr, dni, horas*1.2 from ((select dniEmp as dni from distribución) except select * from trabConEv), distribución where dni = dniEmp;

create view es_jefe(jefe, emp) as select dniDir, dniEmp from proyectos join distribución on código = códigoPr;
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
