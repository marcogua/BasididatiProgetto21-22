--Creazione del database
CREATE DATABASE TracciamentoCovidRistoranti;

--Creazione delle enumerazioni

--Enumerazione per lo stato del persona che efettua la segnalazione
CREATE DOMAIN stato AS character varying(8)
CHECK(
    VALUE ~ 'Positivo'
    OR VALUE ~ 'Negativo'
);

--Creazione delle tabelle

--Creazione tabella RISTORANTE
CREATE TABLE ristorante(
nome character varying(64) NOT NULL,
via character varying(64) NOT NULL,
civico character varying(5) NOT NULL,
cap character varying(5) NOT NULL,
p_iva character varying(11) NOT NULL UNIQUE,
nome_proprietario character varying(64) NOT NULL
);

--Creazione tabella SALA
CREATE TABLE sala(
codice_sala character varying(4) NOT NULL UNIQUE,
nome_sala character varying(64) NOT NULL,
numero_tavoli integer NOT NULL,
p_iva character varying(11) NOT NULL UNIQUE
);

--Creazione tabella TAVOLA
CREATE TABLE tavola(
numero_tavola character varying(4) NOT NULL UNIQUE,
numero_persone_max integer NOT NULL,
codice_sala character varying(12) NOT NULL UNIQUE
);

--Creazione tabella VICINANZA
CREATE TABLE vicinanza(
    ntc character varying(12) NOT NULL UNIQUE,
    nts character varying(12) NOT NULL UNIQUE
);

--Creazione tabella TAVOLATA
CREATE TABLE tavolata(
id_tavolata character varying(12) NOT NULL UNIQUE,
elenco_persone character varying(64),
orario_arrivo date,
elenco_camerieri character varying(64),
nt character varying(12) NOT NULL UNIQUE
);

--Creazione tabella SEGNALAZIONE
CREATE TABLE segnalazione(
id_segnalazione character varying(64) NOT NULL UNIQUE,
stato_Covid stato NOT NULL,
data_segnalazione date NOT NULL,
tavolata character varying(12) NOT NULL UNIQUE
);

--Creazione tabella PERSONA
CREATE TABLE persona(
nome character varying(64) NOT NULL,
cognome character varying(64) NOT NULL,
telefono character varying(10) NOT NULL UNIQUE,
id_tavolata character varying(12) NOT NULL UNIQUE
);

--Creazione delle chiavi primarie e chiavi esterne

--Chiave primaria per la tabelle RISTORANTE
ALTER TABLE ristorante
    ADD CONSTRAINT PK_ristorante PRIMARY KEY(p_iva);

--Chiavi primarie e chiave esterna per la tabella SALA
ALTER TABLE sala
    ADD CONSTRAINT PK_sala
        PRIMARY KEY(codice_sala),
    ADD CONSTRAINT FK_sala
        FOREIGN KEY(p_iva)
            REFERENCES ristorante(p_iva);

--Chiavi primarie e esterne per la tabella TAVOLA
ALTER TABLE tavola
    ADD CONSTRAINT PK_tavola
        PRIMARY KEY(numero_tavola),
    ADD CONSTRAINT FK_tavola
        FOREIGN KEY(codice_sala)
            REFERENCES sala(codice_sala)

--Chiavi primarie e esterne per la tabella TAVOLATA
ALTER TABLE tavolata
    ADD CONSTRAINT PK_tavolata
        PRIMARY KEY(id_tavolata),
    ADD CONSTRAINT FK_tavolata
        FOREIGN KEY(nt)
            REFERENCES tavola(numero_tavola);

--Chiavi esterne per la tabella VICINANZA
ALTER TABLE vicinanza
    ADD CONSTRAINT FK_vicinanza1
        FOREIGN KEY(ntc)
            REFERENCES tavola(numero_tavola),
    ADD CONSTRAINT FK_vicinanza2
        FOREIGN KEY(nts)
            REFERENCES tavola(numero_tavola);

--Chiavi primarie e esterne per la tabella SEGNALAZIONE
ALTER TABLE segnalazione
    ADD CONSTRAINT PK_segnalazione
        PRIMARY KEY(id_segnalazione),
    ADD CONSTRAINT FK_segnalazione
        FOREIGN KEY(tavola)
            REFERENCES tavolata(id_tavolata);

--Chiavi esterne per la tabella PERSONA
ALTER TABLE persona
    ADD CONSTRAINT FK_persona
        FOREIGN KEY(id_tavolata)
            REFERENCES tavolata(id_tavolata)

--Creazione dei principali check

--Creazione dei trigger