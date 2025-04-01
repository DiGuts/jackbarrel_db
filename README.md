# Jack Barrel - Database

## Descripció
Aquesta base de dades gestiona informació sobre clients, proveïdors, venedors, productes i vendes. Tot i que l'exemple està enfocat en botelles i barrils de Jack Daniels, l'estructura permet gestionar qualsevol tipus de producte.

## Fitxers
- **create_database.sql**: Creació de la base de dades.
- **drop_database.sql**: Eliminació de la base de dades.
- **_procedures.sql**: Procediments.
- **_functions.sql**: Funcions.
- **_triggers.sql**: Triggers.
- **demo_data.sql**: Dades de prova.

## Taules Principals

### `client`
Emmagatzema la informació dels clients, incloent-hi les seves dades personals i el total de compres realitzades.

### `proveidor`
Registra els proveïdors de productes, incloent les seves dades de contacte i el valor total de les compres fetes.

### `venedor`
Conté la informació dels venedors, incloent la seva comissió i salari.

### `producte`
Llista els productes disponibles, especificant el proveïdor, descripció, preu i estoc.

### `venda`
Registra cada venda realitzada, indicant el client, el venedor i la data de la transacció.

### `vendaDetall`
Manté els detalls de cada venda, especificant quins productes es van vendre i en quina quantitat.

### `factura`
Conté informació detallada de cada factura, incloent-hi les dades del client, venedor, descompte, IVA i preu final.

### `comanda`
Registra les comandes de productes, indicant el codi del producte, la quantitat sol·licitada i la data de comanda.

## Relacions Clau
- **`venda` → `client`**: Cada venda està associada a un client.
- **`venda` → `venedor`**: Cada venda és realitzada per un venedor.
- **`vendaDetall` → `venda`**: Cada detall de venda pertany a una venda específica.
- **`vendaDetall` → `producte`**: Cada línia de detall de venda correspon a un producte específic.
- **`producte` → `proveidor`**: Cada producte prové d’un proveïdor.

## Restriccions i Validacions
- `descompte` i `iva` han d'estar entre `0 i 100`.
- L'estoc mínim i actual es gestionen a la taula `producte` per evitar la falta d'inventari.

## Ús
Per crear la base de dades, executa el fitxer SQL en el teu gestor de bases de dades preferit:
```sql
@create_database.sql
```

Un cop creada la base de dades, pots començar a inserir dades i fer consultes per obtenir informació sobre vendes, clients i proveïdors.

---
Aquesta documentació proporciona una visió general del projecte. Si necessites més detalls o instruccions específiques, assegura't de revisar el codi SQL proporcionat.