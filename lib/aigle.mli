open Hibou

module Dot :
  sig
    module NeatoAttr :
      sig
        type t = G.t
        type vertex = int
        val edge_attributes : 'a * 'b -> 'c list
        val default_edge_attributes : 'a -> 'b list
        val get_subgraph : 'a -> 'b option
        val vertex_attributes : 'a -> [> `Shape of [> `Box ] ] list
        val vertex_name : vertex -> string
        val default_vertex_attributes : 'a -> 'b list
        val graph_attributes : 'a -> 'b list
      end
    val set_command : string -> unit
    exception Error of string
    val handle_error : ('a -> 'b) -> 'a -> 'b
    val fprint_graph : Format.formatter -> NeatoAttr.t -> unit
    val output_graph : out_channel -> NeatoAttr.t -> unit
    val graph_to_dot : ?filename:string -> NeatoAttr.t -> unit
  end

module DotPerso : sig val graph_to_dot : ?filename:string -> G.t -> unit end 

module type NEO_PARAMS =
  sig val url : string val username : string val password : string end

module Neo :
  functor (_ : NEO_PARAMS) ->
    sig
      val auth : string
      val post_request : string -> unit Lwt.t
      val add_node : string -> unit Lwt.t
      val add_edge : 'a -> 'b -> unit Lwt.t
      val vertices_to_neo4j : G.t -> unit
      val edges_to_neo4j : G.t -> unit
      val to_neo4j : G.t -> unit
    end
