--Creazione del database
CREATE DATABASE TracciamentoCovidRistoranti;

--Creazione tabella CLIENTE
CREATE TABLE cliente(
nome character varying(64),
cognome character varying(64),
numeroCartaIdentita character varying(8),
numeroTelefono character varying(10)
);

--Creazione tabella TAVOLATA
CREATE TABLE tavolata(
orarioArrivo date,
elencoCamerieri character varying(64),
elencoPersoneTavolo character varying(64)
);

--Creazione tabella RISTORANTE
CREATE TABLE ristorante(
nomeRistorante character varying(64),
proprietario character varying(64),
indirizzo character varying(64),
civico character varying(5),
cap integer,
pIva character varying(16)
);

--Creazione tabella SALA
CREATE TABLE sala(
codiceSala integer,
nomeSala character varying(64),
numeroTavoli integer
);

--Creazione tabella TAVOLO
CREATE TABLE tavolo(
codiceTavolo integer,
numeroMaxPersone integer
);

--Creazione tabella PERSONALE
CREATE TABLE personale(
nome character varying(64),
congome character varying(64),
telefono character varying(10),
ruolo character varying(64)
);

--Creazione tabella THEDIVISION ovvero persona infetta
CREATE TABLE theDivision(
statoCovid19 boolean
);
