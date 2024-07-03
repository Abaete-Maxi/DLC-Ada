# get_bitcoin_price.py
import requests

def fetch_bitcoin_price():
    url = "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd"
    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        return data['bitcoin']['usd']
    else:
        return None

if __name__ == "__main__":
    price = fetch_bitcoin_price()
    if price:
        print(price, end='')  # Print without newline
    else:
        print("Error: Unable to fetch Bitcoin price.")
