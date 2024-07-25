open Hibou
open Graph
open Owl 

module A = struct 
  (**
    This is the base module for adjacency matrices.
    *)

  (** Creates an empty sqared dense matrix of floats. *)
  let empty_square n = Arr.init [| n; n |] (fun _ -> 0.)

  (** Computes the eigenvector centrality of the graph given its adjacency matrix. *)
  let eigen_centrality a = 
    let eigvec, _ = Linalg.D.eig a in 
    Dense.Matrix.Z.col eigvec 0 
end 

module C = struct 
  (**
    This is the modules for all the computations on the graph itself.
    *)

  (** Defines the edges weights to be all equal to 1 *)
  module PathWeight = struct 
    type edge = G.E.t 
    type t = int 
    let weight _ = 1
    let zero = 0
    let add = (+)
    let sub = (-)
    let compare = Stdlib.compare
  end 

  (** Computes Dijkstra's algorithm for the given graph structure: undirected with all the edges' weights equal to 1 *)
  module Dij = Path.Dijkstra(G)(PathWeight)

  (** Computes the closeness centrality of a node in the graph. *)
  let closeness g v = 
    let sum = ref 0. in 
    G.iter_vertex (fun x -> 
        let (_, d) = Dij.shortest_path g v x in 
        if d != 0 then 
          sum := !sum +. 1. /. (float_of_int d)
    ) g;
    1. /. (float_of_int (G.nb_edges g - 1)) *. !sum
end 
