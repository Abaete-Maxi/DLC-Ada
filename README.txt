Discreet Log Contract (DLC) Experiment in Ada
===================================================================
This project explores the implementation of a Discreet Log Contract (DLC) using the Ada programming language. The compiled program (DLC.exe) is currently available for mock usage.

Project Structure
Root Directory:
===================================================================
hashing.gpr: Project file to manage dependencies and compilation.

Source Directory (/src/):
===================================================================
bech32.c: C language implementation for Bech32 encoding. //

bech32.py: Python script for Bech32 encoding. //

bech32_wrapper.py: Python wrapper for interfacing Ada with bech32.py. //

main.adb: Main Ada program implementing the DLC functionality. //

setup.py: Python setup script for necessary environment configuration. //

Functionality Implemented
==================================================================
The current implementation focuses on transforming valid Bitcoin addresses into byte sequences, then into hexadecimal format, and finally into Bech32 for output. External helpers in Python and C are utilized for these transformations.

Key Features Implemented:
==================================================================
Bitcoin Address Validation: Accepts and validates Bitcoin addresses as input.
Data Transformation: Converts validated Bitcoin addresses into byte sequences, then into hexadecimal strings using Ada.
Bech32 Encoding: Converts hexadecimal strings into Bech32 format using external Python and C scripts.

Future Development
===================================================================
There are several planned enhancements and features to be implemented in future iterations of the project:

Blockchain Integration:

Real link to the Bitcoin blockchain for funds transfer and address validation.
Oracle Integration:

Integration with an Oracle to receive data from the NOSTR protocol, potentially leveraging AWS services for communication.
Enhanced Validation and Security:

Strengthen Bitcoin address validation and ensure robust security measures in data handling.

Getting Started
===============================================
To compile and run the current mock version of the DLC experiment:

Clone this repository to your local machine.
Ensure hashing.gpr is placed in the root directory of your project.
Place all files from /src/ (including bech32.c, bech32.py, bech32_wrapper.py, main.adb, and setup.py) inside the /src/ directory of your project.
run gprbuild -d -p<path/to/hashing.gpr>
or
gprbuild -d -p<path/to/hashing.gpr> -o <path/to/main.exe> ( to compile the executable into another directory )
Contributing
Contributions to enhance and expand the functionality of this experiment are welcome. Please fork the repository, make your changes, and submit a pull request.

License
===============================================
This project is licensed under the MIT License. see the [LICENSE](LICENSE) file for details.
 
Acknowledgments
===============================================
The Ada programming language community for their support and resources.
Contributors to Bitcoin-related libraries and tools used in this project.
