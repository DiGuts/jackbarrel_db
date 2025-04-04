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

    UPDATE PRODUCTE SET STOCKACTUAL = STOCKACTUAL - quantitat
    WHERE CODIPRODUCTE = cproducte;

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

CREATE OR REPLACE TRIGGER vendadetall_validacio
    BEFORE UPDATE OR INSERT
    ON vendadetall
    FOR EACH ROW
DECLARE
    producte_id    NUMBER;
    producte_stock NUMBER;
BEGIN
    SELECT codiproducte, stockactual INTO producte_id, producte_stock FROM producte WHERE :NEW.producte = codiproducte;

    IF :NEW.quantitat < producte_stock THEN
        UPDATE producte
        SET stockactual = PRODUCTE.stockactual - :NEW.quantitat
        WHERE codiproducte = producte_id;
    END IF;
END;

CREATE OR REPLACE TRIGGER evitar_venda_fora_horari
    BEFORE INSERT OR UPDATE ON VENDA
    FOR EACH ROW
DECLARE
    v_hora NUMBER;
    v_dia NUMBER;
BEGIN
    -- Extreure l'hora i el dia de la setmana de la data de la venda
    v_hora := TO_NUMBER(TO_CHAR(:NEW.DATAVENDA, 'HH24'));
    v_dia := TO_NUMBER(TO_CHAR(:NEW.DATAVENDA, 'D')); -- 1 = Diumenge, 2 = Dilluns, ..., 7 = Dissabte

    -- En un sistema on la setmana comença en diumenge, cal ajustar l'índex del dia
    IF v_dia = 1 OR v_dia = 7 OR v_hora < 8 OR v_hora >= 15 THEN
        RAISE_APPLICATION_ERROR(-20001, 'No es poden fer vendes fora de l''horari d''obertura (8h-15h, laborables)');
    END IF;
END;
