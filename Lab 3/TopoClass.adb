with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded.Text_IO;
use Ada.Strings.Unbounded.Text_IO;

package body TopoClass is

   function GenerateTopo (
         Number : Integer)
     return Topological_Sort is
      Temp : Topological_Sort (Number, ITEM'Val (Number));
   begin
      return Temp;
   end GenerateTopo;

   procedure AddPartialOrder (
         Topo   : in out Topological_Sort;
         Before : in     ITEM;
         After  : in     ITEM) is
   begin
      Topo.Count(After) := Topo.Count(After) + 1;
      Topo.Top(Before) := new Node'(
         Info => After,
         Next => Topo.Top (Before));
   end AddPartialOrder;

   procedure PrintTopo (
         Topo : in     Topological_Sort) is
      P     : NodePt;
      Count : Integer;
   begin
      for I in ITEM'Val(0)..ITEM'Val(Topo.NA) loop
         Put(I);
         Put(": Count(");
         Put(Topo.Count(I), 2);
         Put(") ");
         P := Topo.Top(I);
         Count := 0;
         while Count <= 6 and then P /= null loop
            Put(P.Info);
            Put(" -> ");
            P := P.Next;
            Count := Count + 1;
         end loop;
         Put_Line("null");
      end loop;
   end PrintTopo;

   procedure BuildTopo (
         Topo : in out Topological_Sort) is
      J     : ITEM;
      K     : ITEM;
      Input : Integer;
   begin
      Put_Line("Partial Order: Action1 < Action2 (Action1 comes before Action2).");
      Put_Line("Enter number of Partial Orders: ");
      Get(Input);
      Skip_Line;
      --loop
      while Input > 0 loop
         begin
            Put("Action1: ");
            Get(J);
            Skip_Line;
            Put("Action2: ");
            Get(K);
            Skip_Line;
            AddPartialOrder(Topo, J, K);
            put("Added "); put(J); put(" before "); put(K); put_line(".");
            Input := Input - 1;
         exception
            when Data_Error =>
               Put_Line("Invalid: Value not acceptable.");
         end;
      end loop;
   end BuildTopo;

   procedure TopologicalSort (
         Topo : in     Topological_Sort) is
      K    : Integer;
      F    : Integer;
      R    : Integer;
      KN   : Integer;
      P    : NodePt;
      Temp : Topological_Sort := Topo;
   begin
      KN := Temp.NA;
      R := 0;
      Temp.Count(ITEM'Val(0)) := 0;
      for I in 1..Temp.NA loop
         if Temp.Count(ITEM'Val(I)) = 0 then
            Temp.Count(ITEM'Val(R)) := I;
            R := I;
         end if;
      end loop;
      F := Temp.Count(ITEM'Val(0));
      while F /= 0 loop
         Put("Perform action ");
         Put(ITEM'Val(F));
         New_Line;
         KN := KN - 1;
         P := Temp.Top(ITEM'Val(F));
         Temp.Top(ITEM'Val(F)) := null;
         while P /= null loop
            Temp.Count(P.Info) := Temp.Count(P.Info) - 1;
            if Temp.Count(P.Info) = 0 then
               Temp.Count(ITEM'Val(R)) := ITEM'Pos(P.Info);
               R := ITEM'Pos(P.Info);
            end if;
            P := P.Next;
         end loop;
         F := Temp.Count(ITEM'Val(F));
      end loop;
      if KN = 0 then
         Put_Line("Successful Sort!");
      else
         Put_Line("Error!");
         for I in 1..Temp.NA loop
            Temp.Count(ITEM'Val(I)) := 0;
         end loop;
         for I in 1..Temp.NA loop
            P := Temp.Top(ITEM'Val(I));
            Temp.Top(ITEM'Val(I)) := null;
            while P /= null loop
               if Temp.Count(P.Info) = 0 then
                  Temp.Count(P.Info) := I;
               end if;
               P := P.Next;
            end loop;
         end loop;
         K := 1;
         while Temp.Count(ITEM'Val(K)) = 0 loop
            K := K + 1;
         end loop;
         loop
            Temp.Top(ITEM'Val(K)) := new Node'(
               Info => ITEM'Val (0),
               Next => null);
            K := Temp.Count(ITEM'Val(K));
            exit when Temp.Top(ITEM'Val(K)) /= null;
         end loop;
         Put("Loop Found: ");
         while Temp.Top(ITEM'Val(K)) /= null loop
            Put(ITEM'Val(K));
            Put(" -> ");
            Temp.Top(ITEM'Val(K)) := null;
            K := Temp.Count(ITEM'Val(K));
         end loop;
         Put(ITEM'Val(K));
         New_Line;
      end if;
   end;

   procedure SortDemo is
      NA : Integer;
   begin
      Put_Line("Enter Number of Actions: ");
      Get(NA);
      Skip_Line;
      declare
         TopoTest : Topological_Sort := GenerateTopo(NA);
      begin
         Buildtopo(TopoTest);
         TopologicalSort(TopoTest);
      end;
   end SortDemo;

end TopoClass;
