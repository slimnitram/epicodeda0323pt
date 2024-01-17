CREATE TABLE Cliente (
    cliente_id INT PRIMARY KEY,
    nome VARCHAR(50),
    email VARCHAR(100)
);

CREATE TABLE Prodotto (
    prodotto_id INT PRIMARY KEY,
    nome VARCHAR(50),
    marca VARCHAR(50),
    prezzo DECIMAL(10, 2),
    data_lancio DATE
);

CREATE TABLE Ordine (
    ordine_id INT PRIMARY KEY,
    cliente_id INT,
    data_ordine DATE,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id)
);

CREATE TABLE DettaglioOrdine (
    dettaglio_id INT PRIMARY KEY,
    ordine_id INT,
    prodotto_id INT,
    quantita INT,
    FOREIGN KEY (ordine_id) REFERENCES Ordine(ordine_id),
    FOREIGN KEY (prodotto_id) REFERENCES Prodotto(prodotto_id)
);

CREATE TABLE Categoria (
    categoria_id INT PRIMARY KEY,
    nome VARCHAR(50)
);

CREATE TABLE ProdottoCategoria (
    prodotto_id INT,
    categoria_id INT,
    PRIMARY KEY (prodotto_id, categoria_id),
    FOREIGN KEY (prodotto_id) REFERENCES Prodotto(prodotto_id),
    FOREIGN KEY (categoria_id) REFERENCES Categoria(categoria_id)
);

CREATE TABLE Recensione (
    recensione_id INT PRIMARY KEY,
    prodotto_id INT,
    testo TEXT,
    voto INT, -- Assumiamo un voto numerico da 1 a 5
    data_recensione DATE,
    FOREIGN KEY (prodotto_id) REFERENCES Prodotto(prodotto_id)
);

-- Inserimento di dati di esempio nelle tabelle

-- Clienti
INSERT INTO Cliente (cliente_id, nome, email)
VALUES
    (1, 'Alice Bianchi', 'alice@email.com'),
    (2, 'Roberto Verdi', 'roberto@email.com'),
    (3, 'Elena Rosso', 'elena@email.com');

-- Prodotti
INSERT INTO Prodotto (prodotto_id, nome, marca, prezzo, data_lancio)
VALUES
    (101, 'Rossetto Vibrante', 'GlamLips', 14.99, '2022-02-15'),
    (102, 'Crema Antietà', 'YouthfulSkin', 39.99, '2022-03-01'),
    (103, 'Ombretto Shimmer', 'EyeChic', 11.50, '2022-03-20');

-- Ordini
INSERT INTO Ordine (ordine_id, cliente_id, data_ordine)
VALUES
    (1001, 1, '2022-04-05'),
    (1002, 2, '2022-04-07'),
    (1003, 3, '2022-04-10');

-- Dettagli Ordine
INSERT INTO DettaglioOrdine (dettaglio_id, ordine_id, prodotto_id, quantita)
VALUES
    (2001, 1001, 101, 2),
    (2002, 1001, 102, 1),
    (2003, 1002, 103, 3);

-- Categorie
INSERT INTO Categoria (categoria_id, nome)
VALUES
    (501, 'Makeup Labbra'),
    (502, 'Skin Care'),
    (503, 'Makeup Occhi');

-- Associazioni tra Prodotti e Categorie
INSERT INTO ProdottoCategoria (prodotto_id, categoria_id)
VALUES
    (101, 501),
    (102, 502),
    (103, 503);

-- Recensioni
INSERT INTO Recensione (recensione_id, prodotto_id, testo, voto, data_recensione)
VALUES
    (301, 101, 'Colore fantastico!', 5, '2022-04-15'),
    (302, 102, 'Migliora la texture della pelle.', 4, '2022-04-10'),
    (303, 103, 'Effetto shimmer unico!', 4, '2022-04-08');
    
    select * from Cliente;
    
    select * from Prodotto ORDER BY nome;
    
    SELECT Categoria.nome, SUM(DettaglioOrdine.quantita) AS totale_vendite
   FROM Categoria
   LEFT JOIN ProdottoCategoria ON Categoria.categoria_id = ProdottoCategoria.categoria_id
   LEFT JOIN DettaglioOrdine ON ProdottoCategoria.prodotto_id = DettaglioOrdine.prodotto_id
   GROUP BY Categoria.nome;
   
   SELECT Ordine.ordine_id, Cliente.nome AS cliente, Prodotto.nome AS prodotto, DettaglioOrdine.quantita, Ordine.data_ordine
   FROM Ordine
   INNER JOIN Cliente ON Ordine.cliente_id = Cliente.cliente_id
   INNER JOIN DettaglioOrdine ON Ordine.ordine_id = DettaglioOrdine.ordine_id
   INNER JOIN Prodotto ON DettaglioOrdine.prodotto_id = Prodotto.prodotto_id
   ORDER BY Ordine.data_ordine DESC
   LIMIT 5;
   
    SELECT Prodotto.nome
   FROM Prodotto
   LEFT JOIN Recensione ON Prodotto.prodotto_id = Recensione.prodotto_id
   WHERE Recensione.recensione_id IS NULL;
   
    SELECT Prodotto.nome, AVG(Recensione.voto) AS media_voti
   FROM Prodotto
   LEFT JOIN Recensione ON Prodotto.prodotto_id = Recensione.prodotto_id
   GROUP BY Prodotto.nome;
   
   SELECT Cliente.nome, COUNT(Ordine.ordine_id) AS num_ordini
   FROM Cliente
   LEFT JOIN Ordine ON Cliente.cliente_id = Ordine.cliente_id
   GROUP BY Cliente.nome
   HAVING num_ordini >= 2;
   
     SELECT Cliente.nome, SUM(DettaglioOrdine.quantita * Prodotto.prezzo) AS totale_speso
   FROM Cliente
   LEFT JOIN Ordine ON Cliente.cliente_id = Ordine.cliente_id
   LEFT JOIN DettaglioOrdine ON Ordine.ordine_id = DettaglioOrdine.ordine_id
   LEFT JOIN Prodotto ON DettaglioOrdine.prodotto_id = Prodotto.prodotto_id
   GROUP BY Cliente.nome;
   
     SELECT Prodotto.nome, COUNT(Recensione.recensione_id) AS num_recensioni, AVG(Recensione.voto) AS media_voti
   FROM Prodotto
   LEFT JOIN Recensione ON Prodotto.prodotto_id = Recensione.prodotto_id
   GROUP BY Prodotto.nome
   HAVING num_recensioni >= 3 AND media_voti > 4;
   
     SELECT Categoria.nome, COUNT(ProdottoCategoria.prodotto_id) AS num_prodotti
   FROM Categoria
   LEFT JOIN ProdottoCategoria ON Categoria.categoria_id = ProdottoCategoria.categoria_id
   GROUP BY Categoria.nome;
    
