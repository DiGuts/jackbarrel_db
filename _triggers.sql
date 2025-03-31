CREATE OR REPLACE TRIGGER tr_update_client
    AFTER INSERT
    ON venda
    FOR EACH ROW
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    UPDATE client
    SET client.valortotalvendes = client.valortotalvendes + total_venda(:new.codivenda)
    WHERE client.codiclient = :new.codiclient;
    COMMIT;
END;

UPDATE client
SET client.valortotalvendes = 0;

DROP TRIGGER tr_update_client;

SELECT *
FROM client;
SELECT *
FROM venedor;
SELECT *
FROM venda;

CALL nova_venda(5, 1, 2);

CREATE OR REPLACE TRIGGER restock
    AFTER UPDATE OR INSERT
    ON vendadetall
    FOR EACH ROW
DECLARE
    p                 producte%rowtype;
    codi_comanda      INT;
    comanda_quantitat NUMBER;
BEGIN
    SELECT * INTO p FROM producte WHERE codiproducte = :new.producte;

    SELECT NVL(MAX(codicomanda), 0) INTO codi_comanda FROM comanda;
    codi_comanda := codi_comanda + 1;

    IF p.stockactual < p.stockminim THEN
        comanda_quantitat := p.stockminim - p.stockactual;
        INSERT INTO comanda
        VALUES (codi_comanda, p.codiproducte, comanda_quantitat, SYSDATE);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(SQLERRM);
END;