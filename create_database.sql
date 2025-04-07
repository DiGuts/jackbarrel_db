CREATE TABLE client
(
    codiclient       int PRIMARY KEY,
    dni              varchar2(9),
    nom              varchar2(64),
    cognom1          varchar2(64),
    cognom2          varchar2(64),
    direccio         varchar2(255),
    poblacio         varchar2(255),
    telefon          varchar2(17),
    valortotalvendes number,
    descompte        number(3) DEFAULT 10
        CONSTRAINT chk_discount CHECK (descompte BETWEEN 0 AND 100)
);

CREATE TABLE proveidor
(
    codiproveidor     int PRIMARY KEY,
    dni               varchar2(9),
    nomempresa        varchar2(64),
    direccio          varchar2(255),
    poblacio          varchar2(255),
    telefon           varchar2(17),
    contacte          varchar2(255),
    valortotalcompres number
);

CREATE TABLE venedor
(
    codivenedor int PRIMARY KEY,
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
    codiproducte  int PRIMARY KEY,
    codiproveidor int NOT NULL,
    nom           varchar2(64),
    descripcio    varchar2(255),
    preu          number,
    stockactual   number,
    stockminim    number
);

CREATE TABLE venda
(
    codivenda        int PRIMARY KEY,
    codiclient       int NOT NULL,
    codivenedor      int NOT NULL,
    datavenda        date,
    descompteaplicat number(3)
);

CREATE TABLE vendadetall
(
    codivendadetall int PRIMARY KEY,
    codiventa       int NOT NULL,
    producte        int NOT NULL,
    quantitat       number
);

CREATE TABLE factura
(
    codivenda        int PRIMARY KEY,
    codiclient       int NOT NULL,
    client_nom       varchar2(64),
    client_cognom1   varchar2(64),
    client_cognom2   varchar2(64),
    client_telefon   varchar2(17),
    codivenedor      int NOT NULL,
    venedor_nom      varchar2(64),
    venedor_cognom1  varchar2(64),
    venedor_cognom2  varchar2(64),
    venedor_telefon  varchar2(17),
    datavenda        date,
    descompteaplicat number(3),
    totalfactura     number,
    iva              number,
    CONSTRAINT chk_iva CHECK (iva BETWEEN 0 AND 100),
    preufinal        number
);

CREATE TABLE comanda
(
    codicomanda   int PRIMARY KEY,
    producte_codi int NOT NULL,
    quantitat     NUMBER,
    datacomanda   DATE,
    realitzada    NUMBER(1),
    CONSTRAINT chk_realitzada_boolean CHECK (realitzada BETWEEN 0 AND 1)
);

ALTER TABLE venda
    ADD CONSTRAINT fk_venda_codiclient
        FOREIGN KEY (codiclient) REFERENCES client (codiclient);

ALTER TABLE venda
    ADD CONSTRAINT fk_venda_codivenedor
        FOREIGN KEY (codivenedor) REFERENCES venedor (codivenedor);

ALTER TABLE vendadetall
    ADD CONSTRAINT fk_vendadetall_codiventa
        FOREIGN KEY (codiventa) REFERENCES venda (codivenda);

ALTER TABLE vendadetall
    ADD CONSTRAINT fk_vendadetall_producte
        FOREIGN KEY (producte) REFERENCES producte (codiproducte);

ALTER TABLE producte
    ADD CONSTRAINT fk_producte_codiproveidor
        FOREIGN KEY (codiproveidor) REFERENCES proveidor (codiproveidor);