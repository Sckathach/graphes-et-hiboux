open Graph
open Hibou

module Dot = Graph.Graphviz.Dot(struct
  include G 
  let edge_attributes (_, _) = [] 
  let default_edge_attributes _ = []
  let get_subgraph _ = None 
  let vertex_attributes _ = [`Shape `Box]
  let vertex_name v = string_of_int v 
  let default_vertex_attributes _ = []
  let graph_attributes _ = []
end)

let graph_to_dot ?(filename = "_output/graph.dot") g =
  let file = open_out_bin filename in 
  Dot.output_graph file g 
