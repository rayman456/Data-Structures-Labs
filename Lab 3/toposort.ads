generic
   type ITEM is (<>);
   with procedure Get (
         Thing :    out ITEM);
   with procedure Put (
         Thing : in     ITEM);
package TopoSort is
   procedure TopologicalSort;
end TopoSort;

