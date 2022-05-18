--Creazione del database
CREATE DATABASE TracciamentoCovidRistoranti;

--Creazione delle tabelle

--Creazione tabella CLIENTE
CREATE TABLE cliente(
nome character varying(64),
cognome character varying(64),
numero_carta_identita character varying(8),
numero_telefono character varying(10)
);

--Creazione tabella TAVOLATA
CREATE TABLE tavolata(
orario_arrivo date,
elenco_personale character varying(64),
elenco_persone_tavolo character varying(64)
);

--Creazione tabella RISTORANTE
CREATE TABLE ristorante(
nome_ristorante character varying(64),
proprietario character varying(64),
indirizzo character varying(64),
civico character varying(5),
cap integer,
numero_partita_iva character varying(11)
);

--Creazione tabella SALA
CREATE TABLE sala(
codice_sala integer,
nome_sala character varying(64),
numero_tavoli integer
);

--Creazione tabella TAVOLO
CREATE TABLE tavolo(
codice_tavolo integer,
numero_massimo_persone integer
);

--Creazione tabella PERSONALE
CREATE TABLE personale(
nome character varying(64),
congome character varying(64),
numero_telefono character varying(10),
mansione character varying(64)
);

--Creazione tabella THEDIVISION ovvero persona infetta
CREATE TABLE theDivision(
stato_Covid19 boolean
);
