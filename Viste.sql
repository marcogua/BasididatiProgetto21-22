CREATE OR REPLACE VIEW AvventoriMensili AS
    SELECT COUNT(idtavolata),date_part('month', dataarrivo) AS Mese, ristorante.p_iva AS Ristorante
    FROM (((tavolata INNER JOIN tavola 
		  	ON numerotavolata = numerotavola) INNER JOIN sala 
                ON tavola.codicesala = sala.codicesala) INNER JOIN Ristorante
                    ON sala.p_iva = ristorante.p_iva)
    GROUP BY date_part('month', dataarrivo), ristorante.p_iva; 
	

CREATE OR REPLACE VIEW AvventoriGiornalieri AS
    SELECT COUNT(idtavolata),date_part('day', dataarrivo) AS Giorno, ristorante.p_iva AS Ristorante
    FROM (((tavolata INNER JOIN tavola 
		  	ON numerotavolata = numerotavola) INNER JOIN sala 
                ON tavola.codicesala = sala.codicesala) INNER JOIN Ristorante
                    ON sala.p_iva = ristorante.p_iva)
    GROUP BY date_part('day', dataarrivo), ristorante.p_iva; 


CREATE OR REPLACE VIEW Totale_persone_per_ristorante AS
SELECT ristorante.nome, ristorante.p_iva, SUM(foo2.sommapersala) AS totale_per_ristorante, foo2.data_arrivo AS mese
FROM ristorante INNER JOIN (SELECT SUM(foo.numeropertavolo) AS sommapersala, sala.codicesala, sala.p_iva, foo.data_arrivo AS data_arrivo
							FROM sala INNER JOIN (SELECT partecipa.idtavolata, COUNT(partecipa.idtavolata) AS numeropertavolo, tavola.codicesala, tavolata.dataarrivo AS data_arrivo
									FROM (tavola INNER JOIN tavolata
	 									ON tavola.numerotavola = tavolata.numerotavolata) INNER JOIN partecipa
										ON tavolata.idtavolata = partecipa.idtavolata
									GROUP BY partecipa.idtavolata,tavola.codicesala, tavolata.dataarrivo) AS foo
								ON sala.codicesala = foo.codicesala
							GROUP BY sala.codicesala, sala.p_iva, foo.data_arrivo) AS foo2
		ON ristorante.p_iva = foo2.p_iva
GROUP BY ristorante.p_iva, foo2.data_arrivo;

CREATE OR REPLACE VIEW Totale_persone_per_ristorante_mese AS
SELECT ristorante.nome, ristorante.p_iva, SUM(foo2.sommapersala) AS totale_per_ristorante, foo2.data_arrivo AS mese
FROM ristorante INNER JOIN (SELECT SUM(foo.numeropertavolo) AS sommapersala, sala.codicesala, sala.p_iva, foo.data_arrivo AS data_arrivo
							FROM sala INNER JOIN (SELECT partecipa.idtavolata, COUNT(partecipa.idtavolata) AS numeropertavolo, tavola.codicesala, date_part('month',tavolata.dataarrivo) AS data_arrivo
									FROM (tavola INNER JOIN tavolata
	 									ON tavola.numerotavola = tavolata.numerotavolata) INNER JOIN partecipa
										ON tavolata.idtavolata = partecipa.idtavolata
									GROUP BY partecipa.idtavolata,tavola.codicesala, date_part('month',tavolata.dataarrivo)) AS foo
								ON sala.codicesala = foo.codicesala
							GROUP BY sala.codicesala, sala.p_iva, foo.data_arrivo) AS foo2
		ON ristorante.p_iva = foo2.p_iva
GROUP BY ristorante.p_iva, foo2.data_arrivo;

CREATE OR REPLACE VIEW somma_tot_persone_posti_ristorante AS
SELECT ristorante.p_iva, SUM(foo.somma_persone_sale) AS somma_totale
FROM ristorante INNER JOIN (SELECT sala.codicesala, SUM(numeropersonemax) AS somma_persone_sale,sala.p_iva
							FROM tavola INNER JOIN sala
								ON sala.codicesala = tavola.codicesala
							GROUP BY sala.codicesala,sala.p_iva) AS foo
		ON ristorante.p_iva = foo.p_iva
GROUP BY ristorante.p_iva;

CREATE VIEW statistica AS
SELECT TP.nome, TP.mese, ST.somma_totale, CONCAT(ROUND((totale_per_ristorante*100)/ST.somma_totale,2),'%') AS Percentuale_avventori
FROM Totale_persone_per_ristorante AS TP INNER JOIN somma_tot_persone_posti_ristorante as ST
	ON TP.p_iva = ST.p_iva;

CREATE OR REPLACE VIEW statistica_mese AS
SELECT TP.nome, TP.mese, ST.somma_totale, CONCAT((ROUND((totale_per_ristorante*100)/ST.somma_totale/ (
	SELECT COUNT(*)
	FROM statistica
	WHERE statistica.nome = TP.nome AND date_part('month',statistica.mese) = TP.mese),2)),'%') AS Percentuale_avventori
FROM Totale_persone_per_ristorante_mese AS TP INNER JOIN somma_tot_persone_posti_ristorante as ST
	ON TP.p_iva = ST.p_iva;