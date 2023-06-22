/abolish
/multiline on
/duplicates on
/type_casting off
/datalog

CREATE TABLE jugadores (
  nick STRING PRIMARY KEY,
  edad INTEGER CHECK (edad>0),
  ciudad STRING);

CREATE TABLE juegos (
  nombre STRING PRIMARY KEY,
  tipo STRING CHECK (tipo IN ('puzzle','estrategia','plataformas')),
  niveles INTEGER CHECK (niveles BETWEEN 1 AND 10));

CREATE TABLE partidas (
  juego STRING REFERENCES juegos(nombre),
  nick STRING REFERENCES jugadores(nick),
  nivel INTEGER CHECK (nivel BETWEEN 1 AND 10),
  superado STRING CHECK (superado IN ('S', 'N')),
  tiempo NUMBER(8,1) CHECK (tiempo>0),
  PRIMARY KEY (juego, nick, nivel));

INSERT INTO jugadores(nick, edad, ciudad) VALUES ('Azan',  20, 'Madrid');
INSERT INTO jugadores(nick, edad, ciudad) VALUES ('Basra', 18, 'Segovia');
INSERT INTO jugadores(nick, edad, ciudad) VALUES ('Cruc',  23, 'Madrid');
INSERT INTO jugadores(nick, edad, ciudad) VALUES ('Eos',   60, 'Sevilla');
INSERT INTO jugadores(nick, edad, ciudad) VALUES ('Luz',   20, 'Oviedo');
INSERT INTO jugadores(nick, edad, ciudad) VALUES ('Zorai', 10, 'Sevilla');

INSERT INTO juegos (nombre, tipo, niveles) VALUES ('Tetris',      'puzzle',      10);
INSERT INTO juegos (nombre, tipo, niveles) VALUES ('Bubble',      'puzzle',       8);
INSERT INTO juegos (nombre, tipo, niveles) VALUES ('Candy Crush', 'puzzle',      10);
INSERT INTO juegos (nombre, tipo, niveles) VALUES ('Mine',        'puzzle',       7);
INSERT INTO juegos (nombre, tipo, niveles) VALUES ('The Room',    'puzzle',       5);
INSERT INTO juegos (nombre, tipo, niveles) VALUES ('Lyne',        'puzzle',      10);
INSERT INTO juegos (nombre, tipo, niveles) VALUES ('Anomaly',     'estrategia',   2);
INSERT INTO juegos (nombre, tipo, niveles) VALUES ('Age',         'estrategia',  10);
INSERT INTO juegos (nombre, tipo, niveles) VALUES ('Empire',      'estrategia',   6);
INSERT INTO juegos (nombre, tipo, niveles) VALUES ('Oscura',      'plataformas',  4);
INSERT INTO juegos (nombre, tipo, niveles) VALUES ('BadLand',     'plataformas',  4);
INSERT INTO juegos (nombre, tipo, niveles) VALUES ('RayMan',      'plataformas', 10);

INSERT INTO partidas(juego, nick, nivel, superado)         VALUES ('Bubble',  'Azan',  1, 'N');
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Bubble',  'Basra', 1, 'S',  10.0);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Mine',    'Azan',  1, 'S',  15.0);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Mine',    'Basra', 1, 'S',  25.0);
INSERT INTO partidas(juego, nick, nivel, superado)         VALUES ('Lyne',    'Cruc',  1, 'N');
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Lyne',    'Eos',   1, 'S',  50.0);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('RayMan',  'Zorai', 1, 'S',  30.0);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('RayMan',  'Eos',   1, 'S',  30.0);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('BadLand', 'Eos',   1, 'S',  30.0);
INSERT INTO partidas(juego, nick, nivel, superado)         VALUES ('Age',     'Azan',  1, 'N');
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Age',     'Basra', 1, 'S',  20.0);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('BadLand', 'Eos',   2, 'S',  40.0);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('BadLand', 'Eos',   3, 'S',  50.0);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('BadLand', 'Eos',   4, 'S',  60.0);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('BadLand', 'Azan',  1, 'S', 140.0);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('BadLand', 'Azan',  2, 'S', 140.0);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('BadLand', 'Azan',  3, 'S', 150.0);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('BadLand', 'Azan',  4, 'S', 160.0);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Empire',  'Azan',  1, 'S',  60.0);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Empire',  'Azan',  2, 'S',  60.0);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Empire',  'Azan',  3, 'S',  60.0);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Empire',  'Azan',  4, 'S',  60.0);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Empire',  'Azan',  5, 'S',  60.0);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Empire',  'Azan',  6, 'S',  60.0);
INSERT INTO partidas(juego, nick, nivel, superado)         VALUES ('Tetris',  'Azan',  1, 'N');
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Tetris',  'Basra', 1, 'S',  10.0);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Tetris',  'Azan',  2, 'S',  15.0);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Tetris',  'Basra', 2, 'S',  25.0);
INSERT INTO partidas(juego, nick, nivel, superado)         VALUES ('Tetris',  'Cruc',  1, 'N');
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Tetris',  'Eos',   1, 'S',  50.0);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Tetris',  'Zorai', 1, 'S',  30.0);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Tetris',  'Eos',   2, 'S',  30.0);

create view v1(tipo, tiempo) as select tipo, max(tiempo) from partidas join juegos on nombre = juego where nivel = 1 and superado = 'S' group by tipo order by tipo;

create view v2(juego, jugadores) as select juego, count(nick) from partidas join juegos on nombre = juego where nivel = niveles and superado = 'S' group by juego order by juego;

create view medias(tipo, promedio) as select tipo, avg(niveles) from juegos group by tipo;
create view v3(juego, niveles, promedio) as select nombre, niveles, promedio from juegos natural join medias order by nombre;

create view maximo(edad) as select max(edad) from partidas natural join jugadores where juego = 'Tetris';
create view v4(nick, edad, ciudad) as select nick, edad, ciudad from jugadores natural join maximo order by nick;

create view sup(juego, nick, n) as select juego, nick, count(nivel) from partidas where superado = 'S' group by juego, nick;
create view posible as select nick, juego, niveles from partidas join juegos on nombre = juego where niveles = nivel and superado = 'S';
create view v5(nick, nombre) as select nick, juego from posible natural join sup where niveles > n order by nick, juego;

create view v6(nick) as select nick from (select juego, nick from partidas) division (select juego from partidas where nick = 'Basra') where nick != 'Basra' order by nick;

create view n(n) as select count(nombre) from juegos;
create view nat(N) as select 1 from dual union select N+1 from nat,n where N<n;
create view v7(letra) as select case N 
when 1 then 'a'
when 2 then 'b' 
when 3 then 'c' 
when 4 then 'd' 
when 5 then 'e.' 
when 6 then 'f' 
when 7 then 'g' 
when 8 then 'h' 
when 9 then 'i' 
when 10 then 'j' 
when 11 then 'k' 
when 12 then 'l' 
when 13 then 'm' 
when 14 then 'n' 
when 15 then 'o' 
when 16 then 'p'
when 17 then 'q' 
when 18 then 'r' 
when 19 then 's'
when 20 then 't'
when 21 then 'u'
when 22 then 'v'
when 23 then 'w'
when 24 then 'x'
when 25 then 'y'
when 26 then 'z'
else 'Invalid number' end as letra from nat;

SELECT * FROM v1;
SELECT * FROM v2;
SELECT * FROM v3;
SELECT * FROM v4;
SELECT * FROM v5;
SELECT * FROM v6;
SELECT * FROM v7;

