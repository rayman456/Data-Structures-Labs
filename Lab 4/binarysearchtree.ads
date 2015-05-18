generic

   type Akey is private;

   type BinarySearchTreeRecord is private;

   with function "<" (
         TheKey  : in     Akey;
         ARecord : in     BinarySearchTreeRecord)
     return Boolean;-- Is TheKey less than the key of ARecord?

   with function ">" (
         TheKey  : in     Akey;
         ARecord : in     BinarySearchTreeRecord)
     return Boolean;

   with function "=" (
         TheKey  : in     Akey;
         ARecord : in     BinarySearchTreeRecord)
     return Boolean;

   --needed if I want to manipulate tree record data fields since this is generic
   with function GetName (
         ARecord : in     BinarySearchTreeRecord)
     return AKey;

   with function GetPhone (
         ARecord : in     BinarySearchTreeRecord)
     return AKey;

   with function NewCustomer (
         Name  : in     AKey;
         Phone : in     AKey)
     return BinarySearchTreeRecord;

   --needed to print keys
   with procedure Put (
         Key : in     AKey);

package BinarySearchTree is

   type BinarySearchTreePoint is private;

   --Constructor
   procedure MakeEmptyBinarySearchTree (
         NewTree : in out BinarySearchTreePoint;
         Name    : in     AKey;
         Phone   : in     AKey);

   --Check if a tree pointer is null
   function IsNull (
         Tree : in     BinarySearchTreePoint)
     return Boolean;

   --Returns the size of the tree.
   function TreeSize (
         Tree : in     BinarySearchTreePoint)
     return Integer;

   procedure InsertBinarySearchTree (
         Root      : in out BinarySearchTreePoint;
         CustName  : in     Akey;
         CustPhone : in     Akey);

   procedure FindCustomerIterative (
         Root          : in     BinarySearchTreePoint;
         CustomerName  : in     Akey;
         CustomerPoint :    out BinarySearchTreePoint);

   procedure FindCustomerRecursive (
         Root          : in     BinarySearchTreePoint;
         CustomerName  : in     Akey;
         CustomerPoint :    out BinarySearchTreePoint);

   function InOrderSuccessor (
         TreePoint : in     BinarySearchTreePoint)
     return BinarySearchTreePoint;

   function CustomerName (
         TreePoint : in     BinarySearchTreePoint)
     return Akey;

   function CustomerPhone (
         TreePoint : in     BinarySearchTreePoint)
     return Akey;

   --Deletes a random node given the pointer to the node and the tree the node is in.
   --The pointer to the delete node will be null after execution.
   procedure DeleteRandomNode (
         Tree        : in     BinarySearchTreePoint;
         DeletePoint : in out BinarySearchTreePoint);

   --Recursively prints the tree in reverse inorder
   procedure ReverseInOrder (
         Start : in     BinarySearchTreePoint);

   procedure PreOrder (
         TreePoint : in     BinarySearchTreePoint);

   procedure PostOrderIterative (
         TreePoint : in out BinarySearchTreePoint);

   procedure PostOrderRecursive (
         TreePoint : in out BinarySearchTreePoint);

private
   type Node;
   type BinarySearchTreePoint is access Node;
   type Node is
      record
         Llink,
         Rlink : BinarySearchTreePoint;
         Ltag,
         Rtag  : Boolean;
         Info  : BinarySearchTreeRecord;
      end record;
end BinarySearchTree;
