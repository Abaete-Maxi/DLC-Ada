with Ada.Float_Text_IO;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
package body Bitcoin is

   function To_SATs (BTC_Amount : Float) return SATs is
   begin
      return SATs (BTC_Amount * 100_000_000.0);
   end To_SATs;

   function To_BTC (Sats_Value : SATs) return Float is
   begin
      return Float (Sats_Value) / 100_000_000.0;
   end To_BTC;

   function SATs_To_String (Sats_Value : SATs) return String is
      Btc_Amount : Float := To_BTC (Sats_Value);
      Str        : String (1 .. 15);
      Last       : Natural;
   begin
      Ada.Float_Text_IO.Put (Str, Btc_Amount, Aft => 8, Exp => 0);
      return Ada.Strings.Fixed.Trim (Str, Ada.Strings.Both);
   end SATs_To_String;

   function SATs_To_BTC_String (Sats_Value : SATs) return String is
      Str         : String := SATs_To_String (Sats_Value);
      Space_Index : Natural;
   begin
      Space_Index := Ada.Strings.Fixed.Index (Str, " ");
      if Space_Index = 0 then
         return Str;
      else
         return Str (Str'First .. Space_Index - 1);
      end if;
   end SATs_To_BTC_String;

end Bitcoin;
