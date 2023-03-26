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
SELECT ristorante.nome, ristorante.p_iva, SUM(foo2.sommapersala) AS totale_per_ristorante
FROM ristorante INNER JOIN (SELECT SUM(foo.numeropertavolo) AS sommapersala, sala.codicesala, sala.p_iva
							FROM sala INNER JOIN (SELECT partecipa.idtavolata, COUNT(partecipa.idtavolata) AS numeropertavolo, tavola.codicesala
									FROM (tavola INNER JOIN tavolata
	 									ON tavola.numerotavola = tavolata.numerotavolata) INNER JOIN partecipa
										ON tavolata.idtavolata = partecipa.idtavolata
									GROUP BY partecipa.idtavolata,tavola.codicesala) AS foo
								ON sala.codicesala = foo.codicesala
							GROUP BY sala.codicesala, sala.p_iva) AS foo2
		ON ristorante.p_iva = foo2.p_iva
GROUP BY ristorante.p_iva;

CREATE OR REPLACE VIEW somma_tot_persone_posti_ristorante AS
SELECT ristorante.p_iva, SUM(foo.somma_persone_sale)
FROM ristorante INNER JOIN (SELECT sala.codicesala, SUM(numeropersonemax) AS somma_persone_sale,sala.p_iva
							FROM tavola INNER JOIN sala
								ON sala.codicesala = tavola.codicesala
							GROUP BY sala.codicesala,sala.p_iva) AS foo
		ON ristorante.p_iva = foo.p_iva
GROUP BY ristorante.p_iva;