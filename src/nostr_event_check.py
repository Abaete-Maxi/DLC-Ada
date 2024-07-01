import requests
import sys

def get_event_content(event_id):
    url = f"https://nostr.stakey.net/api/v1/event/nevent1qqst4kp7cnp6phprdtjfukgmdg4saslvq0mxkz8857yzctpe5x6czfsp86lsy"

    try:
        response = requests.get(url)
        response.raise_for_status()
        event_data = response.json()

        if 'content' not in event_data:
            return "No content found in the event"
        
        return event_data['content']
    except requests.exceptions.RequestException as e:
        return f"Error fetching event: {e}"

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: nostr_event_check.py <event_id>")
        sys.exit(1)

    event_id = sys.argv[1]
    print(f"Fetching event content for event_id: {event_id}")
    content = get_event_content(event_id)
    print(f"Event content: {content}")
