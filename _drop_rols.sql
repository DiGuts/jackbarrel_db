ALTER SESSION SET "_ORACLE_SCRIPT"= TRUE;

-- Eliminar usuaris
DROP USER empl_vendes1 CASCADE;
DROP USER empl_vendes2 CASCADE;
DROP USER empl_vendes3 CASCADE;

DROP USER emp_compres1 CASCADE;
DROP USER emp_compres2 CASCADE;
DROP USER emp_compres3 CASCADE;

DROP USER emp_admin1 CASCADE;
DROP USER emp_admin2 CASCADE;
DROP USER emp_admin3 CASCADE;

DROP USER superuser CASCADE;

-- Eliminar rols
DROP ROLE rol_vendes;
DROP ROLE rol_compres;
DROP ROLE rol_administracio;
DROP ROLE rol_admin_total;