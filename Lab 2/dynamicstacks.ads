generic

   type ITEM is private;

   type ITEM_ARRAY is array (Integer range <>) of ITEM;

   type INT_ARRAY is array (Natural range <>) of Integer;

   Lo : Integer;

   M : Integer;

   Front : Integer;

   Rear : Integer;

   NumberOfStacks : Integer;

   EqualAllocate : Float;

   Minimum : Float;

   with procedure Reallocate (
         Top           : in out INT_ARRAY;
         OldTop        : in out INT_ARRAY;
         Base          : in out INT_ARRAY;
         StackSpace    : in out ITEM_ARRAY;
         MinimumSpace  : in     Float;
         EqualAllocate : in     Float;
         StackNum      : in     Integer;
         Thing         : in     ITEM;
         Successful    :    out Boolean);

   with procedure Put (
         Thing : ITEM);

package DynamicStacks is

   procedure Setup;

   procedure Push (
         K          : in     Integer;
         Thing      : in     ITEM;
         Successful :    out Boolean);

   procedure Pop (
         K          : in     Integer;
         Thing      :    out ITEM;
         Successful :    out Boolean);

end DynamicStacks;

