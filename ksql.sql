# Create a stream called `finnhub`
CREATE STREAM FINNHUB (SYMBOL STRING, PRICE DOUBLE) WITH (KAFKA_TOPIC='finnhub', KEY_FORMAT='KAFKA', PARTITIONS=2, VALUE_FORMAT='JSON');

# Create a table called `finnhub_avg_price`
CREATE TABLE finnhub_avg_price AS
SELECT symbol, AVG(price) AS avg_price FROM finnhub GROUP BY symbol EMIT CHANGES;

# Create a table called `finnhub_transactions`
CREATE TABLE finnhub_transactions AS
SELECT symbol, COUNT(*) AS num_transactions FROM finnhub GROUP BY symbol EMIT CHANGES;

# Create a table called 'finnhub_min_price'
CREATE TABLE finnhub_min_price AS
SELECT symbol, MIN(price) AS min_price FROM finnhub GROUP BY symbol emit changes;


# Create a table called `finnhub_max_price`
CREATE TABLE finnhub_max_price AS
SELECT symbol, MAX(price) AS max_price FROM finnhub GROUP BY symbol emit changes;


* ¿Cuál fue el promedio ponderado de precio de una unidad por cada uno de los símbolos procesados? (por ejemplo, AAPL)
SELECT symbol, avg_price FROM finnhub_avg_price;

* ¿Cuántas transacciones se procesaron por símbolo?
SELECT symbol, num_transactions FROM finnhub_transactions;

* ¿Cuál fue el precio máximo registrado por símbolo?
SELECT symbol, max_price FROM finnhub_max_price;

* ¿Cuál fue el precio mínimo registrado por símbolo?
SELECT symbol, min_price FROM finnhub_min_price;