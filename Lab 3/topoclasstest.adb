with TopoClass;
with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO;
use Ada.Strings.Unbounded.Text_IO;

procedure TopoClassTest is

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

   procedure IntGet(Thing : out Integer) is
   begin
      get(Thing);
   end IntGet;

   procedure MyTypeGet(Thing : out MyType) is
   begin
      MyTypeIO.Get(Thing);
   end MyTypeGet;

   procedure IntPut (
         Thing : in     Integer) is
   begin
      Put(Thing, 2);
   end IntPut;

   procedure MyTypePut (
         Thing : in     MyType) is
   begin
      MyTypeIO.Put(Thing);
   end MyTypePut;

   package IntTopo is new TopoClass(Integer, IntGet, IntPut);
   package NameTopo is new TopoClass(MyType, MyTypeGet, MyTypePut);

   Input : Unbounded_String;

begin
   loop
      put_line("integer or names? ");
      Input := Get_Line;
      if Input = "integer" then
         IntTopo.SortDemo;
      elsif Input = "names" then
         NameTopo.SortDemo;
      elsif Input = "done" then
         exit;
      end if;
   end loop;
end TopoClassTest;
