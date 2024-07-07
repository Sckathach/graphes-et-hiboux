(*
    The owl to protect the code from bugs

       ^...^
      / o,o \
      |):::(|
    ====w=w===
*)

open Graph
open Singeries.Hibou
open Singeries.Chouette
open Singeries.Aigle

let range n = 
  let rec aux n l = match n with 
    x -> if x >= 0 then aux (n - 1) (x :: l) else l 
  in aux n []

let g = G.empty 
  |> G.add_vertices (range 14)
  |> G.add_edges [
    (0, 1); (0, 2); (0, 3);
    (1, 2); (1, 7);
    (2, 3); (2, 4);
    (3, 14); 
    (4, 5);
    (5, 6); (5, 14); (5, 13); (5, 9); (5, 11); 
    (6, 7); 
    (7, 8); 
    (9, 10); 
    (11, 12)
  ]
let a = G.adjacency_matrix g
let c = A.closeness a
let () = print_endline "Bonsoir"

let () = graph_to_dot g
