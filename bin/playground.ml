open Ocamltorch.Backprop.Value
open Singeries.Aigle

let channel = DotPerso.open_dot ~digraph:true ~rotate:true "_output/backprop.dot"
let create_edge x y = Printf.fprintf channel " %d -> %d;\n" x y 
let value_hash x = Hashtbl.hash x.label 
let operator_hash x = Hashtbl.hash (x.label ^ "_op")
let create_vertex x = 
  Printf.fprintf channel " %d [label=\"{%s | data %.2f | grad %.2f}\"] [shape=record];\n" (value_hash x) x.label x.data x.grad ;
  if x._op <> "" then 
    begin 
      Printf.fprintf channel " %d [label=\"%s\"] [shape=circle];\n" (operator_hash x) x._op ;
      create_edge (operator_hash x) (value_hash x)
    end 

let print_dot root = 
  let nodes = Hashtbl.create 10 in 
  let edges = Hashtbl.create 20 in 
  let rec aux prev v =
    if not (Hashtbl.mem nodes v) then 
      create_vertex v ;
    if not (Hashtbl.mem edges (v, prev)) then 
      create_edge (value_hash v) (operator_hash prev) ; 
    List.iter (aux v) v._prev in 
  create_vertex root ;
  List.iter (aux root) root._prev

let x1 = make_value ~label:"x1" 2. 
let x2 = make_value ~label:"x2" 0. 
let w1 = make_value ~label:"w1" (-3.)
let w2 = make_value ~label:"w2" 1. 
let b = make_value ~label:"b" 6.88 
let x1w1 = mul x1 (`Value w1) 
let x2w2 = mul x2 (`Value w2) 
let x1w1x2w2 = add x1w1 (`Value x2w2) 
let n = add x1w1x2w2 (`Value b) 
let o = tanh n ;;

print_dot o ;;

DotPerso.close_dot channel ;;  

print_endline "Bonsoir ! "

