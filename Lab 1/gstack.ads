generic

   type ITEM is private;

   Size : Positive := 5;

package GStack is

   procedure Push (
      Stuff   : in     ITEM;
      Succeed :    out BOOLEAN);

   procedure Pop (
      Stuff   :    out ITEM;
      Succeed :    out BOOLEAN);

   function Is_Empty return BOOLEAN;

   function Is_Full return BOOLEAN;

   function Current_Size return NATURAL;

   function Total_Size return POSITIVE;

end GStack;