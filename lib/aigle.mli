open Hibou

module Dot :
  sig
    val set_command : string -> unit
    exception Error of string
    val handle_error : ('a -> 'b) -> 'a -> 'b
    val fprint_graph : Format.formatter -> G.t -> unit
    val output_graph : out_channel -> G.t -> unit
  end

val graph_to_dot_alt : ?filename:string -> G.t -> unit 
val graph_to_dot : ?filename:string -> G.t -> unit 

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
