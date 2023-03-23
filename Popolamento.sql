--Popolazione del database

--Popolazione della tabella RISTORANTE
INSERT INTO Ristorante
    VALUES('Pizzeria da Mario','Via Mario Rssi', '33', '80067', '92583720938', 'Mario Giordano');

INSERT INTO Ristorante
    VALUES('Ristorante le 4 terre','Via Saviano Superiore', '21', '80066', '25837209391', 'Luca Marcato');

INSERT INTO Ristorante
    VALUES('Ristorante AmoreEterno','Via Sulmona', '7', '80011', '29640281761', 'Maria Sala');

INSERT INTO Ristorante
    VALUES('La Fornacella','Vico Equenze', '149', '80033', '23904568127', 'Antonio Crimaldi');

INSERT INTO Ristorante
    VALUES('Pizzeria La Dalila','Via Carlo Salvo', '909', '60098', '10998208567', 'Marco Salvato');

--Popolazione della tabella SALA

INSERT INTO Sala
    VALUES(1, 'Piccola', 2, '92583720938');

INSERT INTO Sala
    VALUES(2, 'Media', 2, '92583720938');

INSERT INTO Sala
    VALUES(3, 'Grande', 3, '92583720938');

INSERT INTO Sala
    VALUES(4, 'Rosa', 3, '25837209391');

INSERT INTO Sala
    VALUES(5, 'Rossa', 3, '25837209391');

INSERT INTO Sala
    VALUES(6, 'Maria', 2, '29640281761');

INSERT INTO Sala
    VALUES(7, 'Sina', 2, '29640281761');

INSERT INTO Sala
    VALUES(8, 'Arte', 3, '23904568127');

INSERT INTO Sala
    VALUES(9, 'Musica', 3, '23904568127');

INSERT INTO Sala
    VALUES(10, 'Matematica', 3, '23904568127');

INSERT INTO Sala
    VALUES(11, 'Letteratura', 3, '23904568127');

INSERT INTO Sala
    VALUES(12, 'Savana', 3, '10998208567');

INSERT INTO Sala
    VALUES(13, 'Giungla', 3, '10998208567');

--Popolamento tabella TAVOLA

INSERT INTO tavola
    VALUES(1, 8, 1);

INSERT INTO tavola
    VALUES(2, 8, 1);

INSERT INTO tavola
    VALUES(3, 8, 2);

INSERT INTO tavola
    VALUES(4, 6, 2);

INSERT INTO tavola
    VALUES(5, 5, 3);

INSERT INTO tavola
    VALUES(6, 5, 3);

INSERT INTO tavola
    VALUES(7, 6, 3);

INSERT INTO tavola
    VALUES(8, 6, 4);

INSERT INTO tavola
    VALUES(9, 6, 4);

INSERT INTO tavola
    VALUES(10, 6, 4);

INSERT INTO tavola
    VALUES(11, 4, 5);

INSERT INTO tavola
    VALUES(12, 4, 5);

INSERT INTO tavola
    VALUES(13, 4, 5);

INSERT INTO tavola
    VALUES(14, 6, 6);

INSERT INTO tavola
    VALUES(15, 5, 6);

INSERT INTO tavola
    VALUES(16, 6, 7);

INSERT INTO tavola
    VALUES(17, 6, 7);
    
INSERT INTO tavola
    VALUES(18, 6, 8);

INSERT INTO tavola
    VALUES(19, 5, 8);

INSERT INTO tavola
    VALUES(20, 6, 8);

INSERT INTO tavola
    VALUES(21, 5, 9);

INSERT INTO tavola
    VALUES(22, 5, 9);

INSERT INTO tavola
    VALUES(23, 5, 9);

INSERT INTO tavola
    VALUES(24, 4, 10);

INSERT INTO tavola
    VALUES(25, 4, 10);

INSERT INTO tavola
    VALUES(26, 4, 10);

INSERT INTO tavola
    VALUES(27, 5, 11);

INSERT INTO tavola
    VALUES(28, 5, 11);

INSERT INTO tavola
    VALUES(29, 5, 11);

INSERT INTO tavola
    VALUES(30, 6, 12);

INSERT INTO tavola
    VALUES(31, 6, 12);

INSERT INTO tavola
    VALUES(32, 8, 12);

INSERT INTO tavola
    VALUES(33, 4, 13);

INSERT INTO tavola
    VALUES(34, 6, 13);

INSERT INTO tavola
    VALUES(35, 8, 13);

--Popolamento tabella VICINANZA

INSERT INTO vicinanza
    VALUES(1, 2);

INSERT INTO vicinanza
    VALUES(3, 4);

INSERT INTO vicinanza
    VALUES(5, 6);

INSERT INTO vicinanza
    VALUES(6, 7);

INSERT INTO vicinanza
    VALUES(7, 5);

INSERT INTO vicinanza
    VALUES(8, 9);

INSERT INTO vicinanza
    VALUES(9, 10);

INSERT INTO vicinanza
    VALUES(11, 12);

INSERT INTO vicinanza
    VALUES(12, 13);

INSERT INTO vicinanza
    VALUES(13, 11);

INSERT INTO vicinanza
    VALUES(14, 15);

INSERT INTO vicinanza
    VALUES(16, 17);

INSERT INTO vicinanza
    VALUES(18, 19);

INSERT INTO vicinanza
    VALUES(19, 20);

INSERT INTO vicinanza
    VALUES(21, 22);

INSERT INTO vicinanza
    VALUES(22, 23);

INSERT INTO vicinanza
    VALUES(23, 21);

INSERT INTO vicinanza
    VALUES(24, 25);

INSERT INTO vicinanza
    VALUES(25, 26);

INSERT INTO vicinanza
    VALUES(27, 28);

INSERT INTO vicinanza
    VALUES(28, 29);

INSERT INTO vicinanza
    VALUES(29, 27);

INSERT INTO vicinanza
    VALUES(30, 31);

INSERT INTO vicinanza
    VALUES(31, 32);

INSERT INTO vicinanza
    VALUES(33, 34);

INSERT INTO vicinanza
    VALUES(34, 35);

INSERT INTO vicinanza
    VALUES(35, 33);

--Popolamento tabella PERSONALE
INSERT INTO Personale VALUES(1, 'Cameriere');
INSERT INTO Personale VALUES(2, 'Cameriere');
INSERT INTO Personale VALUES(3, 'Barman');
INSERT INTO Personale VALUES(4, 'DirettoreDiSala');
INSERT INTO Personale VALUES(5, 'Barman');
INSERT INTO Personale VALUES(6, 'Cameriere');
INSERT INTO Personale VALUES(7, 'Cameriere');
INSERT INTO Personale VALUES(8, 'Cameriere');
INSERT INTO Personale VALUES(9, 'Barman');
INSERT INTO Personale VALUES(10, 'Cuoco');
INSERT INTO Personale VALUES(11, 'DirettoreDiSala');
INSERT INTO Personale VALUES(12, 'DirettoreDiSala');
INSERT INTO Personale VALUES(13, 'Barman');
INSERT INTO Personale VALUES(14, 'Cuoco');
INSERT INTO Personale VALUES(15, 'Barman');
INSERT INTO Personale VALUES(16, 'Cuoco');
INSERT INTO Personale VALUES(17, 'DirettoreDiSala');
INSERT INTO Personale VALUES(18, 'Cameriere');
INSERT INTO Personale VALUES(19, 'DirettoreDiSala');
INSERT INTO Personale VALUES(20, 'Cameriere');
INSERT INTO Personale VALUES(21, 'DirettoreDiSala');
INSERT INTO Personale VALUES(22, 'Barman');
INSERT INTO Personale VALUES(23, 'Barman');
INSERT INTO Personale VALUES(24, 'DirettoreDiSala');
INSERT INTO Personale VALUES(25, 'DirettoreDiSala');
INSERT INTO Personale VALUES(26, 'Cuoco');
INSERT INTO Personale VALUES(27, 'Cameriere');
INSERT INTO Personale VALUES(28, 'Cameriere');
INSERT INTO Personale VALUES(29, 'Barman');
INSERT INTO Personale VALUES(30, 'Barman');
INSERT INTO Personale VALUES(31, 'Cuoco');
INSERT INTO Personale VALUES(32, 'DirettoreDiSala');
INSERT INTO Personale VALUES(33, 'Barman');
INSERT INTO Personale VALUES(34, 'Cameriere');
INSERT INTO Personale VALUES(35, 'DirettoreDiSala');
INSERT INTO Personale VALUES(36, 'Cameriere');
INSERT INTO Personale VALUES(37, 'Cameriere');
INSERT INTO Personale VALUES(38, 'Barman');
INSERT INTO Personale VALUES(39, 'Barman');
INSERT INTO Personale VALUES(40, 'Cameriere');
INSERT INTO Personale VALUES(41, 'Cuoco');
INSERT INTO Personale VALUES(42, 'DirettoreDiSala');
INSERT INTO Personale VALUES(43, 'Barman');
INSERT INTO Personale VALUES(44, 'Cameriere');
INSERT INTO Personale VALUES(45, 'Cameriere');
INSERT INTO Personale VALUES(46, 'Cameriere');
INSERT INTO Personale VALUES(47, 'DirettoreDiSala');
INSERT INTO Personale VALUES(48, 'Cuoco');
INSERT INTO Personale VALUES(49, 'Barman');
INSERT INTO Personale VALUES(50, 'Barman');

--Popolamento tabella AVVENTORE
INSERT INTO Avventore VALUES('CA35621VX');
INSERT INTO Avventore VALUES('CA08621AL');
INSERT INTO Avventore VALUES('CA28751RV');
INSERT INTO Avventore VALUES('CA07295YF');
INSERT INTO Avventore VALUES('CA82096VS');
INSERT INTO Avventore VALUES('CA67039VZ');
INSERT INTO Avventore VALUES('CA38901EL');
INSERT INTO Avventore VALUES('CA37289DA');
INSERT INTO Avventore VALUES('CA64593GU');
INSERT INTO Avventore VALUES('CA54603YB');
INSERT INTO Avventore VALUES('CA95243QA');
INSERT INTO Avventore VALUES('CA27856WB');
INSERT INTO Avventore VALUES('CA62591EI');
INSERT INTO Avventore VALUES('CA58941WB');
INSERT INTO Avventore VALUES('CA23650BI');
INSERT INTO Avventore VALUES('CA25413KZ');
INSERT INTO Avventore VALUES('CA08613QC');
INSERT INTO Avventore VALUES('CA34729DS');
INSERT INTO Avventore VALUES('CA35908FS');
INSERT INTO Avventore VALUES('CA58967SL');
INSERT INTO Avventore VALUES('CA82546VR');
INSERT INTO Avventore VALUES('CA16258TW');
INSERT INTO Avventore VALUES('CA16485ME');
INSERT INTO Avventore VALUES('CA65217IZ');
INSERT INTO Avventore VALUES('CA76294TL');
INSERT INTO Avventore VALUES('CA81903QC');
INSERT INTO Avventore VALUES('CA31925ES');
INSERT INTO Avventore VALUES('CA68907GQ');
INSERT INTO Avventore VALUES('CA46029TL');
INSERT INTO Avventore VALUES('CA46539QK');
INSERT INTO Avventore VALUES('CA57320OW');
INSERT INTO Avventore VALUES('CA84075UE');
INSERT INTO Avventore VALUES('CA75468BZ');
INSERT INTO Avventore VALUES('CA34875YG');
INSERT INTO Avventore VALUES('CA82409YU');
INSERT INTO Avventore VALUES('CA31687RV');
INSERT INTO Avventore VALUES('CA94726BT');
INSERT INTO Avventore VALUES('CA78530JI');
INSERT INTO Avventore VALUES('CA50396MN');
INSERT INTO Avventore VALUES('CA26134JK');
INSERT INTO Avventore VALUES('CA83107AL');
INSERT INTO Avventore VALUES('CA72816MH');
INSERT INTO Avventore VALUES('CA41826XC');
INSERT INTO Avventore VALUES('CA67201DE');
INSERT INTO Avventore VALUES('CA59613SI');
INSERT INTO Avventore VALUES('CA25849QW');
INSERT INTO Avventore VALUES('CA05163KS');
INSERT INTO Avventore VALUES('CA30579IF');
INSERT INTO Avventore VALUES('CA41796FZ');

--Popolamento tabella Persona

INSERT INTO Persona VALUES ('Lola', 'Sims', '6520744414', '1', 'CA23796FX');
INSERT INTO Persona VALUES ('Emma', 'Green', '7656232037', '2', 'CA62381JF');
INSERT INTO Persona VALUES ('Lucy', 'Paz', '1558720463', '3', 'CA92067XO');
INSERT INTO Persona VALUES ('Jean', 'Howe', '8404430663', '4', 'CA91403EB');
INSERT INTO Persona VALUES ('Jacob', 'Kent', '2797152314', '5', 'CA40632YD');
INSERT INTO Persona VALUES ('Bernard', 'Ramos', '5820273414', '6', 'CA06473UJ');
INSERT INTO Persona VALUES ('Brian', 'Soto', '5203733803', '7', 'CA15638PM');
INSERT INTO Persona VALUES ('Tyrone', 'Creighton', '4551404801', '8', 'CA93026TL');
INSERT INTO Persona VALUES ('Mark', 'Toulouse', '9638137179', '9', 'CA03581BC');
INSERT INTO Persona VALUES ('Elsie', 'Cross', '9395480161', '10', 'CA84976EA');
INSERT INTO Persona VALUES ('Kelvin', 'Maselli', '5895477828', '11', 'CA91850AL');
INSERT INTO Persona VALUES ('Myrtle', 'Parker', '3577732366', '12', 'CA05827CG');
INSERT INTO Persona VALUES ('Thomas', 'Collins', '5692823689', '13', 'CA09867TS');
INSERT INTO Persona VALUES ('Virginia', 'Wilkerson', '3440815625', '14', 'CA20938AJ');
INSERT INTO Persona VALUES ('Thomas', 'Collins', '5636805189', '15', 'CA06519CT');
INSERT INTO Persona VALUES ('Vincent', 'Jolley', '9550380791', '16', 'CA59087JA');
INSERT INTO Persona VALUES ('Mario', 'Blanton', '3457644477', '17', 'CA19205DA');
INSERT INTO Persona VALUES ('Constance', 'Palmer', '7146035044', '18', 'CA02934HG');
INSERT INTO Persona VALUES ('April', 'Scavuzzo', '1518257368', '19', 'CA02384WM');
INSERT INTO Persona VALUES ('Benjamin', 'Roseman', '9380585804', '20', 'CA14863PW');
INSERT INTO Persona VALUES ('William', 'Darnstaedt', '3940463528', '21', 'CA72048RX');
INSERT INTO Persona VALUES ('Wm', 'Skidmore', '2111209787', '22', 'CA30547MH');
INSERT INTO Persona VALUES ('Rhonda', 'Miller', '7827002856', '23', 'CA51463TQ');
INSERT INTO Persona VALUES ('June', 'Hopkins', '2886718403', '24', 'CA37516VW');
INSERT INTO Persona VALUES ('Mary', 'Hunter', '3887573092', '25', 'CA86792HT');
INSERT INTO Persona VALUES ('Alfonso', 'Bradley', '3642251028', '26', 'CA50732WA');
INSERT INTO Persona VALUES ('James', 'Velazquez', '6072472377', '27', 'CA24038MI');
INSERT INTO Persona VALUES ('Phyllis', 'Reeves', '1806073859', '28', 'CA84905LT');
INSERT INTO Persona VALUES ('Regina', 'Laughary', '6020729480', '29', 'CA12306NV');
INSERT INTO Persona VALUES ('Jerry', 'Loureiro', '8092566417', '30', 'CA23578RT');
INSERT INTO Persona VALUES ('Alexandra', 'Baeza', '3584211412', '31', 'CA79382IW');
INSERT INTO Persona VALUES ('Chris', 'Stroot', '6944849406', '32', 'CA80734ZT');
INSERT INTO Persona VALUES ('Karen', 'Martin', '9934030329', '33', 'CA37428US');
INSERT INTO Persona VALUES ('David', 'Sims', '6256826163', '34', 'CA24038TL');
INSERT INTO Persona VALUES ('Jennifer', 'Kirk', '4353149210', '35', 'CA25938YC');
INSERT INTO Persona VALUES ('John', 'Stewart', '5214570094', '36', 'CA09423DI');
INSERT INTO Persona VALUES ('Denise', 'Wells', '4125609595', '37', 'CA86072BP');
INSERT INTO Persona VALUES ('James', 'Partridge', '5878466080', '38', 'CA93401RC');
INSERT INTO Persona VALUES ('Nicholas', 'Carson', '6494358432', '39', 'CA10478GK');
INSERT INTO Persona VALUES ('Elsa', 'Sylla', '7761301720', '40', 'CA94260IG');
INSERT INTO Persona VALUES ('James', 'Stevens', '9051152368', '41', 'CA95074MJ');
INSERT INTO Persona VALUES ('Nellie', 'Canfield', '2504441152', '42', 'CA97104HW');
INSERT INTO Persona VALUES ('Bonnie', 'Montgomery', '8188052270', '43', 'CA21609ZN');
INSERT INTO Persona VALUES ('Peter', 'Hemberger', '3335217141', '44', 'CA10896FU');
INSERT INTO Persona VALUES ('George', 'Pesce', '8650741622', '45', 'CA90627WH');
INSERT INTO Persona VALUES ('Ali', 'Adame', '6303416220', '46', 'CA70532FT');
INSERT INTO Persona VALUES ('Juan', 'Tinley', '5668257436', '47', 'CA46702HK');
INSERT INTO Persona VALUES ('Michael', 'Bloxom', '3827282625', '48', 'CA71983PS');
INSERT INTO Persona VALUES ('Virgil', 'Cowdery', '9534552268', '49', 'CA96705UM');
INSERT INTO Persona VALUES ('Patricia', 'Harrell', '8006650445', '50', 'CA94816XK');
INSERT INTO Persona VALUES ('Dawn', 'Geddes', '5232438961', 'NULL', 'CA35621VX');
INSERT INTO Persona VALUES ('William', 'Neff', '8752759657', 'NULL', 'CA08621AL');
INSERT INTO Persona VALUES ('Voncile', 'Granby', '9870675701', 'NULL', 'CA28751RV');
INSERT INTO Persona VALUES ('Ellen', 'Hendryx', '4898343179', 'NULL', 'CA07295YF');
INSERT INTO Persona VALUES ('Leland', 'Williams', '4426865283', 'NULL', 'CA82096VS');
INSERT INTO Persona VALUES ('Jack', 'Gentile', '3585018250', 'NULL', 'CA67039VZ');
INSERT INTO Persona VALUES ('Deborah', 'Shows', '4887770390', 'NULL', 'CA38901EL');
INSERT INTO Persona VALUES ('Joseph', 'Church', '3232718928', 'NULL', 'CA37289DA');
INSERT INTO Persona VALUES ('Jerry', 'Peiper', '7004865991', 'NULL', 'CA64593GU');
INSERT INTO Persona VALUES ('George', 'Bertolini', '5425123542', 'NULL', 'CA54603YB');
INSERT INTO Persona VALUES ('Patsy', 'Vlashi', '2155246775', 'NULL', 'CA95243QA');
INSERT INTO Persona VALUES ('Annette', 'Mckenzie', '7610660847', 'NULL', 'CA27856WB');
INSERT INTO Persona VALUES ('Andy', 'Carson', '3503085677', 'NULL', 'CA62591EI');
INSERT INTO Persona VALUES ('Jon', 'Campbell', '7183662750', 'NULL', 'CA58941WB');
INSERT INTO Persona VALUES ('Sarah', 'Axtell', '2725740518', 'NULL', 'CA23650BI');
INSERT INTO Persona VALUES ('April', 'Hunt', '3616119487', 'NULL', 'CA25413KZ');
INSERT INTO Persona VALUES ('Gary', 'Pippin', '5607311412', 'NULL', 'CA08613QC');
INSERT INTO Persona VALUES ('Gary', 'Alleyne', '5106685398', 'NULL', 'CA34729DS');
INSERT INTO Persona VALUES ('Evangelina', 'Seale', '6222821659', 'NULL', 'CA35908FS');
INSERT INTO Persona VALUES ('Laura', 'Graves', '6411557792', 'NULL', 'CA58967SL');
INSERT INTO Persona VALUES ('Sabrina', 'Warden', '2505387060', 'NULL', 'CA82546VR');
INSERT INTO Persona VALUES ('Audrey', 'Poole', '3397675909', 'NULL', 'CA16258TW');
INSERT INTO Persona VALUES ('Devona', 'Starr', '4225640505', 'NULL', 'CA16485ME');
INSERT INTO Persona VALUES ('William', 'Reardon', '9340377345', 'NULL', 'CA65217IZ');
INSERT INTO Persona VALUES ('Bruce', 'Brewer', '2945822685', 'NULL', 'CA76294TL');
INSERT INTO Persona VALUES ('Diane', 'Diaz', '9180431581', 'NULL', 'CA81903QC');
INSERT INTO Persona VALUES ('Robert', 'Reed', '7230184499', 'NULL', 'CA31925ES');
INSERT INTO Persona VALUES ('Charlotte', 'Blevins', '9864614347', 'NULL', 'CA68907GQ');
INSERT INTO Persona VALUES ('Marie', 'Ruiz', '1045734778', 'NULL', 'CA46029TL');
INSERT INTO Persona VALUES ('Ray', 'Mcgarry', '2164719345', 'NULL', 'CA46539QK');
INSERT INTO Persona VALUES ('Amanda', 'Carmody', '5345342128', 'NULL', 'CA57320OW');
INSERT INTO Persona VALUES ('Mattie', 'Cook', '7820128726', 'NULL', 'CA84075UE');
INSERT INTO Persona VALUES ('Amanda', 'Burgess', '4912217200', 'NULL', 'CA75468BZ');
INSERT INTO Persona VALUES ('Ruth', 'Holley', '1985704867', 'NULL', 'CA34875YG');
INSERT INTO Persona VALUES ('Jean', 'Pierre', '3296542911', 'NULL', 'CA82409YU');
INSERT INTO Persona VALUES ('Robert', 'Pixler', '1191709076', 'NULL', 'CA31687RV');
INSERT INTO Persona VALUES ('Christopher', 'Moses', '5624542065', 'NULL', 'CA94726BT');
INSERT INTO Persona VALUES ('Michael', 'Godines', '6414420419', 'NULL', 'CA78530JI');
INSERT INTO Persona VALUES ('Eric', 'Murray', '3463177098', 'NULL', 'CA50396MN');
INSERT INTO Persona VALUES ('Ricky', 'Net', '6598000611', 'NULL', 'CA26134JK');
INSERT INTO Persona VALUES ('Jimmie', 'Burns', '5571153084', 'NULL', 'CA83107AL');
INSERT INTO Persona VALUES ('Ashley', 'Nobles', '6392726413', 'NULL', 'CA72816MH');
INSERT INTO Persona VALUES ('Lawrence', 'Gilligan', '3130430607', 'NULL', 'CA41826XC');
INSERT INTO Persona VALUES ('Mary', 'Herrera', '9997383230', 'NULL', 'CA67201DE');
INSERT INTO Persona VALUES ('Beverly', 'Cooper', '7156519164', 'NULL', 'CA59613SI');
INSERT INTO Persona VALUES ('Richard', 'Long', '8763852686', 'NULL', 'CA25849QW');
INSERT INTO Persona VALUES ('Janice', 'Lucas', '9677314549', 'NULL', 'CA05163KS');
INSERT INTO Persona VALUES ('Barbara', 'Anderson', '8261623788', 'NULL', 'CA30579IF');
INSERT INTO Persona VALUES ('Wendy', 'Stapleton', '8655803068', 'NULL', 'CA41796FZ');
INSERT INTO Persona VALUES ('Althea', 'Fetter', '8535726924', 'NULL', 'CA59263SG');

--Popolamento tabella TAVOLATA

INSERT INTO  tavolata VALUES (1, '2021-07-01', '20:00:00', 2);
INSERT INTO  tavolata VALUES (2, '2021-07-02', '21:00:00', 5);
INSERT INTO  tavolata VALUES (3, '2021-07-02', '21:00:00', 6);
INSERT INTO  tavolata VALUES (4, '2021-07-03', '21:00:00', 12);
INSERT INTO  tavolata VALUES (5, '2021-07-03', '21:00:00', 13);
INSERT INTO  tavolata VALUES (6, '2021-07-03', '21:00:00', 14);

--Popolamento tabella PARTECIPA

INSERT INTO partecipa VALUES (1, 'CA35621VX');
INSERT INTO partecipa VALUES (1, 'CA08621AL');
INSERT INTO partecipa VALUES (1, 'CA28751RV');
INSERT INTO partecipa VALUES (1, 'CA07295YF');
INSERT INTO partecipa VALUES (1, 'CA82096VS');
INSERT INTO partecipa VALUES (2, 'CA67039VZ');
INSERT INTO partecipa VALUES (2, 'CA38901EL');
INSERT INTO partecipa VALUES (2, 'CA37289DA');
INSERT INTO partecipa VALUES (3, 'CA64593GU');
INSERT INTO partecipa VALUES (3, 'CA54603YB');
INSERT INTO partecipa VALUES (4, 'CA95243QA');
INSERT INTO partecipa VALUES (4, 'CA27856WB');
INSERT INTO partecipa VALUES (5, 'CA62591EI');
INSERT INTO partecipa VALUES (5, 'CA58941WB');
INSERT INTO partecipa VALUES (5, 'CA23650BI');
INSERT INTO partecipa VALUES (5, 'CA25413KZ');
INSERT INTO partecipa VALUES (6, 'CA08613QC');
INSERT INTO partecipa VALUES (6, 'CA34729DS');
INSERT INTO partecipa VALUES (6, 'CA35908FS');
INSERT INTO partecipa VALUES (6, 'CA58967SL');

--Popolamento tabella SERVITO

INSERT INTO servito VALUES (4, 2);
INSERT INTO servito VALUES (6, 2);
INSERT INTO servito VALUES (5, 2);
INSERT INTO servito VALUES (7, 3);
INSERT INTO servito VALUES (9, 3);
INSERT INTO servito VALUES (8, 4);
INSERT INTO servito VALUES (14, 4);
INSERT INTO servito VALUES (18, 5);
INSERT INTO servito VALUES (12, 6);
INSERT INTO servito VALUES (20, 6);
INSERT INTO servito VALUES (26, 6);

--Popolamento tabella SEGNALAZIONE

INSERT INTO segnalazione VALUES(1, '2021-07-04', 1, 'CA35621VX');
INSERT INTO segnalazione VALUES(2, '2021-07-05', 3, 'CA54603YB');
INSERT INTO segnalazione VALUES(3, '2021-07-06', 5, 'CA58941WB');
