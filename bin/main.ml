(*
    The owl to protect the code from bugs

       ^...^
      / o,o \
      |):::(|
    ====w=w===
*)

open Graph
open Singeries.Hibou
open Singeries.Helpers
open Singeries.Chouette
open Singeries.Aigle

module N = Neo(struct
  let url = "http://localhost:7474/db/neo4j/tx/commit" 
  let username = "neo4j"
  let password = "cameleon"
end)

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
  |> graph_to_dot_alt 

(* let () =  *)
(*   let filename = "_output/graph.dot" in  *)
(*   let out_channel = open_out filename in  *)
(*   Printf.fprintf out_channel "graph G {\n"; *)
(*   G.iter_vertex (fun x -> Printf.fprintf out_channel " %d [shape=circle];\n" x) g;  *)
(*   G.iter_edges (fun x -> fun y -> Printf.fprintf out_channel " %d -- %d;\n" x y) g; *)
(*   Printf.fprintf out_channel "}\n"; *)
(*   close_out out_channel *)

