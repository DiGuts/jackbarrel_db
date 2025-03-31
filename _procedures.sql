-- Procediment nova_venda(venda, client, venedor): crea una venda sense articles

create or replace procedure nova_venda(cVenda int, cClient int, cVenedor int) is

    dAplicat int := 0;
    noClient EXCEPTION;
    integritatRef exception;
    pragma exception_init (integritatRef, -2292);


begin
    BEGIN
        SELECT descompte INTO dAplicat FROM client WHERE codiClient = cClient;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE noClient;
    END;

    insert into venda
    values (cVenda, cClient, cVenedor, sysdate, dAplicat);
    commit;

exception
    WHEN noClient THEN
        DBMS_OUTPUT.PUT_LINE('Error: El client amb codi ' || cClient || ' no existeix.');
    WHEN integritatRef THEN
        DBMS_OUTPUT.PUT_LINE('Error: No es pot inserir la venda per un problema d''integritat referencial.');
    when others then DBMS_OUTPUT.PUT_LINE('Error Inesperat' || SQLCODE || SQLERRM);
end;

-- Procediment linia_venda(lineaVenda,idvenda, idproducte, quantitat): insereix una línia a la venda.

create or replace procedure linea_venda(cLineaVenda int, cVenda int, cProducte int, quantitat int) is

    integritatRef exception;
    pragma exception_init (integritatRef, -2292);

begin

    insert into VENDADETALL
    values (cLineaVenda, cVenda, cProducte, QUANTITAT);
    commit;

exception

    WHEN integritatRef THEN
        DBMS_OUTPUT.PUT_LINE('Error: No es pot inserir la venda per un problema d''integritat referencial.');
    when others then DBMS_OUTPUT.PUT_LINE('Error Inesperat');


end;



