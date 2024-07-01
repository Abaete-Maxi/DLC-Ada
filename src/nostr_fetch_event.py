import requests
import sys

def fetch_nostr_event(event_id):
    url = f"https://nostr.stakey.net/api/v1/event/nevent1qqst4kp7cnp6phprdtjfukgmdg4saslvq0mxkz8857yzctpe5x6czfsp86lsy"  # Replace with the actual Nostr API URL
    try:
        response = requests.get(url)
        response.raise_for_status()
        data = response.json()
        return data['content']  # Adjust according to the actual response structure
    except requests.exceptions.RequestException as e:
        return f"Error fetching from Nostr: {e}"
    except KeyError:
        return "Error: Invalid event data"

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: nostr_fetch_event.py <event_id>")
        sys.exit(1)

    event_id = sys.argv[1]
    print(f"Fetching Nostr event for ID: {event_id}")
    event_content = fetch_nostr_event(event_id)
    print(f"Event Content: {event_content}")
