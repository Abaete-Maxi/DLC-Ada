This is an experiment on Ada Programming Language in an attempt to create a Discreet Log Contract (DLC).
The compiled program (DLC.exe) is ready for use (mock).
hashing.gpr must be placed in the root directory of your project.
bech32.c , bech32.py , bech32_wrapper.py , main.adb and setup.py must be placed inside /src/.

I tried to set it so it only accepts valid Bitcoin Addresses, transform them to Byte_seq, then Hex, then Bech32 for output using python and C as external helpers.
There is still much left to do, implementing real link to the blockchain ( funds transfer and address validation ) and also set Oracle to receive data from NOSTR 
Protocol, maybe via AWS.

Thank you. 

Abaete
