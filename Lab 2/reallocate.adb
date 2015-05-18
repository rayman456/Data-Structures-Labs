procedure Reallocate (
      Top           : in out INT_ARRAY;
      OldTop        : in out INT_ARRAY;
      Base          : in out INT_ARRAY;
      StackSpace    : in out ITEM_ARRAY;
      MinimumSpace  : in     Float;
      EqualAllocate : in     Float;
      StackNum      : in     Integer;
      Thing         : in     ITEM;
      Successful    :    out Boolean) is
   N              : Integer := Top'Length;
   AvailSpace     : Integer;
   Totallnc       : Integer;
   J              : Integer := N;
   GrowthAllocate : Float;
   Alpha          : Float;
   Beta           : Float;
   Tau            : Float;
   Sigma          : Float;
begin
   AvailSpace := Base(N+1) - Base(1);
   Totallnc := 0;
   while J > 0 loop
      AvailSpace := AvailSpace - (Top(J) - Base(J));
      if Top(J) > OldTop(J) then
         OldTop(J+1) := Top(J) - OldTop(J);
         Totallnc := Totallnc + OldTop(J+1);
      else
         OldTop(J+1) := 0;
      end if;
      J := J - 1;
   end loop;
   if Float(AvailSpace) < ((Float(Base(N+1) - Base(1)) * MinimumSpace) - 1.0) then
      --not enough memory
      Successful := False;
      Top(StackNum) := Top(StackNum) - 1;
      for X in 1..N loop
         OldTop(X) := Top(X); --currently holds growth values
      end loop;
      Top(StackNum) := Top(StackNum) + 1;
      return;
   end if;
   GrowthAllocate := 1.0 - EqualAllocate;
   Alpha := (EqualAllocate * Float(AvailSpace)) / Float(N);
   Beta := (GrowthAllocate * Float(AvailSpace)) / Float(Totallnc);
   OldTop(1) := Base(1);
   Sigma := 0.0;
   for I in 2..N loop
      Tau := Sigma + Alpha + (Float(OldTop(I)) * Beta);
      OldTop(I) := OldTop(I - 1) + (Top(I - 1) - Base(I - 1)) + Integer(Float'Floor(Tau)) - Integer(Float'Floor(Sigma));
      Sigma := Tau;
   end loop;
   Top(StackNum) := Top(StackNum) - 1;
   --MoveStack Begin
   MoveStacks(Base, Top, StackSpace, OldTop);
   --MoveStack End
   Top(StackNum) := Top(StackNum) + 1;
   StackSpace(Top(StackNum)) := Thing;
   for X in 1..N loop
      OldTop(X) := Top(X);
   end loop;
   Successful := True;
end Reallocate;

