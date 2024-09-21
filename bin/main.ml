(*
   The owl to protect the code from bugs

       ^...^
      / o,o \
      |):::(|
    ====w=w===
*)

(* open Singeries.Hibou *)
(* open Singeries.Helpers *)
(* open Singeries.Aigle *)
(**)
(* module N = Neo(struct *)
(*   let url = "http://localhost:7474/db/neo4j/tx/commit"  *)
(*   let username = "neo4j" *)
(*   let password = "cameleon" *)
(* end) *)
(**)
(* let g = G.empty  *)
(*   |> G.add_vertices (range 14) *)
(*   |> G.add_edges [ *)
(*     (0, 1); (0, 2); (0, 3); *)
(*     (1, 2); (1, 7); *)
(*     (2, 3); (2, 4); *)
(*     (3, 14);  *)
(*     (4, 5); *)
(*     (5, 6); (5, 14); (5, 13); (5, 9); (5, 11);  *)
(*     (6, 7);  *)
(*     (7, 8);  *)
(*     (9, 10);  *)
(*     (11, 12) *)
(*   ]  *)
(**)
(* let clustering_coefficient g target =  *)
(*   let neighbours = G.succ g target in  *)
(*   let d = float_of_int (List.length neighbours) in  *)
(*   let rec aux acc v = function *)
(*     [] -> acc *)
(*     | x :: q ->  *)
(*       try  *)
(*         begin *)
(*           let _ = G.find_edge g v x in  *)
(*           aux (acc + 1) v q *)
(*         end *)
(*       with Not_found -> aux acc v q in  *)
(*   let rec aux2 = function  *)
(*     [] -> 0  *)
(*     | x :: q -> (aux 0 x neighbours) + (aux2 q) in  *)
(*   (float_of_int (aux2 neighbours)) /. (d *. (d -. 1.))  *)


  
open Ocamltorch.Backprop.Value
open Singeries.Aigle


let channel = DotPerso.open_dot "_output/backprop.dot"
let create_edge x y = Printf.fprintf channel " %s -> %s;\n" x.label y.label 
let create_vertex x = Printf.fprintf channel " %s [shape=circle];\n" x.label

let print_dot root = 
  let nodes = Hashtbl.create 10 in 
  let edges = Hashtbl.create 20 in 
  let rec aux prev v =
    if not (Hashtbl.mem nodes v) then 
      create_vertex v; 
    if not (Hashtbl.mem edges (v, prev)) then 
      create_edge v prev; 
    List.iter (aux v) v._prev in 
  create_vertex root;
  List.iter (aux root) root._prev

let x1 = make_value ~label:"x1" 2. 
let x2 = make_value ~label:"x2" 0. 
let w1 = make_value ~label:"w1" (-3.)
let w2 = make_value ~label:"w2" 1. 
let b = make_value ~label:"b" 6.88 
let x1w1 = mul x1 (`Value w1) 
let x2w2 = mul x2 (`Value w2) 
let x1w1x2w2 = add x1w1 (`Value x2w2) 
let n = add x1w1x2w2 (`Value b) 
let o = tanh n ;;

print_dot o ;; 



print_endline "Bonjour!"
