CREATE OR REPLACE TRIGGER tr_update_client
    after insert on VENDA
    for each row
    declare
        PRAGMA AUTONOMOUS_TRANSACTION;
    begin
        UPDATE CLIENT
        SET client.VALORTOTALVENDES = CLIENT.VALORTOTALVENDES + TOTAL_VENDA(:new.CODIVENDA)
        WHERE CLIENT.CODICLIENT = :NEW.CODICLIENT;
        commit;
    end;

UPDATE CLIENT
SET client.VALORTOTALVENDES = 0;

DROP TRIGGER  TR_UPDATE_CLIENT;

select * from CLIENT;
select * from VENEDOR;
select * from VENDA;

call NOVA_VENDA(5, 1, 2);
