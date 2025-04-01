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
        ACTUALITZAR_COMPRES_PROVEIDOR(p.codiproducte, comanda_quantitat);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(SQLERRM);
END;



