--Creazione del database
-- CREATE DATABASE TracciamentoCovidRistoranti;

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
--Nome del ristorante tipo Stringa Not Null
    nome character varying(255) NOT NULL,
--Nome della via del ristorante tipo Stringa Not Null
    via character varying(255) NOT NULL,
--Numero di civico del ristorante tipo Stringa Not Null
    civico character varying(5) NOT NULL,
--Codice di avviamento postale della città del ristorante tipo Stringa Not Null
    cap character varying(5) NOT NULL,
--Numero di partita iva del ristorante tipo Stringa Not Null Unique
    p_iva character varying(11) NOT NULL,
--Nome del proprietario o dei prorpietari tipo Stringa Not Null
    nomeProprietario character varying(255) NOT NULL,
--Creazione della chiave primaria di ristorante ovvero p_iva(numero di partita iva)
    CONSTRAINT PK_ristorante
        PRIMARY KEY(p_iva),
--Check per controllare che la via contenga solo lettere
    CONSTRAINT CHK_viaRistorante
        CHECK (via ~ '^[A-Za-z ]*$'),
--Check per controllare che il civico contenga solo numeri
    CONSTRAINT CHK_civicoRistorante
        CHECK (civico ~ '^[0-9]*$'),
--Check per controllare che il cap contenga solo numeri
    CONSTRAINT CHK_capRistorante
        CHECK (cap ~ '^[0-9]*$'),
--Check per controllare che la p_iva contenga solo numeri
    CONSTRAINT CHK_p_ivaRistorante
        CHECK (p_iva ~ '^[0-9]*$'),
--Check per controllare che il nomeProprietario contenga solo lettere
    CONSTRAINT CHK_nomeProprietarioRistorante
        CHECK (nomeProprietario ~ '^[A-Za-z ]*$')
);

--Creazione tabella SALA
CREATE TABLE sala(
--Codice univoco che identifica una sala tipo Stringa Not Null Unique
    codiceSala integer NOT NULL IDENTITY(1,1),
--Nome della sala tipo Stringa Not Null
    nomeSala character varying(255) NOT NULL,
--Numero di tavoli presenti nella sala tipo Integer Not Null
    numeroTavoli integer NOT NULL,
--Numero di partita iva del ristorante tipo Striga Not Null
    p_iva character varying(11) NOT NULL,
--Creazione della chiva primaria di sala ovvero codiceSala(codice della sala)
    CONSTRAINT PK_sala
        PRIMARY KEY(codiceSala),
--Creazione della chiave esterna di sala ovvero p_iva(numero di partita iva) che fa riferimento a ristorante.p_iva(numero partita iva)
    CONSTRAINT FK_sala
        FOREIGN KEY(p_iva)
            REFERENCES ristorante(p_iva)
                ON UPDATE CASCADE
                ON DELETE CASCADE,
--Check per controllare che il nomeSala contenga solo lettere
    CONSTRAINT CHK_nomeSalaSala
        CHECK (nomeSala ~ '^[A-Za-z ]*$'),
--Check per controllare che la p_iva contenga solo numeri
    CONSTRAINT CHK_p_ivaSala
        CHECK (p_iva ~ '^[0-9]*$')
);

--Creazione tabella TAVOLA
CREATE TABLE tavola(
--Numero che distingue univocamente un tavolo tipo Stringa Not Null Unique
    numeroTavola integer NOT NULL IDENTITY(1,1),
--Numero massimo di persone che possono stare a quel tavolo tipo Integer Not Null
    numeroPersoneMax integer NOT NULL,
--Codice della sala dove si trova il tavolo tipo Stringa Not Null
    codiceSala integer NOT NULL,
--Creazione della chiave primaria per la tabella tavola ovvero numeroTavola
    CONSTRAINT PK_tavola
        PRIMARY KEY(numeroTavola),
--Creazione della chiave esterna di tavola ovvero codiceSala che fa riferimento a sala.codiceSala
    CONSTRAINT FK_tavola
        FOREIGN KEY(codiceSala)
            REFERENCES sala(codiceSala)
                ON UPDATE CASCADE
                ON DELETE CASCADE
);

--Creazione tabella VICINANZA
CREATE TABLE vicinanza(
--Numero della tavola corrente tipo Not Null
    ntc integer NOT NULL,
--Numero della tavola succesiva tipo Stringa Not Null
    nts integer NOT NULL,
--Creazione della chiave esterna per la tabella vicinanza ovvero ntc che fa riferimento a tavola.numeroTavola
    CONSTRAINT FK_vicinanza1
        FOREIGN KEY(ntc)
            REFERENCES tavola(numeroTavola)
                ON UPDATE CASCADE
                ON DELETE CASCADE,
--Creazione della chiave esterna per la tabella vicinanza ovvero nts che fa riferimento a tavola.numeroTavola
    CONSTRAINT FK_vicinanza2
        FOREIGN KEY(nts)
            REFERENCES tavola(numeroTavola)
                ON UPDATE CASCADE
                ON DELETE CASCADE
);

--Creazione tabella TAVOLATA
CREATE TABLE tavolata(
--Numero che identifica unicovamente una tavolata tipo Stringa Not Null Unique
    idTavolata integer NOT NULL IDENTITY(1,1),
--Data di arrivo della tavolata tipo Date Not Null
    dataArrivo date NOT NULL,
--Oriario di arrivo della tavolta tipo Time Not Null
    orarioArrivo time NOT NULL,
--Numero che idetifica univocamente la tavola assengata tipo Stringa Not Null
    numeroTavolata integer NOT NULL,
--Chiave primaria per la tabella tavolata ovvero idTavolata
    CONSTRAINT PK_tavolata
        PRIMARY KEY(idTavolata),
--Chiave estenra per la tabella tavolata ovvero numeroTavolata che fa riferimento a tavola.numeroTavola
    CONSTRAINT FK_tavolata
        FOREIGN KEY(numeroTavolata)
            REFERENCES tavola(numeroTavola)
                ON UPDATE CASCADE
                ON DELETE CASCADE
);

--Creazione tabella AVVENTORE
CREATE TABLE avventore(
--Numero della carta di indentià dell'avventore tipo Stringa Not Null Unique
    numeroCartaIdentita character varying(8) NOT NULL,
--Creazione della chiave primaria per la tabella avventore ovvero numeroCartaIdentita
    CONSTRAINT PK_avventore
        PRIMARY KEY(numeroCartaIdentita),
--Check per controllare che il numeriCartaIdentita sia conforme alla carta di indetita nuova
    CONSTRAINT CHK_numeroCartaIdentitaAvventore
CHECK (numeroCartaIdentita ~ '^[A-Za-z]{2}[0-9]{4}[A-Za-z]{2}.*$')
);

--Creazione tabella SEGNALAZIONE
CREATE TABLE segnalazione(
--Numero che identifica unicovamente la sengalazione tipo Stringa Not Null Unique
    idSegnalazione integer NOT NULL IDENTITY(1,1),
--Stato della persona che ha inviato la sengalazione tipo Stato Not Null
    statoCovid stato NOT NULL,
--Data della segnalazione tipo Date Not Null
    dataSegnalazione date NOT NULL,
--Tavolata a cui ha partecipato la sengalazione tipo Stringa Not Null
    tavolata integer NOT NULL,
--Persona che ha fatto la segnalazione
    numeroPersona character varying(8) NOT NULL,
--Creazione della chiave primaria per la tabella segnalazione ovvero idSegnalazione
    CONSTRAINT PK_segnalazione
        PRIMARY KEY(idSegnalazione),
--Creazione della chiave esterna per la tabella sengalazione ovvero tavolata che fa riferimento a tavolata.idTavolata
    CONSTRAINT FK_segnalazione
        FOREIGN KEY(tavolata)
            REFERENCES tavolata(idTavolata)
                ON UPDATE CASCADE
                ON DELETE CASCADE,
--Creazione della seconda chiave esterna per la tabella sengalazione ovvero numeroPersona che fa riferimento a avventore.numeroCartaIdentita
     CONSTRAINT FK_segnalazione2
        FOREIGN KEY(numeroPersona)
            REFERENCES avventore(numeroCartaIdentita)
                ON UPDATE CASCADE
                ON DELETE CASCADE
);

--Creazione tabella PERSONALE
CREATE TABLE personale(
--Numero che idetifica univocamente ogni membro del peronale tipo Stringa Not Null
    numeroOpt integer NOT NULL IDENTITY(1,1),
--Mansione assegnata a ogni membro del personale tipo mansione Not Null
    mansione mansione NOT NULL,
--Creazione della chiave primaria per la tabella personle ovvero numeroOtp
    CONSTRAINT PK_personale
        PRIMARY KEY(numeroOpt)
);

--Creazione tabella PERSONA
CREATE TABLE persona(
--Nome della persona tipo Stringa Not Null
    nome character varying(64) NOT NULL,
--Cognome della persona tipo Stringa Not Null
    cognome character varying(64) NOT NULL,
--Numero di telefono della persona tipo Stringa Not Null Unique
    telefono character varying(10) NOT NULL UNIQUE,
--Numero che identifica univocamente un mebro del personale tipo Stringa Not Null Unique
    numeroOpt integer NOT NULL UNIQUE,
--Numero di carta di identità che identifica univocamente una persona tipo Stringa Not Null Unique
    numeroCartaIdentita character varying(8) NOT NULL UNIQUE,
--Creazione della chiave esterna per la tabella persona ovvero numeroOtp che fa riferimento a personale.numeroOtp
    CONSTRAINT FK_persona1
        FOREIGN KEY(numeroOpt)
            REFERENCES personale(numeroOpt)
                ON UPDATE CASCADE
                ON DELETE CASCADE,
--Creazione della chiave esterna per la tabella persona ovvero numeroCartaIdentita che fa riferimento a avventore.numeroCartaIdentita
    CONSTRAINT FK_persona2
        FOREIGN KEY(numeroCartaIdentita)
            REFERENCES avventore(numeroCartaIdentita)
                ON UPDATE CASCADE
                ON DELETE CASCADE,
--Check per controllare che il nome contenga solo lettere
    CONSTRAINT CHK_nomePersona
        CHECK (nome ~ '^[A-Za-z]*$'),
--Check per controllare che il cognome contenga solo lettere
    CONSTRAINT CHK_cognomePersona
        CHECK (cognome ~ '^[A-Za-z]*$'),
--Check per controllare che telefono contenga solo numeri
    CONSTRAINT CHK_telefonoPersona
        CHECK (telefono ~ '^[0-9]*$'),
--Check per controllare la validita della carta di identita conforme alla nuova
    CONSTRAINT CHK_numeroCartaIdentitaPersona
        CHECK (numeroCartaIdentita ~ '^[A-Za-z]{2}[0-9]{4}[A-Za-z]{2}.*$')
);

--Creazione tabella SERVITO
CREATE TABLE servito(
--Numero che identifica univocamente un membro del personale tipo Stringa Not Null
    numeroOpt integer NOT NULL,
--Numero che identifica univocamente una tavolata tipo Stringa Not Null
    idTavolata integer NOT NULL,
--Creazione della chiave esterna per la tabella servito ovvero numeroOtp che fa riferimento a personale.numeroOtp
    CONSTRAINT FK_servito1
        FOREIGN KEY(numeroOpt)
            REFERENCES personale(numeroOpt)
                ON UPDATE CASCADE
                ON DELETE CASCADE,
--Creazione della chiave esterna per la tabella servito ovvero idTavolata che fa riferimento a tavolata.idTavolata
    CONSTRAINT FK_servito2
        FOREIGN KEY(idTavolata)
            REFERENCES tavolata(idTavolata)
                ON UPDATE CASCADE
                ON DELETE CASCADE
);

--Creazione tabella PARTECIPA
CREATE TABLE partecipa(
--Numero che identifica univocamente una tavolata tipo Strinfa Not Null
    idTavolata integer NOT NULL,
--Numero carta di identità che identifica univocamente una persona tipo Stringa Not Null
    numeroCartaIdentita character varying(8) NOT NULL,
--Creazione della chiave esterna per la tabella partecipa ovvero idTavolata che fa riferimento a tavolata.idTavolata
    CONSTRAINT FK_partecipa1
        FOREIGN KEY(idTavolata)
            REFERENCES tavolata(idTavolata)
                ON UPDATE CASCADE
                ON DELETE CASCADE,
--Creazione della chiave esterna per la tabella partecipa ovvero numeroCartaIdentita che fa riferimento a avventore.numeroCartaIdentita
    CONSTRAINT FK_partecipa2
        FOREIGN KEY(numeroCartaIdentita)
            REFERENCES avventore(numeroCartaIdentita)
                ON UPDATE CASCADE
                ON DELETE CASCADE
);

--Popolazione del database

--Popolazione della tabella RISTORANTE
INSERT INTO ristorante
    VALUES('Pizzeria da Mario','Via Mario Rssi', '33', '80067', '92583720938', 'Mario Giordano');

INSERT INTO ristorante
    VALUES('Ristorante le 4 terre','Via Saviano Superiore', '21', '80066', '25837209391', 'Luca Marcato');

INSERT INTO ristorante
    VALUES('Ristorante La Viola','Via Carlo II', '11', '80033', '96402817640', 'Antonio Esposito');

INSERT INTO ristorante
    VALUES('Ristorante AmoreEterno','Via Sulmona', '7', '80011', '29640281761', 'Maria Sala');

INSERT INTO ristorante
    VALUES('Pizzeria La Scura','Via Enrico Fermi', '203', '00012', '90275401928', 'Martina Sultano');

INSERT INTO ristorante
    VALUES('La Fornacella','Vico Equenze', '149', '80033', '23904568127', 'Antonio Crimaldi');

INSERT INTO ristorante
    VALUES('Ristorante Da Carola','Via Don Giovanni', '10', '80001', '09128752801', 'Maria De Falco');

INSERT INTO ristorante
    VALUES('Pizzeria La Dalila','Via Carlo Salvo', '909', '60098', '10998208567', 'Marco Salvato');

--Non funzionano perchè la partita iva è a 11 caratteri qui c'è ne sono 12

--Popolazione della tabella SALA
INSERT INTO Sala
    VALUES(,'Sala Rossa', 13, '925837209391');

INSERT INTO Sala
    VALUES(,'Sala Gialla', 18, '925837209391');

INSERT INTO Sala
    VALUES(,'Sala Blu', 12, '925837209391');

INSERT INTO Sala
    VALUES(,'Sala Rosa', 12, '925837209391');

INSERT INTO Sala
    VALUES(,'Sala Verde', 8, '925837209391');

INSERT INTO Sala
    VALUES(,'Sala Magnum', 22, '925837209391');

INSERT INTO Sala
    VALUES(,'Londra', 8, '296402817640');

INSERT INTO Sala
    VALUES(,'Bruxel', 22, '296402817640');

INSERT INTO Sala
    VALUES(,'Prima', 22, '296402817611');

INSERT INTO Sala
    VALUES(,'Seconda', 8, '296402817611');

INSERT INTO Sala
    VALUES(,'Terza', 22, '296402817611');

INSERT INTO Sala
    VALUES(,'B', 22, '902754019286');

INSERT INTO Sala
    VALUES(,'D', 8, '902754019286');

INSERT INTO Sala
    VALUES(,'C', 22, '902754019286');

INSERT INTO Sala
    VALUES(,'Nobel', 12, '1239045681276');

INSERT INTO Sala
    VALUES(,'Palma', 28, '1239045681276');

INSERT INTO Sala
    VALUES(,'Oscar', 42, '1239045681276');

INSERT INTO Sala
    VALUES(,'Sala Rossa', 32, '091287528016');

INSERT INTO Sala
    VALUES(,'Piccola', 10, '109982085671');

INSERT INTO Sala
    VALUES(,'Grande', 19, '109982085671');