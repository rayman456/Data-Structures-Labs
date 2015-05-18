procedure Algorithms is

   type Int_Array is array (Positive range <>) of Integer;

   procedure MoveStacks (
         NewBase    : in     Int_Array;
         Base       : in out Int_Array;
         Top        : in out Int_Array;
         StackSpace : in out Int_Array) is
      Delt : Integer;
   begin
      for J in 2..(Base'Length - 1) loop
         if NewBase(J) < Base(J) then
            Delt := Base(J) - NewBase(J);
            for L in (Base(J) + 1)..Top(J) loop
               StackSpace(L - Delt) := StackSpace(L);
            end loop;
            Base(J) := NewBase(J);
            Top(J) := Top(J) - Delt;
         end if;
      end loop;
      for J in reverse 2..(Base'Length - 1) loop
         if NewBase(J) > Base(J) then
            Delt := NewBase(J) - Base(J);
            for L in reverse (Base(J) + 1)..Top(J) loop
               StackSpace(L + Delt) := StackSpace(L);
            end loop;
            Base(J) := NewBase(J);
            Top(J) := Top(J) + Delt;
         end if;
      end loop;
   end MoveStacks;

   procedure Reallocate (
         Top           : in     Int_Array;
         Base          : in     Int_Array;
         OldTop        : in out Int_Array;
         NewBase       :    out Int_Array;
         MinSpace      : in     Integer;
         EqualAllocate : in     Float) is
      Totallnc       : Integer;
      AvailSpace     : Integer;
      J              : Integer;
      Alpha          : Float;
      Beta           : Float;
      Sigma          : Float;
      Tau            : Float;
      GrowthAllocate : Float;
      Growth
      is array(1..Base'Length - 1) of Integer;
   begin
      Totallnc := 0;
      AvailSpace := Base(Base'Last) - Base(Base'First);
      J := Base'Length - 1;
      while J > 0 loop
         AvailSpace := AvailSpace - (Top(J) - Base(J));
         if Top(J) > OldTop(J) then
            Growth(J) := Top(J) - OldTop(J);
            Totallnc := Totallnc + Growth(J);
         else
            Growth(J) := 0;
         end if;
         J := J - 1;
      end loop;
      if AvailSpace < (MinSpace - 1) then
         return;
      end if;
      GrowthAllocate := 1.0 - EqualAllocate;
      Alpha := (EqualAllocate * Float(AvailSpace)) / Float(Base'Length - 1);
      Beta := (GrowthAllocate * Float(AvailSpace)) / Float(Totallnc);
      Sigma := 0.0;
      NewBase(1) := Base(1);
      for J in 2..Base'Length - 1 loop
         Tau := Sigma + Alpha + (Float(Growth(J-1)) * Beta);
         NewBase(J) := NewBase(J-1) + (Top(J-1) - Base(J-1)) + Integer(Float'Floor(Tau)) - Integer(Float'Floor(Sigma));
         Sigma := Tau;
      end loop;

   end Reallocate;

begin
end;


