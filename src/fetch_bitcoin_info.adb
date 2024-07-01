with Ada.Text_IO;                use Ada.Text_IO;
with GNATCOLL.OS.Process;        use GNATCOLL.OS.Process;
with Ada.Strings.Fixed;          use Ada.Strings.Fixed;
with Ada.Strings.Maps;           use Ada.Strings.Maps;
with Ada.Strings.Unbounded;      use Ada.Strings.Unbounded;
with Ada.Characters.Conversions; use Ada.Characters.Conversions;

package body Fetch_Bitcoin_Info is

   procedure Fetch_Bitcoin_Info
     (Bitcoin_Price : out Integer; Block_Height : out Integer)
   is
      Cmd : constant Argument_List :=
        Argument_List'(("python", "src/bitcoin_info.py"));
      Full_Output : Unbounded_String;
      Status      : Integer;
      Comma_Set   : constant Ada.Strings.Maps.Character_Set := To_Set (',');

   begin
      -- Initialize output parameters
      Bitcoin_Price := 0;
      Block_Height  := 0;

      -- Execute the command and capture output
      Full_Output := Run (Cmd, Status => Status);

      -- Check if the process exited successfully
      if Status /= 0 then
         Put_Line
           ("Error: Process exited with status " & Integer'Image (Status));
         return;
      end if;

      -- Convert Unbounded_String to Bounded String
      declare
         Full_Output_Bounded : String := To_String (Full_Output);
      begin
         -- Debugging output
         Put_Line ("" & Full_Output_Bounded);

      end;
   end Fetch_Bitcoin_Info;

end Fetch_Bitcoin_Info;
