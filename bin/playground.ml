open Ocamltorch.Backprop.Value

let x1 = make_value ~label:"x1" 2. 
let x2 = make_value ~label:"x2" 0. 
let w1 = make_value ~label:"w1" (-3.)
let w2 = make_value ~label:"w2" 1. 
let b = make_value ~label:"b" 6.88 

let x1w1 = x1 *.. w1
let x2w2 = x2 *.. w2 
let x1w1x2w2 = x1w1 +.. x2w2 
let n = x1w1x2w2 +.. b 
let o = tanh n 

let () = 
  backward o;
  print_dot o
