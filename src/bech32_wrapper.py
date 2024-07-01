# Import your bech32 library functions
from bech32 import encode as bech32_encode
from bech32 import decode as bech32_decode

def encode_bech32(hrp, witver, witprog):
    """Encode a segwit address using Bech32."""
    return bech32_encode(hrp, witver, witprog)

def decode_bech32(bech):
    """Decode a Bech32 segwit address."""
    return bech32_decode(bech)
