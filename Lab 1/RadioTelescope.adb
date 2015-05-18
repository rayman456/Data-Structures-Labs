with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Strings.Unbounded.Text_IO;
use Ada.Strings.Unbounded.Text_IO;
with Ada.Characters.Latin_1;
use Ada.Characters.Latin_1;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;
with Unchecked_Conversion;
with GStack;

procedure RadioTelescope is
   type StackType is
         (C,
          I,
          D,
          Done);
   type MonthName is
         (January,
          February,
          March,
          April,
          May,
          June,
          July,
          August,
          September,
          October,
          November,
          December);
   type Date is
      record
         Month : MonthName;
         Day   : Integer range 1 .. 31;
         Year  : Integer;
      end record;

   package Month_IO is new Ada.Text_IO.Enumeration_IO(MonthName);
   use Month_IO;
   package Type_IO is new Ada.Text_IO.Enumeration_IO(StackType);
   use Type_IO;

   function Character_To_Int is
   new Unchecked_Conversion(Character, Integer);
   function Int_To_Character is
   new Unchecked_Conversion(Integer, Character);

   function Int_To_Date is
   new Unchecked_Conversion(Integer, Date);
   function Date_To_Int is
   new Unchecked_Conversion(Date, Integer);

   Size  : Natural;
   Stack : StackType;

begin
   Main:
      loop
      Put("Enter a Stack Type (C/I/D): ");
      Get(Stack);
      if Stack /= Done then
         Put("Enter a Stack Size: ");
         Get(Size);
      end if;


      case Stack is
         when C =>
            declare
               package Character_Stack is new GStack(CHARACTER, Size);
               use Character_Stack;

               procedure GetInputString (
                     A_String :    out Unbounded_String) is
                  Char : Character;
               begin
                  loop
                     Get(Char);
                     exit when Char = Semicolon or Char = Space;
                     Append(A_String, Char);
                  end loop;
               end GetInputString;

               procedure InsertCharacters (
                     A_String : in     String) is
                  Succeed : Boolean;
               begin
                  if (A_String'Length + Current_Size) >= Total_Size then
                     Put("No space left in Stack, could not insert!");
                     New_Line;
                  else
                     for I in 1..A_String'Length loop
                        Push(A_String(I), Succeed);
                        if Succeed /= True then
                           Put("Failed to insert '");
                           Put(A_String(I));
                           Put_Line("'.");
                        end if;
                     end loop;
                     Push(Int_To_Character(A_String'Length), Succeed);
                     if Succeed /= True then
                        Put_Line("Could not load stream length.");
                     end if;
                     Put("Inserted -");
                     Put(A_String);
                     Put("- into the stack. Current size is now ");
                     Put(Current_Size, 2);
                     Put(".");
                     New_Line;
                  end if;
               end InsertCharacters;

               procedure PopCharacters is
                  Count   : Integer;
                  Temp    : Character;
                  Succeed : Boolean;
               begin
                  if Current_Size = 0 then
                     Put_Line("Nothing to pop!");
                  else
                     Put("Pop results: ");
                     Pop(Temp, Succeed);
                     if Succeed then
                        Put(Character_To_Int(Temp), 2);
                        Count := Character_To_Int(Temp);
                        for I in 1..Count loop
                           Pop(Temp, Succeed);
                           if Succeed then
                              Put(Temp);
                           else
                              New_Line;
                              Put("Could not retrieve character ");
                              Put(I, 2);
                              New_Line;
                           end if;
                        end loop;
                        New_Line;
                     else
                        Put_Line("Failed to retrieve character stream.");
                     end if;
                  end if;
               end Popcharacters;


            begin
               Put("Successfully allocated a character stack of size ");
               Put(Size, 2);
               Put_Line(".");
               Put_Line(
                  "Type a stream of characters followed by spaces to insert.");
               Put_Line(
                  "Type 'pop;' to pop a stream of characters. Type 'exit;' to exit.");
               loop
                  declare
                     Temp : Unbounded_String;
                  begin
                     GetInputString(Temp);
                     declare
                        Input : String (1 .. Length (Temp));
                     begin
                        Input := To_String(Temp);
                        if Input = "pop" then
                           PopCharacters;
                        elsif Input = "exit" then
                           exit;
                        else
                           InsertCharacters(Input);
                        end if;
                     end;
                  end;
               end loop;
            end;
         when I =>
            declare
               package Integer_Stack is new GStack(INTEGER, Size);
               use Integer_Stack;

               type Int_Array is array (Positive range <>) of Integer;

               procedure GetInputString (
                     A_String :    out Unbounded_String) is
                  Char : Character;
               begin
                  loop
                     Get(Char);
                     exit when Char = Semicolon or Char = Space;
                     Append(A_String, Char);
                  end loop;
               end GetInputString;

               procedure RecordInteger (
                     IntArray : in out Int_Array;
                     Index    : in out Integer;
                     An_Int   : in     Integer) is
               begin
                  Index := Index + 1;
                  IntArray(Index) := An_Int;
               end RecordInteger;

               procedure PushInts (
                     IntArray : in     Int_Array;
                     Count    : in     Integer) is
                  Succeed : Boolean;
               begin
                  if Count + Current_Size >= Total_Size then
                     Put_Line("No space left in stack, could not insert!");
                     return;
                  end if;
                  for I in 1..Count loop
                     Push(IntArray(I), Succeed);
                     if Succeed /= True then
                        Put("Failed to insert ");
                        Put(IntArray(I), 3);
                        Put_Line(".");
                     end if;
                  end loop;
                  Push(Count, Succeed);
                  if Succeed /= True then
                     Put_Line("Could not load stream length.");
                  end if;
                  Put("Inserted ");
                  Put(Count, 2);
                  Put(" integers into the stack. Size is now ");
                  Put(Current_Size, 2);
                  Put_Line(".");
               end PushInts;

               procedure PopIntegers is
                  Count   : Integer;
                  Int     : Integer;
                  Succeed : Boolean;
               begin
                  if Current_Size = 0 then
                     Put_Line("Nothing to pop!");
                     return;
                  end if;
                  Pop(Count, Succeed);
                  if Succeed then
                     Put("Pop results: ");
                     Put(Count, 4);
                     for I in 1..Count loop
                        Pop(Int, Succeed);
                        if Succeed /= True then
                           Put("Could not retrieve Integer #");
                           Put(I, 2);
                           Put_Line(".");
                        else
                           Put(Int, 4);
                        end if;
                     end loop;
                     New_Line;
                  else
                     Put_Line("Could not retrieve Integers.");
                  end if;
               end PopIntegers;

               Value : Integer;
               Count : Integer               := 0;
               Ints  : Int_Array (1 .. Size);

            begin
               Put("Successfully allocated an integer stack of size ");
               Put(Size, 2);
               Put_Line(".");
               Put_Line("Enter a stream of integers separated by spaces.");
               Put("The last integer must be '0' followed by ';'.");
               New_Line;
               Put(
                  "Type 'pop;' to pop a stream of integers. Type 'exit;' to exit.");
               New_Line;
               loop
                  declare
                     Temp : Unbounded_String;
                  begin
                     GetInputString(Temp);
                     declare
                        Input : String (1 .. Length (Temp));
                     begin
                        Input := To_String(Temp);
                        if Input = "pop" then
                           PopIntegers;
                        elsif Input = "exit" then
                           exit;
                        else
                           Value := Integer'Value(Input);
                           if Value = 0 then
                              PushInts(Ints, Count);
                              Count := 0;
                           else
                              RecordInteger(Ints, Count, Value);
                           end if;
                        end if;
                     end;
                  end;
               end loop;
            end;
         when D =>
            declare
               package Date_Stack is new GStack(Date, Size);
               use Date_Stack;

               type Date_Array is array (Positive range <>) of Date;

               procedure PrintDate (
                     A_Date : in     Date) is
               begin
                  Put(A_Date.Month);
                  Put(A_Date.Day, 3);
                  Put(", ");
                  Put(A_Date.Year, 4);
               end PrintDate;

               procedure GetInputString (
                     A_String :    out Unbounded_String) is
                  Char : Character;
               begin
                  loop
                     Get(Char);
                     exit when Char = Semicolon or Char = Space;
                     Append(A_String, Char);
                  end loop;
               end GetInputString;

               procedure RecordDate (
                     Some_Dates : in out Date_Array;
                     Index      : in out Integer;
                     A_Date     : in     Date) is
               begin
                  Index := Index + 1;
                  Some_Dates(Index) := A_Date;
               end;

               procedure PushDates (
                     Some_Dates : in     Date_Array;
                     Count      : in     Integer) is
                  Succeed : Boolean;
               begin
                  if Count + Current_Size >= Total_Size then
                     Put_Line("No space left in stack, could not insert!");
                     return;
                  end if;
                  for I in 1..Count loop
                     Push(Some_Dates(I), Succeed);
                     if Succeed /= True then
                        Put_Line("Failed to insert date.");
                     end if;
                  end loop;
                  Push(Int_To_Date(Count), Succeed);
                  if Succeed /= True then
                     Put_Line("Could not load stream length.");
                  end if;
                  Put("Inserted ");
                  Put(Count, 2);
                  Put(" Dates into the stack. Size is now ");
                  Put(Current_Size, 2);
                  Put_Line(".");
               end;

               procedure PopDates is
                  Count   : Integer;
                  Temp    : Date;
                  Succeed : Boolean;
               begin
                  if Current_Size = 0 then
                     Put_Line("Nothing to pop!");
                  else
                     Pop(Temp, Succeed);
                     if Succeed then
                        Count := Date_To_Int(Temp);
                        Put(Count, 2);
                        Put_Line(" Dates:");
                        for I in 1..Count loop
                           Pop(Temp, Succeed);
                           if Succeed then
                              PrintDate(Temp);
                              New_Line;
                           else
                              Put("Could not retrieve date #");
                              Put(I, 2);
                              Put_Line(".");
                           end if;
                        end loop;
                     else
                        Put_Line("Could not retrieve dates.");
                     end if;
                  end if;
               end PopDates;

               Control   : Integer                := 0;
               Count     : Integer                := 0;
               Dates     : Date_Array (1 .. Size);
               Temp_Date : Date;

            begin
               Put("Successfully allocated a date stack of size ");
               Put(Size, 2);
               Put_Line(".");

               Put_Line(
                  "Enter a stream of dates separated by spaces in the following format:");
               Put_Line("Month Day Year");
               Put_Line(
                  "The last word in the stream must be 'end' followed by ';'.");
               Put_Line(
                  "Type 'pop;' to pop a stream of dates. Type 'exit;' to exit;");

               loop
                  declare
                     Temp : Unbounded_String;
                  begin
                     GetInputString(Temp);
                     declare
                        Input : String (1 .. Length (Temp));
                     begin
                        Input := To_String(Temp);
                        if Input = "pop" then
                           PopDates;
                        elsif Input = "end" then
                           PushDates(Dates, Count);
                           Count := 0;
                        elsif Input = "exit" then
                           exit;
                        else
                           case Control is
                              when 0 =>
                                 Temp_Date.Month := MonthName'Value(Input);
                                 Control := 1;
                              when 1=>
                                 Temp_Date.Day := Integer'Value(Input);
                                 Control := 2;
                              when 2 =>
                                 Temp_Date.Year := Integer'Value(Input);
                                 RecordDate(Dates, Count, Temp_Date);
                                 Control := 0;
                              when others =>
                                 null;
                           end case;
                        end if;
                     end;
                  end;
               end loop;
            end;
         when Done =>
            exit;
      end case;
   end loop Main;
end RadioTelescope;

