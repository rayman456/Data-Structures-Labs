procedure MoveStacks (
      Base       : in out INT_ARRAY;
      Top        : in out INT_ARRAY;
      StackSpace : in out ITEM_ARRAY;
      NewBase    : in     INT_ARRAY) is
   Delt : Integer;
   N    : Integer := Top'Length;
begin
   for H in 2..N loop
      if NewBase(H) < Base(H) then
         Delt :=  Base(H) - NewBase(H);
         for L in (Base(H) +1)..Top(H) loop
            StackSpace(L - Delt) := StackSpace(L);
         end loop;
         Base(H) := NewBase(H);
         Top(H) := Top(H) - Delt;
      end if;
   end loop;
   for H in reverse 2..N loop
      if NewBase(H) > Base(H) then
         Delt := NewBase(H) - Base(H);
         for L in reverse (Base(H) + 1)..Top(H) loop
            StackSpace(L + Delt) := StackSpace(L);
         end loop;
         Base(H) := NewBase(H);
         Top(H) := Top(H) + Delt;
      end if;
   end loop;
end MoveStacks;
