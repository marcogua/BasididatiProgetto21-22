# BasididatiProgetto21-22

Questo è il progetto di basi di dati dell'anno 2021/2022

Autori:
|Nome|Cognome|Matricola|Email|
|----|-------|---------|-----|
|Marco|Guadagno|N86002851|marco.guadagno@studenti.unina.it|
|Vittorio|Somma|N86002863|vit.somma@studenti.unina.it|

## Spiegazione enumerazioni

### Stato

| Valore   | Significato          |
| -------- | -------------------- |
| Positivo | Positivo al Covid-19 |
| Negativo | Negativo al Covid-19 |

```SQL
CREATE DOMAIN stato AS character varying(8)
    CHECK(
        VALUE ~ 'Positivo'
        OR VALUE ~ 'Negativo'
);
```

### Mansione

| Valore          | Significato                           |
| --------------- | ------------------------------------- |
| Barman          | Lavora nel ruolo di barma             |
| Cameriere       | Lavora nel ruolo di cameriere         |
| Cuoco           | Lavora nel ruolo di cuoco             |
| DirettoreDiSala | Lavora nel ruolo di direttore di sala |

```SQL
CREATE DOMAIN mansione AS character varying(16)
    CHECK(
        VALUE ~ 'Barman'
        OR VALUE ~ 'Cameriere'
        OR VALUE ~ 'Cuoco'
        OR VALUE ~ 'DirettoreDiSala'
);
```

## Spiegazione tabelle

### Ristorante

| Nome attributo    | Significato attributo                                                                                    | Tipo attributo | Sepcifiche        |
| ----------------- | -------------------------------------------------------------------------------------------------------- | -------------- | ----------------- |
| nome              | Il nome del ristorante                                                                                   | Stringa        | Not null          |
| via               | La via dove si trova il ristorante                                                                       | Stringa        | Not null          |
| civico            | il numero dove si trova il ristorante                                                                    | Stringa        | Not null          |
| cap               | numero di avviamento postale che serve ad identificare univocamente la città dove si trova il ristorante | Stringa        | Not null          |
| p_iva             | il numero di partita iva del ristorante che lo identifica univocamente                                   | Stringa        | Not null - Unique |
| nome_proprietario | il nome del proprietario o proprietari del ristorante                                                    | Stringa        | Not null          |

```SQL
--Creazione tabella RISTORANTE
CREATE TABLE ristorante(
    nome character varying(255) NOT NULL,
    via character varying(255) NOT NULL,
    civico character varying(5) NOT NULL,
    cap character varying(5) NOT NULL,
    p_iva character varying(11) NOT NULL UNIQUE,
    nomeProprietario character varying(255) NOT NULL,
    CONSTRAINT PK_ristorante
        PRIMARY KEY(p_iva)
);
```

### Persone

```SQL
--Creazione tabella SALA
CREATE TABLE sala(
    codiceSala character varying(12) NOT NULL UNIQUE,
    nomeSala character varying(255) NOT NULL,
    numeroTavoli integer NOT NULL,
    p_iva character varying(11) NOT NULL UNIQUE,
    CONSTRAINT PK_sala
        PRIMARY KEY(codiceSala),
    CONSTRAINT FK_sala
        FOREIGN KEY(p_iva)
            REFERENCES ristorante(p_iva)
);
```

### Tavola

```SQL
--Creazione tabella TAVOLA
CREATE TABLE tavola(
    numeroTavola character varying(12) NOT NULL UNIQUE,
    numeroPersoneMax integer NOT NULL,
    codiceSala character varying(12) NOT NULL UNIQUE,
    CONSTRAINT PK_tavola
        PRIMARY KEY(numeroTavola),
    CONSTRAINT FK_tavola
        FOREIGN KEY(codiceSala)
            REFERENCES sala(codiceSala)
);
```

### Vicinanza

```SQL
--Creazione tabella VICINANZA
CREATE TABLE vicinanza(
    ntc character varying(12) NOT NULL UNIQUE,
    nts character varying(12) NOT NULL UNIQUE,
    CONSTRAINT FK_vicinanza1
        FOREIGN KEY(ntc)
            REFERENCES tavola(numeroTavola),
    CONSTRAINT FK_vicinanza2
        FOREIGN KEY(nts)
            REFERENCES tavola(numeroTavola)
);
```

### Tavolata

```SQL
--Creazione tabella TAVOLATA
CREATE TABLE tavolata(
    idTavolata character varying(12) NOT NULL UNIQUE,
    dataArrivo date NOT NULL,
    orarioArrivo time NOT NULL,
    numeroTavolata character varying(12) NOT NULL UNIQUE,
    CONSTRAINT PK_tavolata
        PRIMARY KEY(idTavolata),
    CONSTRAINT FK_tavolata
        FOREIGN KEY(numeroTavolata)
            REFERENCES tavola(numeroTavola)
);
```

### Segnalazione

```SQL
--Creazione tabella SEGNALAZIONE
CREATE TABLE segnalazione(
    idSegnalazione character varying(64) NOT NULL UNIQUE,
    statoCovid stato NOT NULL,
    dataSegnalazione date NOT NULL,
    tavolata character varying(12) NOT NULL UNIQUE,
    CONSTRAINT PK_segnalazione
        PRIMARY KEY(idSegnalazione),
    CONSTRAINT FK_segnalazione
        FOREIGN KEY(tavolata)
            REFERENCES tavolata(idTavolata)
);
```

### Avventore

```SQL
--Creazione tabella AVVENTORE
CREATE TABLE avventore(
    numeroCartaIdentita character varying(8),
    CONSTRAINT PK_avventore
        PRIMARY KEY(numeroCartaIdentita)
);
```

### Personale

```SQL
--Creazione tabella PERSONALE
CREATE TABLE personale(
    numeroOpt character varying(12) NOT NULL UNIQUE,
    mansione mansione NOT NULL,
    CONSTRAINT PK_personale
        PRIMARY KEY(numeroOpt)
);
```

### Persona

```SQL
--Creazione tabella PERSONA
CREATE TABLE persona(
    nome character varying(64) NOT NULL,
    cognome character varying(64) NOT NULL,
    telefono character varying(10) NOT NULL UNIQUE,
    numeroOpt character varying(12) NOT NULL UNIQUE,
    numeroCartaIdentita character varying(8) NOT NULL UNIQUE,
    CONSTRAINT FK_persona1
        FOREIGN KEY(numeroOpt)
            REFERENCES personale(numeroOpt),
    CONSTRAINT FK_persona2
        FOREIGN KEY(numeroCartaIdentita)
            REFERENCES avventore(numeroCartaIdentita)
);
```

### Servito

```SQL
--Creazione tabella SERVITO
CREATE TABLE servito(
    numeroOpt character varying(12) NOT NULL UNIQUE,
    idTavolata character varying(12) NOT NULL UNIQUE,
    CONSTRAINT FK_servito1
        FOREIGN KEY(numeroOpt)
            REFERENCES personale(numeroOpt),
    CONSTRAINT FK_servito2
        FOREIGN KEY(idTavolata)
            REFERENCES tavolata(idTavolata)
);
```

### Partecipa

```SQL
--Creazione tabella PARTECIPA
CREATE TABLE partecipa(
    idTavolata character varying(12) NOT NULL UNIQUE,
    numeroCartaIdentita character varying(8) NOT NULL UNIQUE,
    CONSTRAINT FK_partecipa1
        FOREIGN KEY(idTavolata)
            REFERENCES tavolata(idTavolata),
    CONSTRAINT FK_partecipa2
        FOREIGN KEY(numeroCartaIdentita)
            REFERENCES avventore(numeroCartaIdentita)
);
```
