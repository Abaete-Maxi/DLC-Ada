from bitcoinrpc.authproxy import AuthServiceProxy, JSONRPCException

# Connect to Bitcoin Core RPC
rpc_user = "yourrpcuser"
rpc_password = "yourrpcpassword"
rpc_host = "127.0.0.1"
rpc_port = "8332"
rpc_url = f"http://{rpc_user}:{rpc_password}@{rpc_host}:{rpc_port}"
rpc_connection = AuthServiceProxy(rpc_url)

def get_new_address():
    return rpc_connection.getnewaddress()

def create_multisig(n_required, keys):
    return rpc_connection.createmultisig(n_required, keys)

def send_to_address(address, amount):
    return rpc_connection.sendtoaddress(address, amount)

if __name__ == "__main__":
    import sys
    command = sys.argv[1]

    if command == "get_new_address":
        print(get_new_address())

    elif command == "create_multisig":
        n_required = int(sys.argv[2])
        keys = sys.argv[3].split(',')
        print(create_multisig(n_required, keys))

    elif command == "send_to_address":
        address = sys.argv[2]
        amount = float(sys.argv[3])
        print(send_to_address(address, amount))
