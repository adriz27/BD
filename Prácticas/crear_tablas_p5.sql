DROP TABLE pedidos;
DROP TABLE contiene;
DROP TABLE auditoría;

CREATE TABLE pedidos (
  código   VARCHAR2(6) PRIMARY KEY, 
  fecha    VARCHAR2(10), 
  importe  NUMBER(6,2), 
  cliente  VARCHAR2(20),
  notas    VARCHAR(1024),
  especial VARCHAR(1),
  CHECK (especial LIKE "S" OR especial LIKE "N"));

CREATE TABLE contiene
  (pedido   VARCHAR2(6),
   plato    VARCHAR2(20),
   precio	NUMBER(6, 2),
   unidades NUMBER(2, 0),
   PRIMARY KEY (pedido, plato));

   
CREATE TABLE auditoría
  (operación VARCHAR2(6),
   tabla	 VARCHAR2(50) REFERENCES pedidos ON DELETE CASCADE,
   fecha     VARCHAR2(10),
   hora      VARCHAR2(8)
   );
   
INSERT INTO auditoría VALUES("INSERT", "pedidos", "06/01/2021", "04:27:06");

INSERT INTO contiene VALUES("000000", "4 quesos", 10, 2);
INSERT INTO contiene VALUES("000001", "4 quesos", 10, 1);
INSERT INTO contiene VALUES("000001", "bbq", 10, 1);

INSERT INTO pedidos VALUES("000000", "06/01/2021", 20, "Pepe", "", "N");
INSERT INTO pedidos VALUES("000001", "06/01/2021", 20, "Juan", "Sin gluten", "S");

COMMIT;