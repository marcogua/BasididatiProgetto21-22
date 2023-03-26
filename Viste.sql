CREATE OR REPLACE VIEW AvventoriMensili AS
    SELECT COUNT(idtavolata),date_part('month', dataarrivo) AS Mese, ristorante.p_iva AS Ristorante
    FROM (((tavolata INNER JOIN tavola 
		  	ON numerotavolata = numerotavola) INNER JOIN sala 
                ON tavola.codicesala = sala.codicesala) INNER JOIN Ristorante
                    ON sala.p_iva = ristorante.p_iva)
    GROUP BY date_part('month', dataarrivo), ristorante.p_iva; 
	


CREATE OR REPLACE VIEW AvventoriGiornaliero AS
    SELECT COUNT(idtavolata),date_part('day', dataarrivo) AS Giorno, ristorante.p_iva AS Ristorante
    FROM (((tavolata INNER JOIN tavola 
		  	ON numerotavolata = numerotavola) INNER JOIN sala 
                ON tavola.codicesala = sala.codicesala) INNER JOIN Ristorante
                    ON sala.p_iva = ristorante.p_iva)
    GROUP BY date_part('day', dataarrivo), ristorante.p_iva;

