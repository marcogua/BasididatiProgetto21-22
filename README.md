# BasididatiProgetto21-22
Questo è il progetto di basi di dati dell'anno 2021/2022

Autori: 
|Nome|Cognome|Matricola|Email|
|----|-------|---------|-----|
|Marco|Guadagno|N86002851|marco.guadagno@studenti.unina.it|
|Vittorio|Somma|N86002863|vit.somma@studenti.unina.it|

## Spiegazione tabelle

### Ristorante

|Nome attributo|Significato attributo|Tipo attributo|Sepcifiche|
|--------------|---------------------|--------------|----------|
|nome|Il nome del ristorante|Stringa|Not null|
|via|La via dove si trova il ristorante|Stringa|Not null|
|civico|il numero dove si trova il ristorante|Stringa|Not null|
|cap|numero di avviamento postale che serve ad identificare univocamente la città dove si trova il ristorante|Stringa|Not null|
|p_iva|il numero di partita iva del ristorante che lo identifica univocamente|Stringa|Not null - Unique|
|nome_proprietario|il nome del proprietario o proprietari del ristorante|Stringa|Not null|

```SQL
--Creazione tabella RISTORANTE
CREATE TABLE ristorante(
    nome character varying(255) NOT NULL,
    via character varying(255) NOT NULL,
    civico character varying(5) NOT NULL,
    cap character varying(5) NOT NULL,
    p_iva character varying(11) NOT NULL UNIQUE,
    nome_proprietario character varying(255) NOT NULL
);
```