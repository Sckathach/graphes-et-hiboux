open OUnit2
open Hibou.Digraph
open Hibou.Chouette

(* Helper function to create a graph with some nodes and edges *)
let create_sample_graph () =
  let g = empty in
  let g = add_nodes [ 0; 1; 2; 3; 4 ] g in
  let edges = [ (0, 1, 2.); (1, 2, 3.); (0, 2, 4.); (2, 3, 1.); (3, 4, 5.) ] in
  add_edges_weighted edges g

(* Test adding nodes to the graph *)
let test_add_node _ =
  let g = empty |> add_node 1 in
  assert_equal [ 1 ] g.nodes

(* Test adding an edge to the graph *)
let test_add_edge _ =
  let g = empty |> add_node 1 |> add_node 2 |> add_edge 1 2 ~w:1. in
  assert_equal 1 (List.length g.edges);
  assert_equal 1. (List.hd g.edges).weight

(* Test finding edges connected to a node *)
let test_find_edges _ =
  let g = create_sample_graph () in
  assert_equal 2 (List.length (find_edges 0 g))

(* Test breadth-first search *)
let test_bfs _ =
  let g = create_sample_graph () in
  let visited = bfs 2 g in
  assert_equal [ 0; 1; 2; 3; 4 ] (List.sort compare visited)

(* Test adding multiple edges at once *)
let test_add_edges _ =
  let g = empty |> add_nodes [ 1; 2; 3 ] |> add_edges [ (1, 2); (2, 3) ] in
  assert_equal 2 (List.length g.edges);
  (* Ensure the edges are correctly added *)
  let has_edge n1 n2 =
    List.exists (fun e -> e.from_ = n1 && e.to_ = n2) g.edges
  in
  assert_bool "Edge 1->2 exists" (has_edge 1 2);
  assert_bool "Edge 2->3 exists" (has_edge 2 3)

(* Test finding adjacent nodes *)
let test_adjacent _ =
  let g = create_sample_graph () in
  let adj = adjacent 1 g in
  assert_equal [ 2; 3 ] (List.sort compare adj)

(* Test retrieving the weight of an edge *)
let test_edge_weight _ =
  let g = create_sample_graph () in
  let weight = edge_weight 1 2 g in
  assert_equal (Some 2.0) weight

(* Test Dijkstra's algorithm for shortest paths *)
let test_dijkstra _ =
  let g = create_sample_graph () in
  let dist, _ = dijkstra 1 g in
  let dist_to_5 = Hashtbl.find dist 5 in
  assert_equal 10. dist_to_5

let suite =
  "GraphTests"
  >::: [
         "test_add_node" >:: test_add_node;
         "test_add_edge" >:: test_add_edge;
         "test_find_edges" >:: test_find_edges;
         "test_bfs" >:: test_bfs;
         "test_add_edges" >:: test_add_edges;
         "test_adjacent" >:: test_adjacent;
         "test_edge_weight" >:: test_edge_weight;
         "test_dijkstra" >:: test_dijkstra;
       ]

let () = run_test_tt_main suite
