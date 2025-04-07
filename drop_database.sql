-- Drop the tables foreign keys in order
ALTER TABLE venda
    DROP CONSTRAINT fk_venda_codiclient;
ALTER TABLE venda
    DROP CONSTRAINT fk_venda_codivenedor;
ALTER TABLE vendadetall
    DROP CONSTRAINT fk_vendadetall_codiventa;
ALTER TABLE vendadetall
    DROP CONSTRAINT fk_vendadetall_producte;
ALTER TABLE producte
    DROP CONSTRAINT fk_producte_codiproveidor;

-- Drop the tables in the correct order
DROP TABLE comanda CASCADE CONSTRAINTS;
DROP TABLE factura CASCADE CONSTRAINTS;
DROP TABLE vendadetall CASCADE CONSTRAINTS;
DROP TABLE venda CASCADE CONSTRAINTS;
DROP TABLE producte CASCADE CONSTRAINTS;
DROP TABLE venedor CASCADE CONSTRAINTS;
DROP TABLE proveidor CASCADE CONSTRAINTS;
DROP TABLE client CASCADE CONSTRAINTS;