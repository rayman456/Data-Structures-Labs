generic
   type ITEM is private;

   with function GetHash (
         Key : in     ITEM)
     return Long_Integer;

   with procedure Put (
         Key : in     ITEM);

package HashTable128 is

   type HashTable128 is tagged private;

   type LinearHashTable128 is new HashTable128 with private;

   type RandomHashTable128 is new HashTable128 with private;

   procedure SetupHashTable (
         HashTable           : in out HashTable128'Class;
         Table_Name          : in     String;
         Default_Table_Value : in     ITEM);

   procedure InsertLinearProbe (
         HashTable    : in out LinearHashTable128;
         Key          : in     ITEM;
         Percent_Full :    out Float);

   procedure InsertRandomProbe (
         HashTable    : in out RandomHashTable128;
         Key          : in     ITEM;
         Percent_Full :    out Float);

   procedure SearchLinearProbe (
         HashTable        : in out LinearHashTable128;
         Key              : in     ITEM;
         Number_Of_Probes :    out Integer);

   procedure SearchRandomProbe (
         HashTable        : in out RandomHashTable128;
         Key              : in     ITEM;
         Number_Of_Probes :    out Integer);

   procedure PrintTable (
         HashTable : in     HashTable128'Class);

private

   type HashTable128 is tagged
      record
         Table : String (1 .. 6);
         Empty : ITEM;
         Count : Integer         := 0;
      end record;

   type LinearHashTable128 is new HashTable128 with null record;
   type RandomHashTable128 is new HashTable128 with null record;

   type RandomAddress128
         (Initial_Address : Long_Integer) is
      record
         Address : Long_Integer := ((Initial_Address - 1) * 4) + 1;
      end record;

   function GetAddress128 (
         RA : in     RandomAddress128)
     return Long_Integer;

   procedure NextAddress128 (
         RA : in out RandomAddress128);

end HashTable128;

