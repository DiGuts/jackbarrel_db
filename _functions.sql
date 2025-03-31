-- Funció total_venda(idVenda): retorna el total a pagar d'una venda.

create or replace function total_venda(cVenda int) return number is
    tVenda number := 0;
begin
    select sum(preu * QUANTITAT) into tVenda
    from PRODUCTE join VENDADETALL on PRODUCTE.CODIPRODUCTE = VENDADETALL.PRODUCTE
                  join VENDA on VENDADETALL.CODIVENTA = VENDA.CODIVENDA
    where VENDA.CODIVENDA = cVenda;
    return tVenda;
end;
