from kafka import KafkaProducer
from kafka.errors import KafkaError

import requests
import json
import websocket

# Configura el productor Kafka para conectarse a Redpanda
producer = KafkaProducer(
    bootstrap_servers='localhost:9092')

# Define los símbolos que deseas seguir
symbols = ["AAPL", "AMZN", "BINANCE:BTCUSDT"]

# URL de la API en tiempo real de Finnhub
url = "wss://ws.finnhub.io?token=TU_API_KEY"

# Función para manejar los mensajes de la API
def on_message(ws, message):
    data = json.loads(message)
    if "data" in data and "s" in data:
        if data["s"] in symbols:
            producer.send(data["s"], value=message)

# Suscríbete a los eventos de la API de Finnhub

ws = websocket.WebSocketApp(url, on_message=on_message)
ws.run_forever()