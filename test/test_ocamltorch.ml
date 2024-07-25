open OUnit2
open Ocamltorch.Backprop.Value
open Singeries.Helpers

let aqe x y = assert_bool (Printf.sprintf "%f != %f" x y) (is_close ~eps:0.1 x y)

let test_backward_1 _ = 
  let a = make_value ~label:"a" 2. in 
  let b = make_value ~label:"b" 3. in 
  let c = add a (`Value b) in 
  let d = make_value ~label:"d" 6. in 
  let e = mul c (`Value d) in
  let f = mul e (`Float 4.) in 
  backward f;
  aqe a.grad 24.; 
  aqe b.grad 24.;
  aqe c.grad 24.;
  aqe d.grad 20.;
  aqe e.grad 4.;
  aqe f.grad 1.
  
let test_backward_2 _ = 
  let a = make_value ~label:"a" 3. in 
  let b = make_value ~label:"b" 2. in 
  let c = make_value ~label:"c" 1. in 
  let h = mul c (`Float 2.) in 
  let e = add b (`Value h) in 
  let f = exp e in 
  let g = mul a (`Value f) in 
  let d = mul g (`Float 4.) in 
  backward d; 
  aqe a.grad 218.4;
  aqe b.grad 655.2;
  aqe c.grad 1310.4;
  aqe d.grad 1.

let test_backward_3 _ = 
  let x1 = make_value ~label:"x1" 2. in 
  let x2 = make_value ~label:"x2" 0. in 
  let w1 = make_value ~label:"w1" (-3.) in 
  let w2 = make_value ~label:"w2" 1. in 
  let b = make_value ~label:"b" 6.88 in
  let x1w1 = mul x1 (`Value w1) in 
  let x2w2 = mul x2 (`Value w2) in
  let x1w1x2w2 = add x1w1 (`Value x2w2) in
  let n = add x1w1x2w2 (`Value b) in
  let o = tanh n in 
  backward o;
  aqe x1.grad (-1.5);
  aqe x2.grad 0.5;
  aqe w1.grad 1.;
  aqe w2.grad 0.;
  aqe x1w1.grad 0.5;
  aqe x2w2.grad 0.5;
  aqe x1w1x2w2.grad 0.5;
  aqe b.grad 0.5;
  aqe n.grad 0.5;
  aqe o.grad 1.

let suite_backprop = 
  "Test Backtrack"
  >::: [
    "test_backward_1" >:: test_backward_1;
    "test_backward_2" >:: test_backward_2;
    "test_backward_3" >:: test_backward_3
  ]

let () = run_test_tt_main suite_backprop
