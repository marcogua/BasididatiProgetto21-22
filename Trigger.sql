CREATE OR REPLACE FUNCTION nomeFunzione()
    RETURNS TRIGGER
AS $alias_che_vuoi$
DECLARE
    --Dichiarazioni di variabili
BEGIN 
    --Trigger logic
END;
$alias_che_vuoi$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER nomeTrigger
BEFORE INSERT --{BEFORE | AFTER} {Evento} EVENTO: {INSERT | UPDATE | DELETE | TRUNCATE}
ON nomeTabella
FOR EACH ROW --[FOR [EACH] {ROW | STATEMENT}]
EXECUTE PROCEDURE nomeFunzione();