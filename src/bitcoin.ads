package Bitcoin is

   type SATs is new Integer;

   function To_SATs (BTC_Amount : Float) return SATs;

   function To_BTC (Sats_Value : SATs) return Float;

   function SATs_To_BTC_String (Sats_Value : SATs) return String;

end Bitcoin;
