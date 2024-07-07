open Owl

module A = struct 
  (**
    This is the base module for adjacency matrices.
   *)

  (** Creates an empty sqared dense matrix of floats. *)
  let empty_square n = Arr.init [| n; n |] (fun _ -> 0.)

  (** Computes the closeness of the graph given its adjacency matrix. *)
  let closeness a = 
    let eigvec, _ = Linalg.D.eig a in 
    Dense.Matrix.Z.col eigvec 0 
end 
