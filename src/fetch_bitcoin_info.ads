with Ada.Text_IO;

package Fetch_Bitcoin_Info is
   procedure Fetch_Bitcoin_Info
     (Bitcoin_Price : out Integer; Block_Height : out Integer);
end Fetch_Bitcoin_Info;
