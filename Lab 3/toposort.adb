with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Deallocation;
package body Toposort is

   type Node;
   type NodePt is access Node;
   type Node is
      record
         Info : ITEM;
         Next : NodePt;
      end record;

   procedure TopologicalSort is

      procedure Free is
      new Ada.Unchecked_Deallocation(Node, NodePt);

      NA : Integer;
      KN : Integer;

   begin
      --Step 2
      Put("Enter total number of steps: ");
      Get(NA);
      Put("Enter total number of partial orders to be processed: ");
      Get(KN);
      declare
         QLink : array(ITEM'Val(0)..ITEM'Val(NA)) of ITEM := (others => ITEM'Val(0));
         Count : array(ITEM'Val(0)..ITEM'Val(NA)) of Integer := (others => 0);
         Top: array(ITEM'Val(0)..ITEM'Val(NA)) of NodePt := (others => null);
         J : ITEM;
         K : ITEM;
         F : ITEM;
         R : ITEM;
         P : NodePt;
         Dp : NodePt;
      begin
         for I in reverse 1..KN loop
            put("Item: ");
            Get(J);
            Put("Comes before Item: ");
            Get(K);
            Top(J) := new Node'(Info => K, Next => Top(J));
            Count(K) := Count(K) + 1;
            Put("You have ");
            Put(I-1, 2);
            Put_Line(" partial orders left.");
         end loop;
         KN := NA;
         R := ITEM'Val(0);
         QLink(ITEM'Val(0)) := ITEM'Val(0);
         for I in ITEM'Val(1)..ITEM'Val(NA) loop
            if Count(I) = 0 then
               QLink(R) := I;
               R := I;
            end if;
         end loop;
         F := QLink(ITEM'Val(0));
         while F /= ITEM'Val(0) loop
            Put("Perform action ");
            Put(F); new_line;
            KN := KN - 1;
            P := Top(F);
            Top(F) := null;
            while P /= null loop
               Count(P.Info) := Count(P.Info) - 1;
               if Count(P.Info) = 0 then
                  QLink(R) := P.Info;
                  R := P.Info;
               end if;
               Dp := P;
               P := P.Next;
               Free(Dp);
            end loop;
            F := QLink(F);
         end loop;
         if KN = 0 then
            Put_Line("Successful Sort!");
         else
            Put_Line("Error!");
            for I in ITEM'Val(1)..ITEM'Val(NA) loop
               QLink(I) := ITEM'Val(0);
            end loop;
            for I in ITEM'Val(1)..ITEM'Val(NA) loop
               P := Top(I);
               Top(I) := null;
               while P /= null loop
                  if QLink(P.Info) = ITEM'Val(0) then
                     QLink(P.Info) := I;
                  end if;
                  Dp := P;
                  P := P.Next;
                  Free(Dp);
               end loop;
            end loop;
            K := ITEM'Val(1);
            while QLink(K) = ITEM'Val(0) loop
               K := ITEM'Succ(K);
            end loop;
            loop
               Top(K) := new Node'(Info => ITEM'Val(0), Next => null);
               K := QLink(K);
               exit when Top(K) /= null;
            end loop;
            Put("Loop Found: ");
            while Top(K) /= null loop
               Put(K);
               Put(" -> ");
               Dp := Top(K);
               Top(K) := null;
               Free(Dp);
               K := QLink(K);
            end loop;
            put(k); new_line;
         end if;
      end;
   end;
end Toposort;
