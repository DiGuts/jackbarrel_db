ALTER SESSION SET "_ORACLE_SCRIPT"= TRUE;

-- Creació de rols

CREATE ROLE rol_vendes;
CREATE ROLE rol_compres;
CREATE ROLE rol_administracio;
CREATE ROLE rol_admin_total;

-- poden generar vendes
GRANT SELECT ON venda TO rol_vendes;
GRANT SELECT ON vendadetall TO rol_vendes;
GRANT EXECUTE ON nova_venda TO rol_vendes;

-- només poden veure les dades de les Comandes
GRANT SELECT ON comanda TO rol_compres;

-- no poden generar vendes, però tenen accés a les factures.
GRANT SELECT ON factura TO rol_administracio;

-- ROL AMB ACCÉS TOTAL
GRANT SELECT, INSERT, UPDATE, DELETE ON client TO rol_admin_total;
GRANT SELECT, INSERT, UPDATE, DELETE ON proveidor TO rol_admin_total;
GRANT SELECT, INSERT, UPDATE, DELETE ON venedor TO rol_admin_total;
GRANT SELECT, INSERT, UPDATE, DELETE ON producte TO rol_admin_total;
GRANT SELECT, INSERT, UPDATE, DELETE ON venda TO rol_admin_total;
GRANT SELECT, INSERT, UPDATE, DELETE ON vendadetall TO rol_admin_total;
GRANT SELECT, INSERT, UPDATE, DELETE ON factura TO rol_admin_total;
GRANT SELECT, INSERT, UPDATE, DELETE ON comanda TO rol_admin_total;

-- creació dels usuaris

-- VENDES
CREATE USER empl_vendes1 IDENTIFIED BY password1;
CREATE USER empl_vendes2 IDENTIFIED BY password2;
CREATE USER empl_vendes3 IDENTIFIED BY password3;

GRANT rol_vendes TO empl_vendes1;
GRANT rol_vendes TO empl_vendes2;
GRANT rol_vendes TO empl_vendes3;

-- COMPRES
CREATE USER emp_compres1 IDENTIFIED BY password1;
CREATE USER emp_compres2 IDENTIFIED BY password2;
CREATE USER emp_compres3 IDENTIFIED BY password3;

GRANT rol_compres TO emp_compres1;
GRANT rol_compres TO emp_compres2;
GRANT rol_compres TO emp_compres3;

-- ADMINISTRACIÓ
CREATE USER emp_admin1 IDENTIFIED BY password1;
CREATE USER emp_admin2 IDENTIFIED BY password2;
CREATE USER emp_admin3 IDENTIFIED BY password3;

GRANT rol_administracio TO emp_admin1;
GRANT rol_administracio TO emp_admin2;
GRANT rol_administracio TO emp_admin3;

-- USUARI AMB ACCÉS COMPLET
CREATE USER superuser IDENTIFIED BY superpass;
GRANT rol_admin_total TO superuser;