import requests
import sys

def get_oracle_decision(npub):
    relay = "https://nostr.stakey.net"
    url = f"{relay}/api/v1/events"
    params = {
        "pubkey": npub,
        "kinds": [1],  # Assuming kind 1 is used for text notes
    }

    try:
        response = requests.get(url, params=params)
        response.raise_for_status()  # Raise an exception for HTTP errors
        events = response.json()

        if not events:
            return "No decision found"

        # Assuming the decision is in the latest event's content
        latest_event = events[-1]
        return latest_event.get('content', 'No content in the latest event')
    except requests.exceptions.RequestException as e:
        return f"Error fetching from Nostr: {e}"
    except ValueError as e:
        return f"Error parsing JSON: {e}"

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: nostr_integration.py <npub>")
        sys.exit(1)

    npub = sys.argv[1]
    print(f"Fetching oracle decision for npub: {npub}")
    decision = get_oracle_decision(npub)
    print(f"Decision: {decision}")
