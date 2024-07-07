(** Graph definition *)

open Graph
open Owl

module G = struct 
  (**
    The chosen structure for the graph is a permanant concrete graph with intergers as vertices and non-labelled edges. 
   *)
  module Node = struct 
    type t = int 
    let compare = Stdlib.compare 
    let hash = Hashtbl.hash 
    let equal = (=)
    let default = 0 
  end
  
  include Persistent.Graph.Concrete(Node)

  (** Add multiple vertices with a list *)
  let add_vertices l g = 
    let rec aux l g = match l with  
      [] -> g 
      | x :: q -> add_vertex g x |> aux q 
    in aux l g 

  (** Add multiple edges with a list *)
  let add_edges l g = 
    let rec aux l g = match l with  
      [] -> g 
      | (x, y) :: q -> add_edge g x y |> aux q 
    in aux l g 

  (** Create the adjacency matrix from the Graph *)
  let adjacency_matrix g = 
    let n = nb_vertex g in 
    let arr = Arr.init [| n; n |] (fun _ -> 0.) in
    let aux = fun x -> fun y -> Arr.set arr [| x; y |] 1.; Arr.set arr [| y; x |] 1. in 
    iter_edges aux g; 
    arr
end
