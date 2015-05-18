with Toposort;
with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO;
use Ada.Strings.Unbounded.Text_IO;

procedure TopoTest is

   type MyType is
         (Nothing,
          Garza,
          Taylor,
          Funk,
          Sido,
          Dedear,
          Rocha,
          McLeod,
          Reioux,
          Davies);

   package MyTypeIO is new Ada.Text_IO.Enumeration_IO(MyType);

   procedure Get (
         Thing :    out MyType) is
   begin
      MyTypeIO.Get(Thing);
   end;

   procedure Put (
         Thing : in     MyType) is
   begin
      MyTypeIO.Put(Thing);
   end;

   package IntTopoSort is new Toposort(Integer, Get, Put);
   package NameTopoSort is new Toposort(MyType, Get, Put);

begin
   loop
      declare
         Input : Unbounded_String;
      begin
         Input := Get_Line;
         exit when Input = "exit";
         if Input = "integer" then
            IntTopoSort.TopologicalSort;
         elsif Input = "names" then
            NameTopoSort.TopologicalSort;
         end if;
      end;
   end loop;
end;

