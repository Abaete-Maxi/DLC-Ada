with Ada.Text_IO;           use Ada.Text_IO;
with GNAT.SHA256;           use GNAT.SHA256;
with Interfaces;            use Interfaces;
with Ada.Streams;           use Ada.Streams;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
--------------------------------------------------------------------------------
--END OF IMPORTS--
--------------------------------------------------------------------------------
procedure Main is
---------------------------MAIN TYPES/SUBTYPES----------------------------------
   type Byte_Seq is array (Positive range <>) of Interfaces.Unsigned_8;
   subtype Stream_Offset is Ada.Streams.Stream_Element_Offset;

   subtype BTC_Float is Standard.Float;
-------------------------BTC ADDRESS TO BYTES-----------------------------------
   function Bitcoin_Address_To_Bytes (Address : String) return Byte_Seq is
      Result : Byte_Seq (1 .. Address'Length);
   begin
      for I in Result'Range loop
         Result (I) := Interfaces.Unsigned_8 (Character'Pos (Address (I)));
      end loop;
      return Result;
   end Bitcoin_Address_To_Bytes;
---------------------------STRING TO BYTE SE------------------------------------
   function String_To_Byte_Seq (Str : String) return Byte_Seq is
      Result : Byte_Seq (1 .. Str'Length);
   begin
      for I in Result'Range loop
         Result (I) := Interfaces.Unsigned_8 (Character'Pos (Str (I)));
      end loop;
      return Result;
   end String_To_Byte_Seq;
---------------------------TO HEX-----------------------------------------------
   function To_Hex (B : Interfaces.Unsigned_8) return String is
      Hex_Characters : constant String := "0123456789ABCDEF";
   begin
      return
        Hex_Characters (1 + Integer (B) / 16) &
        Hex_Characters (1 + Integer (B) mod 16);
   end To_Hex;
--------------------BYTE SEQ TO HEX STRING--------------------------------------
   function Byte_Seq_To_Hex_String (Bytes : Byte_Seq) return String is
      Result : String (1 .. Bytes'Length * 2);
   begin
      for I in Bytes'Range loop
         Result (2 * (I - 1) + 1 .. 2 * (I - 1) + 2) := To_Hex (Bytes (I));
      end loop;
      return Result;
   end Byte_Seq_To_Hex_String;
----------------------------HASH BYTE SEQ---------------------------------------
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
------------------------------BECH32--------------------------------------------
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
-----------------------------CREATE MULTISIG------------------------------------
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
            Put_Line ("Bech32 Address: " & Bech32_Result);
         end;

         -- Assign the result to Multi_Sig_PK
         Multi_Sig_PK := Hashed_Byte_Seq;
      end;

   end Create_Multi_Sig_Contract;
-------------------------------PARTICIPANT--------------------------------------
   type Participant is record
      Name    : Unbounded_String;
      Pub_Key : Byte_Seq (1 .. 42);
      Balance : BTC_Float := 0.000_000_00;
   end record;

   Name1, Name2 : Participant;
-------------------------------CONTRACT-----------------------------------------
   type Contract is record
      Multi_Sig_PK : Byte_Seq (1 .. 32);  -- SHA-256 hash length
      Amount       : BTC_Float := 0.000_000_00;
      Released     : Boolean   := False;
   end record;

   Multi_Sig_Contract : Contract;
--------------------------------ORACLE------------------------------------------
   type Oracle is tagged record
      Name : Unbounded_String;
   end record;

   procedure Make_Decision (O : Oracle; C : in out Contract) is
   begin
      C.Released := True;
   end Make_Decision;

   Orac : Oracle;
-----------------------------FLOAT TO STRING------------------------------------
   function BTC_Float_To_String (Value : Standard.Float) return String is
      Temp   : constant String := Float'Image (Value);
      Result : String (1 .. 64);

      Decimals_To_Keep : constant Natural := 8;
      Leading_Zeros    : constant Natural := 10;

      Non_Zero_Pos : Natural := Temp'First;
      Decimal_Pos  : Natural := Temp'First;
      Output_Pos   : Natural := Result'First;

   begin
      while Decimal_Pos <= Temp'Last loop
         exit when Temp (Decimal_Pos) = '.';
         Decimal_Pos := Decimal_Pos + 1;
      end loop;

      if Decimal_Pos > Temp'Last then
         return Temp;
      end if;

      for I in Temp'First .. Decimal_Pos + Leading_Zeros loop
         if I <= Temp'Last then
            Result (Output_Pos) := Temp (I);
            if Temp (I) = 'E' then
               Output_Pos := Output_Pos - 1;
               exit;
            end if;
         else
            Result (Output_Pos) := '0';
         end if;
         Output_Pos := Output_Pos + 1;
      end loop;

      if Output_Pos - Decimal_Pos <= Decimals_To_Keep then
         for J in 1 .. Decimals_To_Keep - (Output_Pos - Decimal_Pos) loop
            Result (Output_Pos) := '0';
            Output_Pos          := Output_Pos + 1;
         end loop;
      end if;

      return Result (Result'First .. Output_Pos - 1);
   end BTC_Float_To_String;
--------------------------------------------------------------------------------
   --END OF FUNC/PROCED--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
   --MAIN PROGRAM--
--------------------------------------------------------------------------------
begin
   Put_Line
     ("------------------------------------------------------------------");
   Put_Line ("Discreet Log Contract Example");
   Put_Line
     ("------------------------------------------------------------------");
   Put_Line ("Enter Name:");
   declare
      Input_Name : String (1 .. 100);
      Last_Name  : Natural;
   begin
      Get_Line (File => Standard_Input, Item => Input_Name, Last => Last_Name);
      Name1.Name := To_Unbounded_String (Input_Name (1 .. Last_Name));
      Put_Line
        ("------------------------------------------------------------------");
      Put_Line ("Participant 1 Name: " & To_String (Name1.Name));
      Put_Line
        ("------------------------------------------------------------------");
   end;

   Put_Line ("Enter Public Key (hex) for participant 1:");
   declare
      Input_PubKey : String (1 .. 66);
      Last_PubKey  : Natural;
   begin
      Get_Line
        (File => Standard_Input, Item => Input_PubKey, Last => Last_PubKey);
      if Last_PubKey > 0 and then Last_PubKey <= 66 then
         Name1.Pub_Key :=
           Bitcoin_Address_To_Bytes (Input_PubKey (1 .. Last_PubKey));
         Put_Line
           ("------------------------------------------------------------------");
         Put_Line
           ("Participant 1 Public Key: " & Input_PubKey (1 .. Last_PubKey));
         Put_Line
           ("------------------------------------------------------------------");
      else
         Put_Line ("Invalid public key length for participant 1.");
         return;
      end if;
   end;
   Put_Line
     ("------------------------------------------------------------------");
   Put_Line ("Enter Name for second party:");
   declare
      Input_Name : String (1 .. 100);
      Last_Name  : Natural;
   begin
      Get_Line (File => Standard_Input, Item => Input_Name, Last => Last_Name);
      Name2.Name := To_Unbounded_String (Input_Name (1 .. Last_Name));
      Put_Line
        ("------------------------------------------------------------------");
      Put_Line ("Participant 2 Name: " & To_String (Name2.Name));
      Put_Line
        ("------------------------------------------------------------------");
   end;

   Put_Line ("Enter Public Key (hex) for participant 2:");
   declare
      Input_PubKey : String (1 .. 66);
      Last_PubKey  : Natural;
   begin
      Get_Line
        (File => Standard_Input, Item => Input_PubKey, Last => Last_PubKey);
      if Last_PubKey > 0 and then Last_PubKey <= 66 then
         Name2.Pub_Key :=
           Bitcoin_Address_To_Bytes (Input_PubKey (1 .. Last_PubKey));
         Put_Line
           ("------------------------------------------------------------------");
         Put_Line
           ("Participant 2 Public Key: " & Input_PubKey (1 .. Last_PubKey));
         Put_Line
           ("------------------------------------------------------------------");
      else
         Put_Line ("Invalid public key length for participant 2.");
         return;
      end if;
   end;

   Put_Line ("Creating MultiSig Contract...");
   begin
      Create_Multi_Sig_Contract
        (Name1.Name, Name2.Name, Name1.Pub_Key, Name2.Pub_Key,
         Multi_Sig_Contract.Multi_Sig_PK);
      Put_Line
        ("------------------------------------------------------------------");
      Put_Line
        ("MultiSig Public Key (hex): " &
         Byte_Seq_To_Hex_String (Multi_Sig_Contract.Multi_Sig_PK));
      Put_Line
        ("------------------------------------------------------------------");
   end;

   Put_Line ("Enter Amount (BTC):");
   declare
      Input_Amount : String (1 .. 999);
      Last_Amount  : Natural;
   begin
      Get_Line
        (File => Standard_Input, Item => Input_Amount, Last => Last_Amount);
      begin
         Multi_Sig_Contract.Amount :=
           BTC_Float'Value (Input_Amount (1 .. Last_Amount));
         Put_Line
           ("Amount entered: " &
            BTC_Float_To_String (Multi_Sig_Contract.Amount) & " BTC");
         Put_Line
           ("------------------------------------------------------------------");
      end;
   end;
   Put_Line
     ("------------------------------------------------------------------");
   Put_Line ("Contract Details:");
   Put_Line
     ("Participants: " & To_String (Name1.Name) & " and " &
      To_String (Name2.Name));
   Put_Line
     ("------------------------------------------------------------------");
   Put_Line
     ("Amount: " & BTC_Float_To_String (Multi_Sig_Contract.Amount) & " BTC");
   Put_Line
     ("------------------------------------------------------------------");
   Put_Line
     ("MultiSig Public Key: " &
      Byte_Seq_To_Hex_String (Multi_Sig_Contract.Multi_Sig_PK));

   Orac.Name := To_Unbounded_String ("Oracle");
   Make_Decision (Orac, Multi_Sig_Contract);

   if Multi_Sig_Contract.Released then
      Put_Line
        ("------------------------------------------------------------------");
      Put_Line ("Funds released by the oracle.");
   else
      Put_Line ("Funds not released.");
   end if;

   if Multi_Sig_Contract.Released then
      Name1.Balance := Multi_Sig_Contract.Amount;
      Name2.Balance := 0.000_000_00;
   end if;
   Put_Line
     ("------------------------------------------------------------------");
   Put_Line ("Final Balance:");
   New_Line;
   Put_Line
     (To_String (Name1.Name) & "'s Balance: " &
      BTC_Float_To_String (Name1.Balance));
   Put_Line
     (To_String (Name2.Name) & "'s Balance: " &
      BTC_Float_To_String (Name2.Balance));
   Put_Line
     ("------------------------------------------------------------------");

   loop
      exit when Ada.Text_IO.Get_Line'Last > 0;
   end loop;

end Main;
