Descrizione del caso studio:
Un negozio di cosmetici che vende prodotti come rossetti, crema per la pelle e degli ombretti. I clienti possono effewttuare ordini e lasciare recensioni sui prodotti.

Modello ER:
Entità:
Cliente (cliente_id, nome, mail)
Prodotto (prodotto_id, nome, marca, prezzo, data_rilascio)
Ordine (ordine_id, cliente_id, data_ordine)
DettaglioOrdine (dettaglio_id, ordine_id, prodotto_id, quantita)
Categoria (categoria_id, nome)
ProdottoCategoria (prodotto_id, categoria_id)
Recensione (recensione_id, prodotto_id, testo, voto, data_recensione)

Relazioni:
Cliente effettua ordine
Ordine contiene DettaglioOrdine
DettaglioOrdine si riferisce a Prodotto
Prodotto appartiene a Categoria
Prodotto appartiene a Recensione
