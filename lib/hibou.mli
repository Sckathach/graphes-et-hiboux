open Owl

module G :
  sig
    module Node :
      sig
        type t = int
        val compare : 'a -> 'a -> t
        val hash : 'a -> t
        val equal : 'a -> 'a -> bool
        val default : t
      end
    
    type t = Graph__Persistent.Graph.Concrete(Node).t
    module V :
      sig
        type t = int
        val compare : t -> t -> t
        val hash : t -> t
        val equal : t -> t -> bool
        type label = t
        val create : t -> t
        val label : t -> t
      end

    type vertex = int
    module E :
      sig
        type t = vertex * vertex
        val compare : t -> t -> vertex
        type vertex = int
        val src : t -> vertex
        val dst : t -> vertex
        type label = unit
        val create : vertex -> label -> vertex -> t
        val label : t -> label
      end

    type edge = E.t
    val is_directed : bool
    val is_empty : t -> bool
    val nb_vertex : t -> vertex
    val nb_edges : t -> vertex
    val out_degree : t -> vertex -> vertex
    val in_degree : t -> vertex -> vertex
    val mem_vertex : t -> vertex -> bool
    val mem_edge : t -> vertex -> vertex -> bool
    val mem_edge_e : t -> edge -> bool
    val find_edge : t -> vertex -> vertex -> edge
    val find_all_edges : t -> vertex -> vertex -> edge list
    val succ : t -> vertex -> vertex list
    val pred : t -> vertex -> vertex list
    val succ_e : t -> vertex -> edge list
    val pred_e : t -> vertex -> edge list
    val iter_vertex : (vertex -> unit) -> t -> unit
    val fold_vertex : (vertex -> 'a -> 'a) -> t -> 'a -> 'a
    val iter_edges : (vertex -> vertex -> unit) -> t -> unit
    val fold_edges : (vertex -> vertex -> 'a -> 'a) -> t -> 'a -> 'a
    val iter_edges_e : (edge -> unit) -> t -> unit
    val fold_edges_e : (edge -> 'a -> 'a) -> t -> 'a -> 'a
    val map_vertex : (vertex -> vertex) -> t -> t
    val iter_succ : (vertex -> unit) -> t -> vertex -> unit
    val iter_pred : (vertex -> unit) -> t -> vertex -> unit
    val fold_succ : (vertex -> 'a -> 'a) -> t -> vertex -> 'a -> 'a
    val fold_pred : (vertex -> 'a -> 'a) -> t -> vertex -> 'a -> 'a
    val iter_succ_e : (edge -> unit) -> t -> vertex -> unit
    val fold_succ_e : (edge -> 'a -> 'a) -> t -> vertex -> 'a -> 'a
    val iter_pred_e : (edge -> unit) -> t -> vertex -> unit
    val fold_pred_e : (edge -> 'a -> 'a) -> t -> vertex -> 'a -> 'a
    val empty : t
    val add_vertex : t -> vertex -> t
    val remove_vertex : t -> vertex -> t
    val add_edge : t -> vertex -> vertex -> t
    val add_edge_e : t -> edge -> t
    val remove_edge : t -> vertex -> vertex -> t
    val remove_edge_e : t -> edge -> t
    val add_vertices : vertex list -> t -> t
    val add_edges : (vertex * vertex) list -> t -> t
    val adjacency_matrix : t -> Arr.arr
  end
