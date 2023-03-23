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
    codiceSala integer NOT NULL DEFAULT 1,
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

--Creazione tabella TAVOLA
CREATE TABLE tavola(
--Numero che distingue univocamente un tavolo tipo Stringa Not Null Unique
    numeroTavola integer NOT NULL DEFAULT 1,
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
    idTavolata integer NOT NULL DEFAULT 1,
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
    idSegnalazione integer NOT NULL DEFAULT 1,
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
EXECUTE PROCEDURE SengnalazionePK();

--Creazione tabella PERSONALE
CREATE TABLE personale(
--Numero che idetifica univocamente ogni membro del peronale tipo Stringa Not Null
    numeroOpt integer NOT NULL DEFAULT 1,
--Mansione assegnata a ogni membro del personale tipo mansione Not Null
    mansione mansione NOT NULL,
--Creazione della chiave primaria per la tabella personle ovvero numeroOtp
    CONSTRAINT PK_personale
        PRIMARY KEY(numeroOpt)
);

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