open Hibou

module Dot = struct 
  module NeatoAttr = struct 
    include G 
    let edge_attributes (_, _) = [] 
    let default_edge_attributes _ = []
    let get_subgraph _ = None 
    let vertex_attributes _ = [`Shape `Box]
    let vertex_name v = string_of_int v 
    let default_vertex_attributes _ = []
    let graph_attributes _ = []
  end 
  include Graph.Graphviz.Neato(NeatoAttr)

  let graph_to_dot ?(filename = "_output/graph.dot") g =
    let file = open_out_bin filename in 
    output_graph file g 
end 

module DotPerso = struct 
  let open_dot ?(digraph = false) ?(rotate = false) filename = 
    let out_channel = open_out filename in 
    if digraph then Printf.fprintf out_channel "digraph G {\n"
    else Printf.fprintf out_channel "graph G {\n";
    if rotate then Printf.fprintf out_channel "rankdir=\"LR\"\n";
    out_channel

  let close_dot channel = 
    Printf.fprintf channel "}\n";
    close_out channel

  let graph_to_dot ?(filename = "_output/graph.dot") g =  
    let channel = open_dot filename in 
    G.iter_vertex (fun x -> Printf.fprintf channel " %d [shape=circle];\n" x) g; 
    G.iter_edges (fun x -> fun y -> Printf.fprintf channel " %d -- %d;\n" x y) g;
    close_dot channel
end 

module type NEO_PARAMS = sig
  val url : string 
  val username : string 
  val password : string 
end

module Neo (Params : NEO_PARAMS) = struct 
  open Lwt 
  open Cohttp
  open Cohttp_lwt_unix

  let auth = Base64.encode_exn (Params.username ^ ":" ^ Params.password)

  let post_request body_str =
    let uri = Uri.of_string Params.url in

    let headers = Header.init ()
      |> fun h -> Header.add h "Accept" "application/json;charset=UTF-8"
      |> fun h -> Header.add h "Content-Type" "application/json"
      |> fun h -> Header.add h "Authorization" ("Basic " ^ auth) in

    let body = Cohttp_lwt.Body.of_string body_str in
    Client.post ~headers ~body uri >>= fun (resp, body) ->
      let code = resp |> Response.status |> Code.code_of_status in
      Cohttp_lwt.Body.to_string body >>= fun body ->
        Lwt_io.printf "Response code: %d\nBody:\n%s\n" code body

  let add_node tag =
    let body_str = Yojson.Basic.to_string (`Assoc [
      ("statements", `List [
        `Assoc [
          ("statement", `String "MERGE (n:Node {id: $id}) SET n.tag = $tag RETURN n");
          ("parameters", `Assoc [
            ("id", `Int (Hashtbl.hash tag));
            ("tag", `String tag)
          ])
        ]
      ])
    ]) in
    post_request body_str

  let add_edge tag1 tag2 =
    let body_str = Yojson.Basic.to_string (`Assoc [
      ("statements", `List [
        `Assoc [
          ("statement", `String "MATCH (a:Node {id: $id1}), (b:Node {id: $id2}) MERGE (a)-[:Edge]->(b) RETURN a, b");
          ("parameters", `Assoc [
            ("id1", `Int (Hashtbl.hash tag1));
            ("id2", `Int (Hashtbl.hash tag2))
          ])
        ]
      ])
    ]) in
    post_request body_str

  let vertices_to_neo4j = G.iter_vertex (fun x -> Lwt_main.run (add_node (string_of_int x))) 
  let edges_to_neo4j = 
    G.iter_edges (fun x -> fun y -> 
      Lwt_main.run (add_edge (string_of_int x) (string_of_int y)); 
      Lwt_main.run (add_edge (string_of_int y) (string_of_int x))
    )
  let to_neo4j g = vertices_to_neo4j g; edges_to_neo4j g
end


