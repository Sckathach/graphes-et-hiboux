(*
   The owl to protect the code from bugs

       ^...^
      / o,o \
      |):::(|
    ====w=w===
*)

open Singeries.Hibou
open Singeries.Helpers
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
