--Creazione del database
-- CREATE DATABASE TracciamentoCovidRistoranti;

--Creazione delle enumerazioni

--Enumerazione per la tipologia di mansioni
CREATE DOMAIN mansione AS character varying(16)
    CHECK(
        VALUE = 'Barman'
        OR VALUE = 'Cameriere'
        OR VALUE = 'Cuoco'
        OR VALUE = 'DirettoreDiSala'
);

/*
*TABELLA: RISTORANTE
*Crea la tabella e implementa i vincoli principali
*/
--Creazione tabella RISTORANTE
CREATE TABLE RISTORANTE(
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

--Crea il vincolo di chiave primaria
ALTER TABLE RISTORANTE
ADD CONSTRAINT PK_ristorante
    PRIMARY KEY(p_iva);

/*
*TABELLA: SALA
*Crea la tabella e implementa i vincoli principali
*/
--Creazione tabella SALA
CREATE TABLE SALA(
--Codice univoco che identifica una sala tipo Stringa Not Null Unique
    codiceSala integer NOT NULL DEFAULT 1,
--Nome della sala tipo Stringa Not Null
    nomeSala character varying(255) NOT NULL,
--Numero di tavoli presenti nella sala tipo Integer Not Null
    numeroTavoli integer NOT NULL,
--Numero di partita iva del ristorante tipo Striga Not Null
    p_iva character varying(11) NOT NULL,
--Check per controllare che il nomeSala contenga solo lettere
    CONSTRAINT CHK_nomeSalaSala
        CHECK (nomeSala ~ '^[A-Za-z ]*$'),
--Check per controllare che la p_iva contenga solo numeri
    CONSTRAINT CHK_p_ivaSala
        CHECK (p_iva ~ '^[0-9]*$')
);

--Cra il vincolo di chiave primaria ed esterna
ALTER TABLE SALA
    ADD CONSTRAINT PK_sala
        PRIMARY KEY(codiceSala),
    ADD CONSTRAINT FK_sala
        FOREIGN KEY(p_iva)
            REFERENCES ristorante(p_iva)
                ON UPDATE CASCADE
                ON DELETE CASCADE;
                
--Trigger per settare la chiave primaria automaticamente
CREATE OR REPLACE FUNCTION SalaPK()
    RETURNS TRIGGER
AS $$
DECLARE
    pk sala.codiceSala%TYPE;
BEGIN
	SELECT MAX(codiceSala) + 1 into pk FROM sala;
    IF(NEW.codiceSala != pk)THEN
        NEW.codiceSala := pk;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER SalaPK
BEFORE INSERT
ON sala
FOR EACH ROW
EXECUTE PROCEDURE SalaPK();

/*
*TABELLA: TAVOLA
*Crea la tabella tavola e implementa i principali vincoli
*/
--Creazione tabella TAVOLA
CREATE TABLE tavola(
--Numero che distingue univocamente un tavolo tipo Stringa Not Null Unique
    numeroTavola integer NOT NULL DEFAULT 1,
--Numero massimo di persone che possono stare a quel tavolo tipo Integer Not Null
    numeroPersoneMax integer NOT NULL,
--Codice della sala dove si trova il tavolo tipo Stringa Not Null
    codiceSala integer NOT NULL
);

--Crea i vincoli di chiave primaria ed esterna
ALTER TABLE TAVOLA
    ADD CONSTRAINT PK_tavola
        PRIMARY KEY(numeroTavola),
    ADD CONSTRAINT FK_tavola
        FOREIGN KEY(codiceSala)
            REFERENCES sala(codiceSala)
                ON UPDATE CASCADE
                ON DELETE CASCADE;

--Trigger per settare la chiave primaria automaticamente
CREATE OR REPLACE FUNCTION TavolaPK()
    RETURNS TRIGGER
AS $$
DECLARE
    pk tavola.numeroTavola%TYPE;
BEGIN
	SELECT MAX(numeroTavola) + 1 into pk FROM tavola;
    IF(NEW.numeroTavola != pk)THEN
        NEW.numeroTavola := pk;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER TavolaPK
BEFORE INSERT
ON tavola
FOR EACH ROW
EXECUTE PROCEDURE TavolaPK();

/*
*TABELLA: VICINANZA
*Crea la tabella e implementa i principali vincoli
*/
--Creazione tabella VICINANZA
CREATE TABLE VICINANZA(
--Numero della tavola corrente tipo Not Null
    ntc integer NOT NULL,
--Numero della tavola succesiva tipo Stringa Not Null
    nts integer NOT NULL
);

--Crea i vincoli di chiave esterna
ALTER TABLE VICINANZA
    ADD CONSTRAINT FK_vicinanza1
        FOREIGN KEY(ntc)
            REFERENCES tavola(numeroTavola)
                ON UPDATE CASCADE
                ON DELETE CASCADE,
    ADD CONSTRAINT FK_vicinanza2
        FOREIGN KEY(nts)
            REFERENCES tavola(numeroTavola)
                ON UPDATE CASCADE
                ON DELETE CASCADE;

/*
*TABELLA: TAVOLATA
*Crea la tabella e i pricipali vincoli
*/
--Creazione tabella TAVOLATA
CREATE TABLE TAVOLATA(
--Numero che identifica unicovamente una tavolata tipo Stringa Not Null Unique
    idTavolata integer NOT NULL DEFAULT 1,
--Data di arrivo della tavolata tipo Date Not Null
    dataArrivo date NOT NULL,
--Oriario di arrivo della tavolta tipo Time Not Null
    orarioArrivo time NOT NULL,
--Numero che idetifica univocamente la tavola assengata tipo Stringa Not Null
    numeroTavolata integer NOT NULL
);

--Crea i vincoli di chiave primaria ed esterna
ALTER TABLE TAVOLATA
    ADD CONSTRAINT PK_tavolata
        PRIMARY KEY(idTavolata),
    ADD CONSTRAINT FK_tavolata
        FOREIGN KEY(numeroTavolata)
            REFERENCES tavola(numeroTavola)
                ON UPDATE CASCADE
                ON DELETE CASCADE;

--Trigger per settare la chiave primaria automaticamente
CREATE OR REPLACE FUNCTION TavolataPK()
    RETURNS TRIGGER
AS $$
DECLARE
    pk tavolata.idTavolata%TYPE;
BEGIN
	SELECT MAX(idTavolata) + 1 into pk FROM tavolata;
    IF(NEW.idTavolata != pk)THEN
        NEW.idTavolata := pk;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER TavolataPK
BEFORE INSERT
ON tavolata
FOR EACH ROW
EXECUTE PROCEDURE TavolataPK();

/*
*TABELLA AVVENTORE
*Crea la tabella e i pricipali vincoli
*/
--Creazione tabella AVVENTORE
CREATE TABLE AVVENTORE(
--Numero della carta di indentià dell'avventore tipo Stringa Not Null Unique
    numeroCartaIdentita character varying(9) NOT NULL,

--Check per controllare che il numeriCartaIdentita sia conforme alla carta di indetita nuova
    CONSTRAINT CHK_numeroCartaIdentitaAvventore
CHECK (numeroCartaIdentita ~ '^[A-Za-z]{2}[0-9]{5}[A-Za-z]{2}.*$')
);

--Crea il vincolo di chiave primaria
ALTER TABLE AVVENTORE
    ADD CONSTRAINT PK_avventore
        PRIMARY KEY(numeroCartaIdentita);

/*
*TABELLA: SEGNALAZIONE
*Crea la tabella e i principali vincoli
*/
--Creazione tabella SEGNALAZIONE
CREATE TABLE SEGNALAZIONE(
--Numero che identifica unicovamente la sengalazione tipo Stringa Not Null Unique
    idSegnalazione integer NOT NULL DEFAULT 1,
--Data della segnalazione tipo Date Not Null
    dataSegnalazione date NOT NULL,
--Tavolata a cui ha partecipato la sengalazione tipo Stringa Not Null
    tavolata integer NOT NULL,
--Persona che ha fatto la segnalazione
    numeroPersona character varying(9) NOT NULL
);

--Crea i vincoli di chiave primaria ed esterna
ALTER TABLE SEGNALAZIONE
    ADD CONSTRAINT PK_segnalazione
        PRIMARY KEY(idSegnalazione),
    ADD CONSTRAINT FK_segnalazione
        FOREIGN KEY(tavolata)
            REFERENCES tavolata(idTavolata)
                ON UPDATE CASCADE
                ON DELETE CASCADE,
    ADD CONSTRAINT FK_segnalazione2
        FOREIGN KEY(numeroPersona)
            REFERENCES avventore(numeroCartaIdentita)
                ON UPDATE CASCADE
                ON DELETE CASCADE;

--Trigger per settare la chiave primaria automaticamente
CREATE OR REPLACE FUNCTION SegnalazionePK()
    RETURNS TRIGGER
AS $$
DECLARE
    pk segnalazione.idSegnalazione%TYPE;
BEGIN
	SELECT MAX(idSegnalazione) + 1 into pk FROM segnalazione;
    IF(NEW.idSegnalazione != pk)THEN
        NEW.idSegnalazione := pk;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER SegnalazionePK
BEFORE INSERT
ON segnalazione
FOR EACH ROW
EXECUTE PROCEDURE SegnalazionePK();

/*
*TABELLA: PERSONALE
*Crea la tabella e i principali vincoli
*/
--Creazione tabella PERSONALE
CREATE TABLE PERSONALE(
--Numero che idetifica univocamente ogni membro del peronale tipo Stringa Not Null
    numeroOpt integer NOT NULL,
--Mansione assegnata a ogni membro del personale tipo mansione Not Null
    mansione mansione
);

--Crea il vincolo di chiave primaria
ALTER TABLE PERSONALE
    ADD CONSTRAINT PK_personale
        PRIMARY KEY(numeroOpt);

--Trigger per settare la chiave primaria automaticamente
CREATE OR REPLACE FUNCTION PersonalePK()
    RETURNS TRIGGER
AS $$
DECLARE
    pk personale.numeroOpt%TYPE;
BEGIN
	SELECT MAX(numeroOpt) + 1 into pk FROM personale;
    IF(NEW.numeroOpt != pk)THEN
        NEW.numeroOpt := pk;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER PersonalePK
BEFORE INSERT
ON personale
FOR EACH ROW
EXECUTE PROCEDURE PersonalePK();

/*
*TABELLA: PERSONA
*Crea la tabella e i principali vincoli
*/
--Creazione tabella PERSONA
CREATE TABLE PERSONA(
--Nome della persona tipo Stringa Not Null
    nome character varying(64) NOT NULL,
--Cognome della persona tipo Stringa Not Null
    cognome character varying(64) NOT NULL,
--Numero di telefono della persona tipo Stringa Not Null Unique
    telefono character varying(10) NOT NULL UNIQUE,
--Numero che identifica univocamente un mebro del personale tipo Stringa Not Null Unique
    numeroOpt integer UNIQUE,
--Numero di carta di identità che identifica univocamente una persona tipo Stringa Not Null Unique
    numeroCartaIdentita character varying(9) UNIQUE,
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
        CHECK (numeroCartaIdentita ~ '^[A-Za-z]{2}[0-9]{5}[A-Za-z]{2}.*$')
);

--Crea i vincoli di chiave esterna
ALTER TABLE PERSONA
    ADD CONSTRAINT FK_persona1
        FOREIGN KEY(numeroOpt)
            REFERENCES personale(numeroOpt)
                ON UPDATE CASCADE
                ON DELETE CASCADE,
    ADD CONSTRAINT FK_persona2
        FOREIGN KEY(numeroCartaIdentita)
            REFERENCES avventore(numeroCartaIdentita)
                ON UPDATE CASCADE
                ON DELETE CASCADE;
                
--Trigger per l'inserimento di personale e avventore
CREATE OR REPLACE FUNCTION InsertPersonaAvventore()
    RETURNS TRIGGER
AS $$
DECLARE
    BEGIN
	IF(NEW.numeroOpt IS NOT NULL)THEN
        	INSERT INTO personale VALUES (NEW.numeroOpt, 'Cuoco');
        	UPDATE persona SET numeroOpt = NEW.numeroOpt WHERE telefono = OLD.telefono;
		END IF;
        INSERT INTO avventore VALUES (NEW.numeroCartaIdentita);
        UPDATE persona SET numeroCartaIdentita = OLD.numeroCartaIdentita WHERE telefono = OLD.telefono;
	RETURN NEW;
    COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER InsertPersonaleAvventore
BEFORE INSERT
ON persona
FOR EACH ROW
EXECUTE PROCEDURE InsertPersonaAvventore();

/*
*TABELLA: SERVITO
*Crea la tabella e i pincipali vincoli
*/
--Creazione tabella SERVITO
CREATE TABLE SERVITO(
--Numero che identifica univocamente un membro del personale tipo Stringa Not Null
    numeroOpt integer NOT NULL, 
--Numero che identifica univocamente una tavolata tipo Stringa Not Null
    idTavolata integer NOT NULL
);

--Crea i vincoli di chiave esterna
ALTER TABLE SERVITO
    ADD CONSTRAINT FK_servito1
        FOREIGN KEY(numeroOpt)
            REFERENCES personale(numeroOpt)
                ON UPDATE CASCADE
                ON DELETE CASCADE,
    ADD CONSTRAINT FK_servito2
        FOREIGN KEY(idTavolata)
            REFERENCES tavolata(idTavolata)
                ON UPDATE CASCADE
                ON DELETE CASCADE;

/*
*TABELLA PARTECIPA
*Crea la tabella e i principali vincoli
*/
--Creazione tabella PARTECIPA
CREATE TABLE PARTECIPA(
--Numero che identifica univocamente una tavolata tipo Strinfa Not Null
    idTavolata integer NOT NULL,
--Numero carta di identità che identifica univocamente una persona tipo Stringa Not Null
    numeroCartaIdentita character varying(9) NOT NULL

);

--Crea i vincoli di chiave esterna
ALTER TABLE PARTECIPA
    ADD CONSTRAINT FK_partecipa1
        FOREIGN KEY(idTavolata)
            REFERENCES tavolata(idTavolata)
                ON UPDATE CASCADE
                ON DELETE CASCADE,
    ADD CONSTRAINT FK_partecipa2
        FOREIGN KEY(numeroCartaIdentita)
            REFERENCES avventore(numeroCartaIdentita)
                ON UPDATE CASCADE
                ON DELETE CASCADE;