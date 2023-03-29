--Trigger per l'inserimento della tavolata
CREATE OR REPLACE FUNCTION controllaPrenotazione()
    RETURNS TRIGGER
AS $$
DECLARE
	dataCorrente date;
	oraCorrente TIME;
    BEGIN
		SELECT CAST(NOW() AS DATE) INTO dataCorrente;
		SELECT CAST(NOW() AS TIME) INTO oraCorrente;
		IF(NEW.dataarrivo <= dataCorrente AND NEW.orarioArrivo <= oraCorrente)THEN
			RETURN NULL;
		END IF;
	RETURN NEW;
    COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER controllaPrenotazione
BEFORE INSERT OR UPDATE
ON tavolata
FOR EACH ROW
EXECUTE PROCEDURE controllaPrenotazione();

--Trigger per l'inserimento di personale
CREATE OR REPLACE FUNCTION inserisciPersonale()
    RETURNS TRIGGER
AS $$
DECLARE
    BEGIN
	IF(NEW.numeroOpt IS NOT NULL)THEN
		IF NOT EXISTS (SELECT 1 FROM persona WHERE numeroCartaIdentita = NEW.numeroCartaIdentita)THEN
			IF NOT EXISTS (SELECT 1 FROM personale WHERE numeroOpt = NEW.numeroOpt)THEN
				INSERT INTO personale VALUES (NEW.numeroOpt, 'Non ancora assegnato');
				RETURN NEW;
			END IF;
			RETURN NULL;
		END IF;
		RETURN NULL;
	END IF;
	RETURN NEW;
    COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER inserisciPersonale
BEFORE INSERT
ON persona
FOR EACH ROW
EXECUTE PROCEDURE inserisciPersonale();

--Trigger per il controllo di persona
CREATE OR REPLACE FUNCTION controllaPersona()
    RETURNS TRIGGER
AS $$
DECLARE
    BEGIN
		IF EXISTS (SELECT 1 FROM persona WHERE telefono = NEW.telefono)THEN
		RETURN NULL;
		END IF;
	RETURN NEW;
    COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER controllaPersona
BEFORE INSERT OR UPDATE
ON persona
FOR EACH ROW
EXECUTE PROCEDURE controllaPersona();

--Trigger per il controllo di segnalazione
CREATE OR REPLACE FUNCTION controllaSegnalazione()
    RETURNS TRIGGER
AS $$
DECLARE
    BEGIN
		IF NOT EXISTS (SELECT 0 FROM partecipa WHERE (idtavolata = NEW.idTavolata AND numerocartaidentita = NEW.numerocartaidentita))THEN
			RETURN NULL;
		END IF;
	RETURN NEW;
    COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER controllaSegnalazione
BEFORE INSERT OR UPDATE
ON segnalazione
FOR EACH ROW
EXECUTE PROCEDURE controllaSegnalazione();

--Trigger per l'inserimento della tavolata contolla che non esista gia tavolata assegnata a quel tavolo a quell'ora e data
CREATE OR REPLACE FUNCTION controllaAssegnazione()
    RETURNS TRIGGER
AS $$
DECLARE
	dataPrenotazione DATE;
	oraPrenotazioneTMP TIME;
	tavola INTEGER;
    BEGIN
		dataPrenotazione = NEW.dataarrivo;
		tavola = NEW.numeroTavolo;
		oraPrenotazioneTMP = NEW.orarioArrivo;
			IF EXISTS (SELECT 1 FROM tavolata WHERE orarioArrivo BETWEEN oraPrenotazioneTMP - interval '59 minutes' AND oraPrenotazioneTMP + interval '59 minutes' AND numeroTavolo = tavola)THEN
				RETURN NULL;
			END IF;
	RETURN NEW;
    COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER controllaAssegnazione
BEFORE INSERT OR UPDATE
ON tavolata
FOR EACH ROW
EXECUTE PROCEDURE controllaAssegnazione();

--Trigger che controlla che il numero di persone inserite non ecceda il numero di persone del tavolo
CREATE OR REPLACE FUNCTION controllaTavolo()
    RETURNS TRIGGER
AS $$
DECLARE
	count integer;
	limitePersone integer;
	nTavola integer;
    BEGIN
		SELECT numeroTavolo into nTavola FROM tavolata WHERE idTavolata = NEW.idTavolata;
		SELECT numeroMaxPersone into limitePersone FROM tavola WHERE numeroTavolo = nTavola;
		SELECT COUNT(*) INTO count FROM partecipa WHERE idTavolata = NEW.idTavolata;
		IF(count >= limitePersone)THEN
			--Eliminazione dei riferimenti esistenti in ecesso
			DELETE FROM partecipa WHERE idTavolata = NEW.idTavolata;
			DELETE FROM tavolatata WHERE idTavolata = NEW.idTavolata;
			RETURN NULL;
		END IF;
	RETURN NEW;
    COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER controllaTavolo
BEFORE INSERT OR UPDATE
ON partecipa
FOR EACH ROW
EXECUTE PROCEDURE controllaTavolo();


--Trigger che controlla che non ci siano più tavoli di quelli che una sala può gestire
CREATE OR REPLACE FUNCTION controllaSala()
    RETURNS TRIGGER
AS $$
DECLARE
	count integer;
	limiteTavolo integer;
	numSala integer;
    BEGIN
		SELECT totTavoli INTO count FROM sala WHERE codiceSala = NEW.codiceSala;
		UPDATE sala
		SET totTavoli = count + 1
		WHERE codiceSala = NEW.codiceSala;
		RETURN NEW; 
	COMMIT;
END;

$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER controllaSala
BEFORE INSERT OR UPDATE
ON tavola
FOR EACH ROW
EXECUTE PROCEDURE controllaSala();

--Trigger che controlla l'eliminazione di un tavolo e aggiorna i valori in sala
CREATE OR REPLACE FUNCTION rimozioneTavoloSala()
    RETURNS TRIGGER
AS $$
DECLARE
	count integer;
    BEGIN
		SELECT COUNT(*) INTO count FROM tavola WHERE codiceSala = OLD.codiceSala;
		UPDATE sala
		SET totTavoli = count
		WHERE codicesala = OLD.codiceSala;
		RETURN OLD;
	COMMIT;
END;

$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER rimozioneTavoloSala
AFTER DELETE
ON tavola
FOR EACH ROW
EXECUTE PROCEDURE rimozioneTavoloSala();

--Trigger che controlla che non ci sia la stessa persona 2 volte allo stesso tavoli
CREATE OR REPLACE FUNCTION controlloPresenza()
    RETURNS TRIGGER
AS $$
DECLARE
    BEGIN
		IF EXISTS (SELECT 1 FROM partecipa WHERE numeroCartaIdentita = NEW.numeroCartaIdentita AND idTavolata = NEW.idTavolata)THEN
			RETURN NULL;
		END IF;
		RETURN NEW;
	COMMIT;
END;

$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER controlloPresenza
BEFORE INSERT OR UPDATE
ON partecipa
FOR EACH ROW
EXECUTE PROCEDURE controlloPresenza();