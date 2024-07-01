# bitcoin_info.py
import requests
from datetime import datetime, timezone

def get_bitcoin_info():
    # Get Bitcoin price in USD
    price_url = 'https://api.coingecko.com/api/v3/simple/price'
    price_params = {
        'ids': 'bitcoin',
        'vs_currencies': 'usd'
    }
    price_response = requests.get(price_url, params=price_params)
    bitcoin_price = None
    if price_response.status_code == 200:
        price_data = price_response.json()
        bitcoin_price = price_data['bitcoin']['usd']

    # Get Bitcoin block height
    block_height_url = 'https://api.blockcypher.com/v1/btc/main'
    block_height_response = requests.get(block_height_url)
    block_height = None
    if block_height_response.status_code == 200:
        block_data = block_height_response.json()
        block_height = block_data['height']

    return bitcoin_price, block_height

if __name__ == "__main__":
    price, height = get_bitcoin_info()
    if price is not None and height is not None:
        print(f"Bitcoin Price (USD): {price}")
        print(f"Block Height: {height}")
    else:
        print("Error: Unable to retrieve Bitcoin information.")