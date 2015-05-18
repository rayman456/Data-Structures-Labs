generic
   type ITEM is
         (<>);

   with procedure Get (
         Thing :    out ITEM);

   with procedure Put (
         Thing : in     ITEM);

package TopoClass is

   type Topological_Sort
         (Num      : Integer;
          Arrayend : ITEM) is tagged private;

   function GenerateTopo (
         Number : Integer)
     return Topological_Sort;

   procedure AddPartialOrder (
         Topo   : in out Topological_Sort;
         Before : in     ITEM;
         After  : in     ITEM);

   procedure PrintTopo (
         Topo : in     Topological_Sort);

   procedure BuildTopo (
         Topo : in out Topological_Sort);

   procedure TopologicalSort (
      Topo : in     Topological_Sort);

   procedure SortDemo;

private
   type Node;
   type NodePt is access Node;
   type Node is
      record
         Info : ITEM;
         Next : NodePt;
      end record;

   type Int_Array is array (ITEM range <>) of Integer;
   type Item_Array is array (ITEM range <>) of ITEM;
   type NodePt_Array is array (ITEM range <>) of NodePt;

   type Topological_Sort
         (Num      : Integer;
          ArrayEnd : ITEM) is tagged
      record
         Na    : Integer                                 := Num;
         Count : Int_Array (ITEM'Val (0) .. ArrayEnd)    := (others => 0);
         Top   : NodePt_Array (ITEM'Val (0) .. ArrayEnd) := (others => null);
      end record;
end TopoClass;
