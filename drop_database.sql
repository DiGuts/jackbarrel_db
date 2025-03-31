-- Drop the tables foreign keys in order
ALTER TABLE venda
    DROP CONSTRAINT FK_venda_codiClient;
ALTER TABLE venda
    DROP CONSTRAINT FK_venda_codiVenedor;
ALTER TABLE vendaDetall
    DROP CONSTRAINT FK_vendaDetall_codiVenta;
ALTER TABLE vendaDetall
    DROP CONSTRAINT FK_vendaDetall_producte;
ALTER TABLE producte
    DROP CONSTRAINT FK_producte_codiProveidor;

-- Drop the tables in the correct order
DROP TABLE comanda CASCADE CONSTRAINTS;
DROP TABLE factura CASCADE CONSTRAINTS;
DROP TABLE vendaDetall CASCADE CONSTRAINTS;
DROP TABLE venda CASCADE CONSTRAINTS;
DROP TABLE producte CASCADE CONSTRAINTS;
DROP TABLE venedor CASCADE CONSTRAINTS;
DROP TABLE proveidor CASCADE CONSTRAINTS;
DROP TABLE client CASCADE CONSTRAINTS;