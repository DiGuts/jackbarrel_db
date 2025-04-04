-- Procediment llistar_factura(venda): ensenya la factura a la consola

CREATE OR REPLACE PROCEDURE llistar_factura(idvenda INT) AS
    f factura%rowtype;
BEGIN
    SELECT *
    INTO f
    FROM factura
    WHERE codivenda = idvenda;

    dbms_output.put_line(f.codivenda || ' | (' || f.codiclient || ') ' || f.client_nom || ' ' || f.client_cognom1 ||
                         ' ' || f.client_cognom2 || ' → (' || f.client_telefon || ') | ' ||
                         f.codivenedor || ' | ' || f.venedor_nom || ' ' || f.venedor_cognom1 || ' ' ||
                         f.venedor_cognom2 || ' → (' || f.venedor_telefon || ') | ' || f.datavenda || ' | ' ||
                         f.descompteaplicat || '% | ' ||
                         ROUND(f.totalfactura, 2) || '€ + ' || ROUND(f.totalfactura * (f.iva / 100), 2) ||
                         '€ (IVA) - ' ||
                         ROUND(f.totalfactura * f.descompteaplicat / 100, 2) || '€ (DESCOMPTE) = ' ||
                         ROUND(f.preufinal, 2) || '€');
END;

-- Procediment actualitzar vendes client.

create or replace procedure actualitzar_vendes_client (cVenda int, cClient int) is
begin
    UPDATE client
    SET client.valortotalvendes = client.valortotalvendes + total_venda(cVenda)
    WHERE client.codiclient = cClient;
    COMMIT;
end;

-- Procediment valida_venda(venda): crea una factura

CREATE OR REPLACE PROCEDURE valida_venda(idvenda INT) AS
    f          factura%rowtype;
    venta_cost number := total_venda(idvenda);
BEGIN
    SELECT venda.codivenda,
           client.codiclient,
           client.nom,
           client.cognom1,
           client.cognom2,
           client.telefon,
           venedor.codivenedor,
           venedor.nom,
           venedor.cognom1,
           venedor.cognom2,
           venedor.telefon,
           venda.datavenda,
           venda.descompteaplicat,
           venta_cost,
           21                                                              AS iva,
           venta_cost - (venta_cost * venda.descompteaplicat / 100) * 1.21 AS preufinal
    INTO f
    FROM client
             JOIN venda ON client.codiclient = venda.codiclient
             JOIN venedor ON venda.codivenedor = venedor.codivenedor
    WHERE venda.codivenda = idvenda;

    actualitzar_vendes_client(f.CODIVENDA, f.CODICLIENT);

    INSERT INTO factura
    VALUES (f.codivenda,
            f.codiclient,
            f.client_nom,
            f.client_cognom1,
            f.client_cognom2,
            f.client_telefon,
            f.codivenedor,
            f.venedor_nom,
            f.venedor_cognom1,
            f.venedor_cognom2,
            f.venedor_telefon,
            f.datavenda,
            f.descompteaplicat,
            f.totalfactura,
            f.iva,
            f.preufinal);
    COMMIT;

END;

-- Procediment nova_venda(venda, client, venedor): crea una venda sense articles

CREATE OR REPLACE PROCEDURE nova_venda(cvenda int, cclient int, cvenedor int) IS

    daplicat int := 0;
    noclient EXCEPTION;
    integritatref EXCEPTION;
    PRAGMA EXCEPTION_INIT (integritatref, -2292);


BEGIN
    BEGIN
        SELECT descompte INTO daplicat FROM client WHERE codiclient = cclient;
    EXCEPTION
        WHEN no_data_found THEN
            RAISE noclient;
    END;

    INSERT INTO venda
    VALUES (cvenda, cclient, cvenedor, SYSDATE, daplicat);
    COMMIT;

EXCEPTION
    WHEN noclient THEN
        dbms_output.put_line('Error: El client amb codi ' || cclient || ' no existeix.');
    WHEN integritatref THEN
        dbms_output.put_line('Error: No es pot inserir la venda per un problema d''integritat referencial.');
    WHEN OTHERS THEN dbms_output.put_line('Error Inesperat' || SQLCODE || SQLERRM);
END;

-- Procediment linia_venda(lineaVenda,idvenda, idproducte, quantitat): insereix una línia a la venda.

CREATE OR REPLACE PROCEDURE linea_venda(clineavenda int, cvenda int, cproducte int, quantitat int) IS

    integritatref EXCEPTION;
    PRAGMA EXCEPTION_INIT (integritatref, -2292);

BEGIN

    INSERT INTO vendadetall
    VALUES (clineavenda, cvenda, cproducte, quantitat);
    COMMIT;


EXCEPTION

    WHEN integritatref THEN
        dbms_output.put_line('Error: No es pot inserir la venda per un problema d''integritat referencial.');
    WHEN OTHERS THEN dbms_output.put_line('Error Inesperat');

END;

-- Procediment llista_estoc(): llista els productes i el seu stock

CREATE OR REPLACE PROCEDURE llista_estoc AS
    CURSOR llista_productes IS
        SELECT *
        FROM producte;
BEGIN
    FOR i IN llista_productes
        LOOP
            dbms_output.put_line(i.nom || ' (' || i.stockactual || ')');
        END LOOP;
END;

-- Procediment per a actualitzar el total de compres fetes al proveidor.
create or replace procedure actualitzar_compres_proveidor (cProducte int, qComanda int) is
    pProducte int;
    cProveidor int;

begin
    SELECT PREU, CODIPROVEIDOR
    INTO pProducte, cProveidor
    FROM PRODUCTE
    WHERE CODIPRODUCTE = cProducte;

    UPDATE PROVEIDOR
    SET PROVEIDOR.VALORTOTALCOMPRES = PROVEIDOR.VALORTOTALCOMPRES + (pProducte * qComanda)
    WHERE PROVEIDOR.CODIPROVEIDOR = cProveidor;
    COMMIT;
end;
