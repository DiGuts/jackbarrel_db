-- Funció total_venda(idVenda): retorna el total a pagar d'una venda.

CREATE OR REPLACE FUNCTION total_venda(cvenda int) RETURN number IS
    tvenda number := 0;
BEGIN
    SELECT SUM(preu * quantitat)
    INTO tvenda
    FROM producte
             JOIN vendadetall ON producte.codiproducte = vendadetall.producte
             JOIN venda ON vendadetall.codiventa = venda.codivenda
    WHERE venda.codivenda = cvenda;
    RETURN tvenda;
END;
