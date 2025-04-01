INSERT INTO client VALUES (1, '12345678A', 'Joan', 'Garcia', 'Martí', 'Carrer Major 12', 'Barcelona', '612345678', 1500, 10);
INSERT INTO client VALUES (2, '23456789B', 'Maria', 'López', 'Fernández', 'Avinguda Diagonal 34', 'Girona', '623456789', 3000, 15);
INSERT INTO client VALUES (3, '34567890C', 'Pere', 'Sánchez', 'Ruiz', 'Passeig de Gràcia 56', 'Tarragona', '634567890', 500, 5);
INSERT INTO client VALUES (4, '45678901D', 'Anna', 'Ferrer', 'Gómez', 'Carrer de València 78', 'Lleida', '645678901', 4200, 20);
INSERT INTO client VALUES (5, '56789012E', 'Marc', 'Torres', 'Soler', 'Rambla Nova 90', 'Barcelona', '656789012', 2500, 12);

INSERT INTO proveidor VALUES (1, '87654321Z', 'Electrocat S.L.', 'Carrer Indústria 5', 'Barcelona', '667890123', 'Jordi Pujol', 12000);
INSERT INTO proveidor VALUES (2, '76543210Y', 'Papereria Girona', 'Plaça Catalunya 15', 'Girona', '678901234', 'Montse Rovira', 8000);
INSERT INTO proveidor VALUES (3, '65432109X', 'Moble House', 'Carrer del Comerç 32', 'Tarragona', '689012345', 'Pau Vila', 15000);
INSERT INTO proveidor VALUES (5, '43210987V', 'Textil BCN', 'Gran Via 120', 'Barcelona', '601234567', 'Albert Grau', 11000);
INSERT INTO proveidor VALUES (4, '54321098W', 'Informàtica Lleida', 'Av. Prat de la Riba 22', 'Lleida', '690123456', 'Carla Esteve', 9500);

INSERT INTO venedor VALUES (1, '11111111H', 'Sergi', 'Pérez', 'Navarro', 'Carrer Aragó 45', 'Barcelona', '611111111', 5.5, 1800);
INSERT INTO venedor VALUES (2, '22222222J', 'Laura', 'Martínez', 'Soler', 'Carrer Gran 67', 'Girona', '622222222', 6.0, 1950);
INSERT INTO venedor VALUES (3, '33333333K', 'David', 'Ribas', 'Ferrer', 'Passeig Marítim 10', 'Tarragona', '633333333', 4.5, 1750);
INSERT INTO venedor VALUES (4, '44444444L', 'Núria', 'Casas', 'Ortega', 'Av. Roma 88', 'Lleida', '644444444', 7.0, 2100);
INSERT INTO venedor VALUES (5, '55555555M', 'Oriol', 'Serra', 'Vidal', 'Carrer Verdi 21', 'Barcelona', '655555555', 5.0, 1900);

INSERT INTO producte VALUES (1, 1, 'Jack Daniel’s Old No. 7', 'Tennessee whiskey suau amb notes de vainilla i roure.', 25.99, 50, 5);
INSERT INTO producte VALUES (2, 2, 'Jameson Irish Whiskey', 'Whiskey irlandès triple destil·lat, suau i equilibrat.', 22.50, 40, 5);
INSERT INTO producte VALUES (3, 3, 'Chivas Regal 12', 'Blended Scotch amb notes de mel, poma i nou.', 32.75, 30, 5);
INSERT INTO producte VALUES (4, 4, 'Macallan 12 Sherry Oak', 'Single malt envellit en bótes de xerès, amb notes de fruita seca i espècies.', 65.00, 20, 3);
INSERT INTO producte VALUES (5, 5, 'Johnnie Walker Blue Label', 'Scotch premium amb un perfil fumat i sofisticat.', 180.00, 10, 2);

call NOVA_VENDA(1,1,1);
call NOVA_VENDA(2, 2, 2);
call NOVA_VENDA(3, 2, 2);

call LINEA_VENDA(1, 1, 3, 4);
call LINEA_VENDA(2, 1, 2, 2);
call LINEA_VENDA(3, 2, 1, 1);
call LINEA_VENDA(4, 2, 5, 3);
call LINEA_VENDA(5, 3, 3, 2);
call LINEA_VENDA(6, 3, 4, 1);

