--Creazione del database
CREATE DATABASE TracciamentoCovidRistoranti;

--Creazione delle enumerazioni

--Enumerazione per lo stato del persona che efettua la segnalazione
CREATE DOMAIN stato AS character varying(8)
    CHECK(
        VALUE = 'Positivo'
        OR VALUE = 'Negativo'
);

--Enumerazione per la tipologia di mansioni
CREATE DOMAIN mansione AS character varying(16)
    CHECK(
        VALUE = 'Barman'
        OR VALUE = 'Cameriere'
        OR VALUE = 'Cuoco'
        OR VALUE = 'DirettoreDiSala'
);

--Creazione delle tabelle

--Creazione tabella RISTORANTE
CREATE TABLE ristorante(
    nome character varying(255) NOT NULL,
    via character varying(255) NOT NULL,
    civico character varying(5) NOT NULL,
    cap character varying(5) NOT NULL,
    p_iva character varying(11) NOT NULL UNIQUE,
    nomeProprietario character varying(255) NOT NULL
);

--Creazione tabella SALA
CREATE TABLE sala(
    codiceSala character varying(12) NOT NULL UNIQUE,
    nomeSala character varying(255) NOT NULL,
    numeroTavoli integer NOT NULL,
    p_iva character varying(11) NOT NULL UNIQUE
);

--Creazione tabella TAVOLA
CREATE TABLE tavola(
    numeroTavola character varying(12) NOT NULL UNIQUE,
    numeroPersoneMax integer NOT NULL,
    codiceSala character varying(12) NOT NULL UNIQUE
);

--Creazione tabella VICINANZA
CREATE TABLE vicinanza(
    ntc character varying(12) NOT NULL UNIQUE,
    nts character varying(12) NOT NULL UNIQUE
);

--Creazione tabella TAVOLATA
CREATE TABLE tavolata(
    idTavolata character varying(12) NOT NULL UNIQUE,
    dataArrivo date NOT NULL,
    orarioArrivo time NOT NULL,
    numeroTavolata character varying(12) NOT NULL UNIQUE
);

--Creazione tabella SEGNALAZIONE
CREATE TABLE segnalazione(
    idSegnalazione character varying(64) NOT NULL UNIQUE,
    statoCovid stato NOT NULL,
    dataSegnalazione date NOT NULL,
    tavolata character varying(12) NOT NULL UNIQUE
);

--Creazione tabella PERSONA
CREATE TABLE persona(
    nome character varying(64) NOT NULL,
    cognome character varying(64) NOT NULL,
    telefono character varying(10) NOT NULL UNIQUE,
    numeroOpt character varying(12) NOT NULL UNIQUE,
    numeroCartaIdentita character varying(8) NOT NULL UNIQUE
);

--Creazione tabella PERSONALE
CREATE TABLE personale(
    numeroOpt character varying(12) NOT NULL UNIQUE,
    mansione mansione NOT NULL
);

--Creazione tabella SERVITO
CREATE TABLE servito(
    numeroOpt character varying(12) NOT NULL UNIQUE,
    idTavolata character varying(12) NOT NULL UNIQUE
);

--Creazione tabella AVVENTORE
CREATE TABLE avventore(
    numeroCartaIdentita character varying(8)
);

--Creazione tabella PARTECIPA
CREATE TABLE partecipa(
    idTavolata character varying(12) NOT NULL UNIQUE,
    numeroCartaIdentita character varying(8) NOT NULL UNIQUE
);

--Creazione delle chiavi primarie e chiavi esterne

--Chiave primaria per la tabelle RISTORANTE
ALTER TABLE ristorante
    ADD CONSTRAINT PK_ristorante
        PRIMARY KEY(p_iva);

--Chiavi primarie e chiave esterna per la tabella SALA
ALTER TABLE sala
    ADD CONSTRAINT PK_sala
        PRIMARY KEY(codiceSala),
    ADD CONSTRAINT FK_sala
        FOREIGN KEY(p_iva)
            REFERENCES ristorante(p_iva);

--Chiavi primarie e esterne per la tabella TAVOLA
ALTER TABLE tavola
    ADD CONSTRAINT PK_tavola
        PRIMARY KEY(numeroTavola),
    ADD CONSTRAINT FK_tavola
        FOREIGN KEY(codiceSala)
            REFERENCES sala(codiceSala);

--Chiavi esterne per la tabella VICINANZA
ALTER TABLE vicinanza
    ADD CONSTRAINT FK_vicinanza1
        FOREIGN KEY(ntc)
            REFERENCES tavola(numeroTavola),
    ADD CONSTRAINT FK_vicinanza2
        FOREIGN KEY(nts)
            REFERENCES tavola(numeroTavola);

--Chiavi primarie e esterne per la tabella TAVOLATA
ALTER TABLE tavolata
    ADD CONSTRAINT PK_tavolata
        PRIMARY KEY(idTavolata),
    ADD CONSTRAINT FK_tavolata
        FOREIGN KEY(numeroTavolata)
            REFERENCES tavola(numeroTavola);

--Chiavi primarie e esterne per la tabella SEGNALAZIONE
ALTER TABLE segnalazione
    ADD CONSTRAINT PK_segnalazione
        PRIMARY KEY(idSegnalazione),
    ADD CONSTRAINT FK_segnalazione
        FOREIGN KEY(tavolata)
            REFERENCES tavolata(idTavolata);

--Chiavi primarie per la tabella PERSONALE
ALTER TABLE personale
    ADD CONSTRAINT PK_personale
        PRIMARY KEY(numeroOpt);

--Chiavi primarie per la tabella AVVENTORE
ALTER TABLE avventore
    ADD CONSTRAINT PK_avventore
        PRIMARY KEY(numeroCartaIdentita);

--Chiavi esterne per la tabella PERSONA
ALTER TABLE persona
    ADD CONSTRAINT FK_persona1
        FOREIGN KEY(numeroOpt)
            REFERENCES personale(numeroOpt),
    ADD CONSTRAINT FK_persona2
        FOREIGN KEY(numeroCartaIdentita)
            REFERENCES avventore(numeroCartaIdentita);

--Chiavi esterne per la tabella SERVITO
ALTER TABLE servito
    ADD CONSTRAINT FK_servito1
        FOREIGN KEY(numeroOpt)
            REFERENCES personale(numeroOpt),
    ADD CONSTRAINT FK_servito2
        FOREIGN KEY(idTavolata)
            REFERENCES tavolata(idTavolata);

--Chiavi esterne per la tabella PARTECIPA
ALTER TABLE partecipa
    ADD CONSTRAINT FK_partecipa1
        FOREIGN KEY(idTavolata)
            REFERENCES tavolata(idTavolata),
    ADD CONSTRAINT FK_partecipa2
        FOREIGN KEY(numeroCartaIdentita)
            REFERENCES avventore(numeroCartaIdentita);

--Creazione dei principali check

--Creazione dei trigger

--Popolazione del database
/*
--Popolazione della tabella RISTORANTE
INSERT INTO ristorante
VALUES('Pizzeria da Mario','Via Mario Rssi', '33', '80067', '925837209382', 'Mario Giordano');
INSERT INTO ristorante
VALUES('Ristorante le 4 terre','Via Saviano Superiore', '21', '80066', '925837209391', 'Luca Marcato');
INSERT INTO ristorante
VALUES('Ristorante La Viola','Via Carlo II', '11', '80033', '296402817640', 'Antonio Esposito');
INSERT INTO ristorante
VALUES('Ristorante AmoreEterno','Via Sulmona', '7', '80011', '296402817611', 'Maria Sala');
INSERT INTO ristorante
VALUES('Pizzeria La Scura','Via Enrico Fermi', '203', '00012', '902754019286', 'Martina Sultano');
INSERT INTO ristorante
VALUES('Ristorante La Viola','Via Carlo II', '11', '80033', '296402817640', 'Antonio Esposito');
INSERT INTO ristorante
VALUES('Ristorante Da Carola','Via Don Giovanni', '10', '80001', '091287528016', 'Maria De Falco');
INSERT INTO ristorante
VALUES('Pizzeria La Dalila','Via Carlo Salvo', '909', '60098', '109982085671', 'Marco Salvato');
*/