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
			--Questa cosa l'ho messa ma non vuole funzionare
			RAISE NOTICE 'Data inserita non valida perchè gia passata';
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

--Trigger per l'inserimento di personale e avventore
CREATE OR REPLACE FUNCTION inserisciPersonaAvventore()
    RETURNS TRIGGER
AS $$
DECLARE
    BEGIN
	IF(NEW.numeroOpt IS NOT NULL)THEN
        	INSERT INTO personale VALUES (NEW.numeroOpt, 'Non ancora assegnato');
        	UPDATE persona SET numeroOpt = NEW.numeroOpt WHERE numeroCartaIdentita = NEW.numeroCartaIdentita;
		END IF;
        INSERT INTO avventore VALUES (NEW.numeroCartaIdentita);
	RETURN NEW;
    COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER InsertPersonaleAvventore
BEFORE INSERT
ON persona
FOR EACH ROW
EXECUTE PROCEDURE InsertPersonaAvventore();

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
		IF NOT EXISTS (SELECT 0 FROM partecipa WHERE (idtavolata = NEW.tavolata AND numerocartaidentita = NEW.numeropersona))THEN
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
		tavola = NEW.numeroTavolata;
		oraPrenotazioneTMP = NEW.orarioArrivo;
			IF EXISTS (SELECT 1 FROM tavolata WHERE orarioArrivo BETWEEN oraPrenotazioneTMP - interval '59 minutes' AND oraPrenotazioneTMP + interval '59 minutes' AND numerotavolata = tavola)THEN
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
		SELECT numeroTavolata into nTavola FROM tavolata WHERE idTavolata = NEW.idTavolata;
		SELECT numeroPersoneMax into limitePersone FROM tavola WHERE numeroTavola = nTavola;
		SELECT COUNT(*) INTO count FROM partecipa WHERE idtavolata = NEW.idTavolata;
		IF(count >= limitePersone)THEN
			DELETE FROM partecipa WHERE idtavolata = NEW.idTavolata;
			DELETE FROM tavolatata WHERE idtavolata = NEW.idTavolata;
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
		SELECT codicesala into numSala FROM tavola WHERE codicesala = NEW.codicesala;
		SELECT numerotavoli into limiteTavolo FROM sala WHERE codicesala = numSala;
		SELECT COUNT(*) INTO count FROM tavola WHERE codicesala = NEW.codicesala;
		IF(count >= limiteTavolo)THEN
			RETURN NULL;
		END IF;
	RETURN NEW;
    COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER controllaSala
BEFORE INSERT OR UPDATE
ON tavola
FOR EACH ROW
EXECUTE PROCEDURE controllaSala();