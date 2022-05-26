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

```SQL
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
    p_iva character varying(11) NOT NULL UNIQUE,
--Nome del proprietario o dei prorpietari tipo Stringa Not Null
    nomeProprietario character varying(255) NOT NULL,
--Creazione della chiave primaria di ristorante ovvero p_iva(numero di partita iva)
    CONSTRAINT PK_ristorante
        PRIMARY KEY(p_iva)
);
```

### Persone

```SQL
--Creazione tabella SALA
CREATE TABLE sala(
--Codice univoco che identifica una sala tipo Stringa Not Null Unique
    codiceSala character varying(12) NOT NULL UNIQUE,
--Nome della sala tipo Stringa Not Null
    nomeSala character varying(255) NOT NULL,
--Numero di tavoli presenti nella sala tipo Integer Not Null
    numeroTavoli integer NOT NULL,
--Numero di partita iva del ristorante tipo Striga Not Null Unique
    p_iva character varying(11) NOT NULL UNIQUE,
--Creazione della chiva primaria di sala ovvero codiceSala(codice della sala)
    CONSTRAINT PK_sala
        PRIMARY KEY(codiceSala),
--Creazione della chiave esterna di sala ovvero p_iva(numero di partita iva) che fa riferimento a ristorante.p_iva(numero partita iva)
    CONSTRAINT FK_sala
        FOREIGN KEY(p_iva)
            REFERENCES ristorante(p_iva)
);
```

### Tavola

```SQL
--Creazione tabella TAVOLA
CREATE TABLE tavola(
--Numero che distingue univocamente un tavolo tipo Stringa Not Null Unique
    numeroTavola character varying(12) NOT NULL UNIQUE,
--Numero massimo di persone che possono stare a quel tavolo tipo Integer Not Null
    numeroPersoneMax integer NOT NULL,
--Codice della sala dove si trova il tavolo tipo Stringa Not Null Unique
    codiceSala character varying(12) NOT NULL UNIQUE,
--Creazione della chiave primaria per la tabella tavola ovvero numeroTavola
    CONSTRAINT PK_tavola
        PRIMARY KEY(numeroTavola),
--Creazione della chiave esterna di tavola ovvero codiceSala che fa riferimento a sala.codiceSala
    CONSTRAINT FK_tavola
        FOREIGN KEY(codiceSala)
            REFERENCES sala(codiceSala)
);
```

### Vicinanza

```SQL
--Creazione tabella VICINANZA
CREATE TABLE vicinanza(
--Numero della tavola corrente tipo Not Null Unique
    ntc character varying(12) NOT NULL UNIQUE,
--Numero della tavola succesiva tipo Stringa Not Null Unique
    nts character varying(12) NOT NULL UNIQUE,
--Creazione della chiave esterna per la tabella vicinanza ovvero ntc che fa riferimento a tavola.numeroTavola
    CONSTRAINT FK_vicinanza1
        FOREIGN KEY(ntc)
            REFERENCES tavola(numeroTavola),
--Creazione della chiave esterna per la tabella vicinanza ovvero nts che fa riferimento a tavola.numeroTavola
    CONSTRAINT FK_vicinanza2
        FOREIGN KEY(nts)
            REFERENCES tavola(numeroTavola)
);
```

### Tavolata

```SQL
--Creazione tabella TAVOLATA
CREATE TABLE tavolata(
--Numero che identifica unicovamente una tavolata tipo Stringa Not Null Unique
    idTavolata character varying(12) NOT NULL UNIQUE,
--Data di arrivo della tavolata tipo Date Not Null
    dataArrivo date NOT NULL,
--Oriario di arrivo della tavolta tipo Time Not Null
    orarioArrivo time NOT NULL,
--Numero che idetifica univocamente la tavola assengata tipo Stringa Not Null Unique
    numeroTavolata character varying(12) NOT NULL UNIQUE,
--Chiave primaria per la tabella tavolata ovvero idTavolata
    CONSTRAINT PK_tavolata
        PRIMARY KEY(idTavolata),
--Chiave estenra per la tabella tavolata ovvero numeroTavolata che fa riferimento a tavola.numeroTavola
    CONSTRAINT FK_tavolata
        FOREIGN KEY(numeroTavolata)
            REFERENCES tavola(numeroTavola)
);
```

### Segnalazione

```SQL
--Creazione tabella SEGNALAZIONE
CREATE TABLE segnalazione(
--Numero che identifica unicovamente la sengalazione tipo Stringa Not Null Unique
    idSegnalazione character varying(64) NOT NULL UNIQUE,
--Stato della persona che ha inviato la sengalazione tipo Stato Not Null
    statoCovid stato NOT NULL,
--Data della segnalazione tipo Date Not Null
    dataSegnalazione date NOT NULL,
--Tavolata a cui ha partecipato la sengalazione tipo Stringa Not Null
    tavolata character varying(12) NOT NULL,
--Creazione della chiave primaria per la tabella segnalazione ovvero idSegalazione
    CONSTRAINT PK_segnalazione
        PRIMARY KEY(idSegnalazione),
--Creazione della chiave esterna per la tabella sengalazione ovvero tavolata che fa riferimento a tavolata.idTavolata
    CONSTRAINT FK_segnalazione
        FOREIGN KEY(tavolata)
            REFERENCES tavolata(idTavolata)
);
```

### Avventore

```SQL
--Creazione tabella AVVENTORE
CREATE TABLE avventore(
--Numero della carta di indentià dell'avventore tipo Stringa Not Null Unique
    numeroCartaIdentita character varying(8) NOT NULL UNIQUE,
--Creazione della chiave primaria per la tabella avventore ovvero numeroCartaIdentita
    CONSTRAINT PK_avventore
        PRIMARY KEY(numeroCartaIdentita)
);
```

### Personale

```SQL
--Creazione tabella PERSONALE
CREATE TABLE personale(
--Numero che idetifica univocamente ogni membro del peronale tipo Stringa Not Null Unique
    numeroOpt character varying(12) NOT NULL UNIQUE,
--Mansione assegnata a ogni membro del personale tipo mansione Not Null
    mansione mansione NOT NULL,
--Creazione della chiave primaria per la tabella personle ovvero numeroOtp
    CONSTRAINT PK_personale
        PRIMARY KEY(numeroOpt)
);
```

### Persona

```SQL
--Creazione tabella PERSONA
CREATE TABLE persona(
--Nome della persona tipo Stringa Not Null
    nome character varying(64) NOT NULL,
--Cognome della persona tipo Stringa Not Null
    cognome character varying(64) NOT NULL,
--Numero di telefono della persona tipo Stringa Not Null Unique
    telefono character varying(10) NOT NULL UNIQUE,
--Numero che identifica univocamente un mebro del personale tipo Stringa Not Null Unique
    numeroOpt character varying(12) NOT NULL UNIQUE,
--Numero di carta di identità che identifica univocamente una persona tipo Stringa Not Null Unique
    numeroCartaIdentita character varying(8) NOT NULL UNIQUE,
--Creazione della chiave esterna per la tabella persona ovvero numeroOtp che fa riferimento a personale.numeroOtp
    CONSTRAINT FK_persona1
        FOREIGN KEY(numeroOpt)
            REFERENCES personale(numeroOpt),
--Creazione della chiave esterna per la tabella persona ovvero numeroCartaIdentita che fa riferimento a avventore.numeroCartaIdentita
    CONSTRAINT FK_persona2
        FOREIGN KEY(numeroCartaIdentita)
            REFERENCES avventore(numeroCartaIdentita)
);
```

### Servito

```SQL
--Creazione tabella SERVITO
CREATE TABLE servito(
--Numero che identifica univocamente un membro del personale tipo Stringa Not Null Unique
    numeroOpt character varying(12) NOT NULL UNIQUE,
--Numero che identifica univocamente una tavolata tipo Strinfa Not Null Unique
    idTavolata character varying(12) NOT NULL UNIQUE,
--Creazione della chiave esterna per la tabella servito ovvero numeroOtp che fa riferimento a personale.numeroOtp
    CONSTRAINT FK_servito1
        FOREIGN KEY(numeroOpt)
            REFERENCES personale(numeroOpt),
--Creazione della chiave esterna per la tabella servito ovvero idTavolata che fa riferimento a tavolata.idTavolata
    CONSTRAINT FK_servito2
        FOREIGN KEY(idTavolata)
            REFERENCES tavolata(idTavolata)
);
```

### Partecipa

```SQL
--Creazione tabella PARTECIPA
CREATE TABLE partecipa(
--Numero che identifica univocamente una tavolata tipo Strinfa Not Null Unique
    idTavolata character varying(12) NOT NULL UNIQUE,
--Numero carta di identità che identifica univocamente una persona tipo Stringa Not Null Unique
    numeroCartaIdentita character varying(8) NOT NULL UNIQUE,
--Creazione della chiave esterna per la tabella partecipa ovvero idTavolata che fa riferimento a tavolata.idTavolata
    CONSTRAINT FK_partecipa1
        FOREIGN KEY(idTavolata)
            REFERENCES tavolata(idTavolata),
--Creazione della chiave esterna per la tabella partecipa ovvero numeroCartaIdentita che fa riferimento a avventore.numeroCartaIdentita
    CONSTRAINT FK_partecipa2
        FOREIGN KEY(numeroCartaIdentita)
            REFERENCES avventore(numeroCartaIdentita)
);
```
