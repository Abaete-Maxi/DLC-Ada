try:
    from nostr.client.client import Client
    print("Nostr library is installed correctly.")
except ImportError as e:
    print("Error importing Nostr library:", e)
