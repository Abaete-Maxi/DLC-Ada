with Ada.Text_IO;             use Ada.Text_IO;
with GNAT.SHA256;             use GNAT.SHA256;
with Interfaces;              use Interfaces;
with Ada.Streams;             use Ada.Streams;
with Ada.Strings.Unbounded;   use Ada.Strings.Unbounded;
with Ada.Calendar;            use Ada.Calendar;
with Ada.Calendar.Formatting; use Ada.Calendar.Formatting;
with Ada.Command_Line;
with Ada.Integer_Text_IO;     use Ada.Integer_Text_IO;
with Ada.Strings.Fixed;       use Ada.Strings.Fixed;
with GNAT.IO;
with GNAT.OS_Lib;             use GNAT.OS_Lib;
with Fetch_Bitcoin_Info;      use Fetch_Bitcoin_Info;
with Fetch_Nostr_Info;        use Fetch_Nostr_Info;
with Bitcoin;                 use Bitcoin;

--------------------------------------------------------------------------------
--END OF IMPORTS--
--------------------------------------------------------------------------------

procedure Main is
---------------------------MAIN TYPES/SUBTYPES-------------------------------
   type Byte_Seq is array (Positive range <>) of Interfaces.Unsigned_8;
   subtype Stream_Offset is Ada.Streams.Stream_Element_Offset;

-------------------------------PARTICIPANT-----------------------------------
   type Participant is record
      Name    : Unbounded_String;
      Pub_Key : Byte_Seq (1 .. 42);
      Balance : SATs := 0;
   end record;

   Name1, Name2 : Participant;
-------------------------------CONTRACT--------------------------------------
   type Contract is record
      Multi_Sig_PK : Byte_Seq (1 .. 32);  -- SHA-256 hash length
      Amount1      : SATs    := 0;
      Amount2      : SATs    := 0;
      Released     : Boolean := False;
   end record;

   Multi_Sig_Contract : Contract;

--------------------------------ORACLE---------------------------------------
   type Oracle is tagged record
      Name : Unbounded_String;
   end record;

   procedure Make_Decision (O : Oracle; C : in out Contract) is
   begin
      C.Released := True;
   end Make_Decision;

   Orac : Oracle;
-------------------------BTC ADDRESS TO BYTES--------------------------------
   function Bitcoin_Address_To_Bytes (Address : String) return Byte_Seq is
      Result : Byte_Seq (1 .. Address'Length);
   begin
      for I in Result'Range loop
         Result (I) := Interfaces.Unsigned_8 (Character'Pos (Address (I)));
      end loop;
      return Result;
   end Bitcoin_Address_To_Bytes;
---------------------------STRING TO BYTE SEQ--------------------------------
   function String_To_Byte_Seq (Str : String) return Byte_Seq is
      Result : Byte_Seq (1 .. Str'Length);
   begin
      for I in Result'Range loop
         Result (I) := Interfaces.Unsigned_8 (Character'Pos (Str (I)));
      end loop;
      return Result;
   end String_To_Byte_Seq;
---------------------------TO HEX--------------------------------------------
   function To_Hex (B : Interfaces.Unsigned_8) return String is
      Hex_Characters : constant String := "0123456789ABCDEF";
   begin
      return
        Hex_Characters (1 + Integer (B) / 16) &
        Hex_Characters (1 + Integer (B) mod 16);
   end To_Hex;
--------------------BYTE SEQ TO HEX STRING-----------------------------------
   function Byte_Seq_To_Hex_String (Bytes : Byte_Seq) return String is
      Result : String (1 .. Bytes'Length * 2);
   begin
      for I in Bytes'Range loop
         Result (2 * (I - 1) + 1 .. 2 * (I - 1) + 2) := To_Hex (Bytes (I));
      end loop;
      return Result;
   end Byte_Seq_To_Hex_String;

----------------------------HASH BYTE SEQ------------------------------------
   function Hash_Byte_Seq (Input : Byte_Seq) return Byte_Seq is
      Context      : GNAT.SHA256.Context := GNAT.SHA256.Initial_Context;
      Hashed       : GNAT.SHA256.Binary_Message_Digest;
      Input_Stream : Ada.Streams.Stream_Element_Array (1 .. Input'Length);
   begin
      for I in Input'Range loop
         Input_Stream (Stream_Offset (I)) :=
           Ada.Streams.Stream_Element (Input (I));
      end loop;

      GNAT.SHA256.Update (Context, Input_Stream);
      Hashed := GNAT.SHA256.Digest (Context);

      declare
         Result : Byte_Seq (1 .. Hashed'Length);
      begin
         for J in Result'Range loop
            Result (J) := Interfaces.Unsigned_8 (Hashed (Stream_Offset (J)));
         end loop;
         return Result;
      end;
   end Hash_Byte_Seq;
------------------------------BECH32-----------------------------------------
   procedure Encode_Bech32
     (HRP : String; Witver : Integer; Witprog : String; Result : out String);
   pragma Import (C, Encode_Bech32, "encode_bech32");

   procedure Decode_Bech32
     (Bech : String; Decoded_HRP : out String; Decoded_Witver : out Integer;
      Decoded_Witprog : out String);
   pragma Import (C, Decode_Bech32, "decode_bech32");

   procedure Encode_Bech32_Address
     (HRP : String; Witver : Integer; Witprog : String; Result : out String)
   is
      Python_HRP     : String (1 .. 100);
      Python_Witprog : String (1 .. 100);
   begin
      Python_HRP     := HRP;
      Python_Witprog := Witprog;
      Encode_Bech32 (Python_HRP, Witver, Python_Witprog, Result);
   end Encode_Bech32_Address;

   procedure Decode_Bech32_Address
     (Bech : String; Decoded_HRP : out String; Decoded_Witver : out Integer;
      Decoded_Witprog : out String)
   is
      Python_Bech            : String (1 .. 100);
      Python_Decoded_HRP     : String (1 .. 100);
      Python_Decoded_Witver  : Integer;
      Python_Decoded_Witprog : String (1 .. 100);
   begin
      Python_Bech := Bech;
      Decode_Bech32
        (Python_Bech, Python_Decoded_HRP, Python_Decoded_Witver,
         Python_Decoded_Witprog);
      Decoded_HRP     := Python_Decoded_HRP;
      Decoded_Witver  := Python_Decoded_Witver;
      Decoded_Witprog := Python_Decoded_Witprog;
   end Decode_Bech32_Address;
-----------------------------CREATE MULTISIG---------------------------------
   procedure Create_Multi_Sig_Contract
     (Name1, Name2     : Ada.Strings.Unbounded.Unbounded_String;
      PubKey1, PubKey2 : Byte_Seq; Multi_Sig_PK : out Byte_Seq)
   is
      -- Convert Unbounded_String to String
      Str1 : constant String := Ada.Strings.Unbounded.To_String (Name1);
      Str2 : constant String := Ada.Strings.Unbounded.To_String (Name2);

      -- Calculate the required length for Combined array
      Combined_Length : constant Positive :=
        Str1'Length + PubKey1'Length + Str2'Length + PubKey2'Length;
      Combined        : Byte_Seq (1 .. Combined_Length);
      Hashed_Combined : Ada.Streams.Stream_Element_Array
        (1 .. GNAT.SHA256.Hash_Length);
      Bech32_Result : String (1 .. 42);  -- Adjust size as needed

      function Hash_Byte_Seq (Input : Byte_Seq) return Byte_Seq is
         Context      : GNAT.SHA256.Context := GNAT.SHA256.Initial_Context;
         Hashed       : GNAT.SHA256.Binary_Message_Digest;
         Input_Stream : Ada.Streams.Stream_Element_Array (1 .. Input'Length);
      begin
         for I in Input'Range loop
            Input_Stream (Stream_Offset (I)) :=
              Ada.Streams.Stream_Element (Input (I));
         end loop;

         GNAT.SHA256.Update (Context, Input_Stream);
         Hashed := GNAT.SHA256.Digest (Context);

         declare
            Result : Byte_Seq (1 .. Hashed'Length);
         begin
            for J in Result'Range loop
               Result (J) :=
                 Interfaces.Unsigned_8 (Hashed (Stream_Offset (J)));
            end loop;
            return Result;
         end;
      end Hash_Byte_Seq;

   begin
      -- Populate Combined with data
      declare
         Offset : Positive := 1;
      begin
         -- Copy Name1
         for I in Str1'Range loop
            Combined (Offset) :=
              Interfaces.Unsigned_8 (Character'Pos (Str1 (I)));
            Offset := Offset + 1;
         end loop;

         -- Copy PubKey1
         for I in PubKey1'Range loop
            Combined (Offset) := PubKey1 (I);
            Offset            := Offset + 1;
         end loop;

         -- Copy Name2
         for I in Str2'Range loop
            Combined (Offset) :=
              Interfaces.Unsigned_8 (Character'Pos (Str2 (I)));
            Offset := Offset + 1;
         end loop;

         -- Copy PubKey2
         for I in PubKey2'Range loop
            Combined (Offset) := PubKey2 (I);
            Offset            := Offset + 1;
         end loop;
      end;

      -- Calculate SHA-256 hash
      declare
         Context      : GNAT.SHA256.Context := GNAT.SHA256.Initial_Context;
         Input_Stream : Ada.Streams.Stream_Element_Array
           (1 .. Combined'Length);
      begin
         for I in Combined'Range loop
            Input_Stream (Stream_Offset (I)) :=
              Ada.Streams.Stream_Element (Combined (I));
         end loop;

         GNAT.SHA256.Update (Context, Input_Stream);
         Hashed_Combined := GNAT.SHA256.Digest (Context);
      end;

      -- Convert the hashed result to Byte_Seq
      declare
         Hashed_Byte_Seq : Byte_Seq (1 .. Hashed_Combined'Length);
      begin
         for J in Hashed_Byte_Seq'Range loop
            Hashed_Byte_Seq (J) :=
              Interfaces.Unsigned_8 (Hashed_Combined (Stream_Offset (J)));
         end loop;

         -- Convert the hashed result to Bech32 format
         declare
            Hashed_Hex : String := Byte_Seq_To_Hex_String (Hashed_Byte_Seq);
         begin
            Encode_Bech32 ("bc", 1, Hashed_Hex, Bech32_Result);
            Put_Line ("" & Bech32_Result);
         end;

         -- Assign the result to Multi_Sig_PK
         Multi_Sig_PK := Hashed_Byte_Seq;
      end;

   end Create_Multi_Sig_Contract;

----------------------------CALENDAR-----------------------------------------
   procedure Display_Current_Time is
      Now : Time := Clock;
   begin
      Put_Line ("Current Time (UTC): " & Image (Now));
   end Display_Current_Time;
----------------------------GET BITCOIN INFO---------------------------------
   procedure Get_Bitcoin_Info is
      Bitcoin_Price : Integer;
      Block_Height  : Integer;
   begin
      begin
         Fetch_Bitcoin_Info.Fetch_Bitcoin_Info (Bitcoin_Price, Block_Height);
      exception
         when others =>
            Put_Line ("Error in Get_Bitcoin_Info: Unexpected exception.");
      end;
   end Get_Bitcoin_Info;

---------------------------GET ORACLE DECISION-------------------------------
   procedure Get_Oracle_Decision is
      Decision : Unbounded_String;
   begin
      Fetch_Nostr_Info.Fetch_Oracle_Decision (Decision);
      Put_Line ("Oracle Decision: " & To_String (Decision));
   end Get_Oracle_Decision;

---------------------------GET PARTICIPANT DETAILS---------------------------
   procedure Get_Participant_Details
     (Name : out Unbounded_String; Pub_Key : out Byte_Seq; Amount : out SATs)
   is
      Input_Name   : String (1 .. 100);
      Last_Name    : Natural;
      Input_PubKey : String (1 .. 66);
      Last_PubKey  : Natural;
      Input_Amount : String (1 .. 999);
      Last_Amount  : Natural;
      BTC_Amount   : Float;
   begin
      Put_Line ("Enter participant's name:");
      Get_Line (File => Standard_Input, Item => Input_Name, Last => Last_Name);
      Name := To_Unbounded_String (Input_Name (1 .. Last_Name));

      Put_Line ("Enter Public Key for the participant:");
      Get_Line
        (File => Standard_Input, Item => Input_PubKey, Last => Last_PubKey);
      if Last_PubKey > 0 and then Last_PubKey <= 66 then
         Pub_Key := Bitcoin_Address_To_Bytes (Input_PubKey (1 .. Last_PubKey));
      else
         raise Constraint_Error with "Invalid public key length";
      end if;

      Put_Line ("Enter Amount (in BTC or SATs):");
      Get_Line
        (File => Standard_Input, Item => Input_Amount, Last => Last_Amount);

      -- Check if the input can be converted to Float
      begin
         BTC_Amount := Float'Value (Input_Amount (1 .. Last_Amount));
         -- Convert BTC amount to SATs
         Amount := Bitcoin.To_SATs (BTC_Amount);
      exception
         when Constraint_Error | Data_Error =>
            -- If conversion to Float fails, assume it's in SATs already
            Amount := SATs'Value (Input_Amount (1 .. Last_Amount));
      end;
   end Get_Participant_Details;

--------------------------------DISPLAY CONTRACT DETAILS---------------------
   -- New procedure to display contract details
   -- Display contract details
   procedure Display_Contract_Details
     (Contract1 : in Contract; Name1, Name2 : in Unbounded_String)
   is
   begin
      Put_Line
        ("------------------------------------------------------------------");
      Put_Line ("Contract Details:");
      Put_Line
        ("Participants: " & To_String (Name1) & " and " & To_String (Name2));
      Put_Line
        ("Total Amount in Contract: " &
         SATs_To_BTC_String (Contract1.Amount1 + Contract1.Amount2) & " BTC");
      Put_Line
        ("MultiSig Public Key (Hex): " &
         Byte_Seq_To_Hex_String (Contract1.Multi_Sig_PK));
      Put_Line
        ("------------------------------------------------------------------");
   end Display_Contract_Details;
   --------------------------------------------------------------------------------
   --END OF FUNC/PROCED--
   --------------------------------------------------------------------------------
   --------------------------------------------------------------------------------
   --MAIN PROGRAM--
   --------------------------------------------------------------------------------
begin
   Put_Line
     ("------------------------------------------------------------------");
   Display_Current_Time;
   Put_Line
     ("------------------------------------------------------------------");
   Get_Bitcoin_Info;
   Put_Line
     ("------------------------------------------------------------------");

   Put_Line
     ("------------------------------------------------------------------");
   Put_Line ("Discreet Log Contract Example");
   Put_Line
     ("------------------------------------------------------------------");
   -- Get details for first participant
   Get_Participant_Details
     (Name1.Name, Name1.Pub_Key, Multi_Sig_Contract.Amount1);
   Put_Line
     ("------------------------------------------------------------------");
   Put_Line ("Participant 1 Name: " & To_String (Name1.Name));
   Put_Line
     ("Participant 1 Public Key(Hex): " &
      Byte_Seq_To_Hex_String (Name1.Pub_Key));
   Put_Line
     ("Amount entered for Participant 1: " &
      SATs_To_BTC_String (Multi_Sig_Contract.Amount1) & " BTC");
   Put_Line
     ("------------------------------------------------------------------");

   -- Get details for second participant
   Get_Participant_Details
     (Name2.Name, Name2.Pub_Key, Multi_Sig_Contract.Amount2);
   Put_Line
     ("------------------------------------------------------------------");
   Put_Line ("Participant 2 Name: " & To_String (Name2.Name));
   Put_Line
     ("Participant 2 Public Key(Hex): " &
      Byte_Seq_To_Hex_String (Name2.Pub_Key));
   Put_Line
     ("Amount entered for Participant 2: " &
      SATs_To_BTC_String (Multi_Sig_Contract.Amount2) & " BTC");
   Put_Line
     ("------------------------------------------------------------------");

   Put_Line ("Multisig Pubkey (Bech32)");
   Create_Multi_Sig_Contract
     (Name1.Name, Name2.Name, Name1.Pub_Key, Name2.Pub_Key,
      Multi_Sig_Contract.Multi_Sig_PK);

   Display_Contract_Details (Multi_Sig_Contract, Name1.Name, Name2.Name);

   Orac.Name := To_Unbounded_String ("Oracle");
   Make_Decision (Orac, Multi_Sig_Contract);
   Put_Line
     ("------------------------------------------------------------------");
   Get_Oracle_Decision;
   if Multi_Sig_Contract.Released then
      Put_Line
        ("------------------------------------------------------------------");
      Put_Line ("Funds released by the oracle.");
   else
      Put_Line ("Funds not released.");
   end if;

   if Multi_Sig_Contract.Released then
      Name1.Balance := Multi_Sig_Contract.Amount1 + Multi_Sig_Contract.Amount2;
      Name2.Balance := 0;
   end if;
   Put_Line
     ("------------------------------------------------------------------");
   Put_Line ("Final Balance:");
   New_Line;
   Put_Line
     (To_String (Name1.Name) & "'s Balance: " &
      SATs_To_BTC_String (Name1.Balance));
   Put_Line
     (To_String (Name2.Name) & "'s Balance: " &
      SATs_To_BTC_String (Name2.Balance));
   Put_Line
     ("------------------------------------------------------------------");
   Get_Bitcoin_Info;
   Put_Line
     ("------------------------------------------------------------------");
   Display_Current_Time;
   Put_Line
     ("------------------------------------------------------------------");
   Put_Line
     ("----------------------------END OF CONTRACT-----------------------------");

   loop
      exit when Ada.Text_IO.Get_Line'Last > 0;
   end loop;

end Main;
