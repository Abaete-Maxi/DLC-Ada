with GNATCOLL.OS.Process;   use GNATCOLL.OS.Process;
with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body Fetch_Nostr_Info is

   procedure Fetch_Oracle_Decision
     (Decision : out Ada.Strings.Unbounded.Unbounded_String)
   is
      Cmd : constant Argument_List :=
        Argument_List'
          (("python", "src/nostr_event_check.py",
            "nevent1qqst4kp7cnp6phprdtjfukgmdg4saslvq0mxkz8857yzctpe5x6czfsp86lsy"));
      Full_Output : Unbounded_String;
      Status      : Integer;
   begin
      Full_Output := GNATCOLL.OS.Process.Run (Cmd, Status => Status);
      if Status /= 0 then
         Ada.Text_IO.Put_Line
           ("Error: Process exited with status " & Integer'Image (Status));
         Decision := To_Unbounded_String ("Error fetching oracle decision");
         return;
      end if;

      Ada.Text_IO.Put_Line
        ("Debug: Full output from Python script: " & To_String (Full_Output));
      Decision := Full_Output;
   exception
      when others =>
         Decision := To_Unbounded_String ("Error fetching oracle decision");
   end Fetch_Oracle_Decision;

end Fetch_Nostr_Info;
