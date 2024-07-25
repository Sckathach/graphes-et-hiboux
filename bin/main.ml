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

let clustering_coefficient g target = 
  let neighbours = G.succ g target in 
  let d = float_of_int (List.length neighbours) in 
  let rec aux acc v = function
    [] -> acc
    | x :: q -> 
      try 
        begin
          let _ = G.find_edge g v x in 
          aux (acc + 1) v q
        end
      with Not_found -> aux acc v q in 
  let rec aux2 = function 
    [] -> 0 
    | x :: q -> (aux 0 x neighbours) + (aux2 q) in 
  (float_of_int (aux2 neighbours)) /. (d *. (d -. 1.)) 

