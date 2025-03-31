CREATE TABLE client
(
    codiClient       int PRIMARY KEY,
    dni              varchar2(9),
    nom              varchar2(64),
    cognom1          varchar2(64),
    cognom2          varchar2(64),
    direccio         varchar2(255),
    poblacio         varchar2(255),
    telefon          varchar2(17),
    valorTotalvendes number,
    descompte        number(3) DEFAULT 10
        CONSTRAINT chk_discount CHECK (descompte BETWEEN 0 AND 100)
);

CREATE TABLE proveidor
(
    codiProveidor     int PRIMARY KEY,
    dni               varchar2(9),
    nomEmpresa        varchar2(64),
    direccio          varchar2(255),
    poblacio          varchar2(255),
    telefon           varchar2(17),
    contacte          varchar2(255),
    valorTotalCompres number
);

CREATE TABLE venedor
(
    codiVenedor int PRIMARY KEY,
    dni         varchar2(9),
    nom         varchar2(64),
    cognom1     varchar2(64),
    cognom2     varchar2(64),
    direccio    varchar2(255),
    poblacio    varchar2(255),
    telefon     varchar2(17),
    comissio    number,
    salari      number
);

CREATE TABLE producte
(
    codiProducte  int PRIMARY KEY,
    codiProveidor int NOT NULL,
    nom           varchar2(64),
    descripcio    varchar2(255),
    preu          number,
    stockActual   number,
    stockMinim    number
);

CREATE TABLE venda
(
    codiVenda        int PRIMARY KEY,
    codiClient       int NOT NULL,
    codiVenedor      int NOT NULL,
    dataVenda        date,
    descompteAplicat number(3)
);

CREATE TABLE vendaDetall
(
    codiVendaDetall int PRIMARY KEY,
    codiVenta       int NOT NULL,
    producte        int NOT NULL,
    quantitat       number
);

CREATE TABLE factura
(
    codiVenda        int PRIMARY KEY,
    codiClient       int NOT NULL,
    client_nom       varchar2(64),
    client_cognom1   varchar2(64),
    client_cognom2   varchar2(64),
    client_telefon   varchar2(17),
    codiVenedor      int NOT NULL,
    venedor_nom      varchar2(64),
    venedor_cognom1  varchar2(64),
    venedor_cognom2  varchar2(64),
    venedor_telefon  varchar2(17),
    dataVenda        date,
    descompteAplicat number(3),
    totalFactura     number,
    iva              number,
    CONSTRAINT chk_iva CHECK (iva BETWEEN 0 AND 100),
    preuFinal        number
);

CREATE TABLE comanda
(
    codiComanda int PRIMARY KEY,
    producte_codi int NOT NULL,
    quantitat NUMBER,
    dataComanda DATE
);

ALTER TABLE venda
    ADD CONSTRAINT FK_venda_codiClient
        FOREIGN KEY (codiClient) REFERENCES client (codiClient);

ALTER TABLE venda
    ADD CONSTRAINT FK_venda_codiVenedor
        FOREIGN KEY (codiVenedor) REFERENCES venedor (codiVenedor);

ALTER TABLE vendaDetall
    ADD CONSTRAINT FK_vendaDetall_codiVenta
        FOREIGN KEY (codiVenta) REFERENCES venda (codiVenda);

ALTER TABLE vendaDetall
    ADD CONSTRAINT FK_vendaDetall_producte
        FOREIGN KEY (producte) REFERENCES producte (codiProducte);

ALTER TABLE producte
    ADD CONSTRAINT FK_producte_codiProveidor
        FOREIGN KEY (codiProveidor) REFERENCES proveidor (codiProveidor);