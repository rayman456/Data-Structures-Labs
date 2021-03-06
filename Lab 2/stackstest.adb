with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;
with Dynamicstacks;
with Reallocate;
with MoveStacks;

procedure StacksTest is
   type Name is
         (Lee,
          Rios,
          Carazo,
          Hodges,
          Patil,
          Garza,
          Morgan,
          McLeod,
          Yager,
          Wills,
          Assi,
          Hall,
          Pokhrel,
          Sido,
          Keo,
          Sodemann,
          Davies,
          Furbee,
          Sparks,
          Vincik,
          Dedear,
          Guo,
          Doo,
          Burris);

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
         Day   : Integer range 1 .. 31;
         Month : MonthName;
         Year  : Integer range 1400 .. 2020;
      end record;

   type Valid is
         (Names,
          Dates,
          Done);

   package ValidIO is new Ada.Text_IO.Enumeration_IO(Valid);
   use ValidIO;

   package NameIO is new Ada.Text_IO.Enumeration_IO(Name);

   package MonthIO is new Ada.Text_IO.Enumeration_IO(MonthName);

   type NameArray is array (Integer range <>) of Name;
   type DateArray is array (Integer range <>) of Date;
   type IntArray is array (Natural range <>) of Integer;

   procedure Putname (
         Thing : in     Name) is
   begin
      NameIO.Put(Thing);
   end;

   procedure Putdate (
         Thing : in     Date) is
   begin
      MonthIO.Put(Thing.Month);
      Put(" ");
      Put(Thing.Day, 2);
      Put(", ");
      Put(Thing.Year, 2);
   end;

   procedure GetInput (
         Input :    out Unbounded_String) is
      N : Character;
   begin
      loop
         Get(N);
         exit when N = ';';
         Append(Input, N);
      end loop;
   end GetInput;

   StackType      : Valid;
   MemoryStart    : Integer;
   MemoryEnd      : Integer;
   Front          : Integer;
   Rear           : Integer;
   NumberOfStacks : Integer;

begin
   Main:
      loop
      Put_Line("Enter a stack type (Names/Dates): ");
      Get(StackType);
      case StackType is
         when Names =>
            Put_Line("Enter the start of memory: ");
            Get(MemoryStart);
            Put_Line("Enter the end of memory: ");
            Get(MemoryEnd);
            Put_Line("Enter the front of the stack list: ");
            Get(Front);
            Put_Line("Enter the rear of the stack list: ");
            Get(Rear);
            Put_Line("Enter number of stacks: ");
            Get(NumberOfStacks);
            declare
               procedure MS is
               new MoveStacks(Name, NameArray, IntArray);

               procedure ReAll is
               new Reallocate(Name, NameArray, IntArray, MS);

               package NameStacks is new Dynamicstacks(Name, NameArray, IntArray, MemoryStart, MemoryEnd, Front, Rear, NumberOfStacks, 0.09, 0.1, ReAll, Putname);

               procedure ProcessNameInput (
                     A_String : in     Unbounded_String) is
                  Temp       : String (1 .. Length (A_String)) := To_String (A_String);
                  Index      : Integer                         := 2;
                  Stack      : Integer;
                  A_Name     : Name;
                  Successful : Boolean;
               begin
                  case Temp(1) is
                     when 'I' =>
                        while Temp(Index) /= ' ' loop
                           Index := Index + 1;
                        end loop;
                        Stack := Integer'Value(Temp(2..Index-1));
                        A_Name := Name'Value(Temp(Index+1..Temp'Last));
                        NameStacks.Push(Stack, A_Name, Successful);
                        if Successful then
                           Put("Inserted -");
                           NameIO.Put(A_Name);
                           Put("- into stack ");
                           Put(Stack, 2);
                           Put_Line(".");
                        else
                           Put(">>Failed to insert ");
                           NameIO.Put(A_Name);
                           Put(" into stack ");
                           Put(Stack, 1);
                           Put_Line("<<");
                        end if;
                     when 'D' =>
                        Stack := Integer'Value(Temp(2..Temp'Last));
                        NameStacks.Pop(Stack, A_Name, Successful);
                        if Successful then
                           Put("Pop Results for stack ");
                           Put(Stack, 2);
                           Put(": ");
                           NameIO.Put(A_Name);
                           New_Line;
                        else
                           Put_Line("Nothing to pop!");
                        end if;
                     when others =>
                        null;
                  end case;
               end ProcessNameInput;

            begin
               NameStacks.Setup;
               NameLoop:
                  loop
                  declare
                     Temp : Unbounded_String;
                  begin
                     GetInput(Temp);
                     exit when Temp = "exit";
                     ProcessNameInput(Temp);
                  end;
               end loop NameLoop;
            end;
         when Dates=>
            Put_Line("Enter the start of memory: ");
            Get(MemoryStart);
            Put_Line("Enter the end of memory: ");
            Get(MemoryEnd);
            Put_Line("Enter the front of the stack list: ");
            Get(Front);
            Put_Line("Enter the rear of the stack list: ");
            Get(Rear);
            Put_Line("Enter number of stacks: ");
            Get(NumberOfStacks);
            declare
               procedure MS is
               new MoveStacks(Date, DateArray, IntArray);

               procedure ReAll is
               new Reallocate(Date, DateArray, IntArray, MS);

               package DateStacks is new Dynamicstacks(Date, DateArray, IntArray, MemoryStart, MemoryEnd, Front, Rear, NumberOfStacks, 0.09, 0.1, ReAll, Putdate);

               procedure ProcessDateInput (
                     A_String : in     Unbounded_String) is
                  Temp       : String (1 .. Length (A_String)) := To_String (A_String);
                  Index1     : Integer                         := 2;
                  Index2     : Integer;
                  Stack      : Integer;
                  A_Date     : Date;
                  Successful : Boolean;
               begin
                  case Temp(1) is
                     when 'I' =>
                        while Temp(Index1) /= ' ' loop
                           Index1 := Index1 + 1;
                        end loop;
                        Stack := Integer'Value(Temp(2..Index1 - 1));
                        Index1 := Index1 + 1;
                        Index2 := Index1;
                        while Temp(Index1) /= ' ' loop
                           Index1 := Index1 + 1;
                        end loop;
                        A_Date.Month := MonthName'Value(Temp(Index2..Index1 - 1));
                        Index1 := Index1 + 1;
                        Index2 := Index1;
                        while Temp(Index1) /= ' ' loop
                           Index1 := Index1 + 1;
                        end loop;
                        A_Date.Day := Integer'Value(Temp(Index2..Index1 - 1));
                        A_Date.Year := Integer'Value(Temp(Index1 + 1..Temp'Last));
                        DateStacks.Push(Stack, A_Date, Successful);
                        if Successful then
                           Put("Inserted -");
                           Putdate(A_Date);
                           Put("- into stack ");
                           Put(Stack, 2);
                           Put_Line(".");
                        else
                           Put(">>Failed to insert ");
                           Putdate(A_Date);
                           Put(" into stack ");
                           Put(Stack, 1);
                           Put_Line("<<");
                        end if;
                     when 'D' =>
                        Stack := Integer'Value(Temp(2..Temp'Last));
                        DateStacks.Pop(Stack, A_Date, Successful);
                        if Successful then
                           Put("Pop Results for stack ");
                           Put(Stack, 2);
                           Put(": ");
                           Putdate(A_Date);
                           New_Line;
                        else
                           Put_Line("Nothing to pop!");
                        end if;
                     when others =>
                        null;
                  end case;
               end ProcessDateInput;

            begin
               DateStacks.Setup;
               DateLoop:
                  loop
                  declare
                     Temp : Unbounded_String;
                  begin
                     GetInput(Temp);
                     exit when Temp = "exit";
                     ProcessDateInput(Temp);
                  end;
               end loop DateLoop;
            end;
         when Done =>
            exit Main;
      end case;
   end loop Main;
end;

