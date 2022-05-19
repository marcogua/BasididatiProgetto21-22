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
cap character varying(5),
numero_partita_iva character varying(11)
);

--Creazione tabella SALA
CREATE TABLE sala(
codice_sala character varying(4),
nome_sala character varying(64),
numero_tavoli integer
);

--Creazione tabella TAVOLO
CREATE TABLE tavolo(
codice_tavolo character varying(4),
numero_massimo_persone integer
);

--Creazione tabella PERSONALE
CREATE TABLE personale(
nome character varying(64),
congome character varying(64),
numero_telefono character varying(10),
mansione character varying(64)
);

--Creazione tabella SEGNALAZIONE
CREATE TABLE segnalazione(
stato_Covid19 stato,
data_segnalazione date
);

--Creazione delle chiavi primarie e chiavi esterne

--Creazione dei principali check

--Creazione dei trigger