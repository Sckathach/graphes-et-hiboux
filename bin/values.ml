open Ocamltorch.Backtrack.Value
open Printf


(* Tests with + and * *)
let a = make_value ~label:"a" 2. 
let b = make_value ~label:"b" 3. 
let c = add a (`Value b) 
let d = make_value ~label:"d" 6. 
let e = mul c (`Value d)
let f = mul e (`Float 4.);;
backward f;;
printf "Gradient of a: %f = 24\n" a.grad;
printf "Gradient of b: %f = 24\n" b.grad;
printf "Gradient of c: %f = 24\n" c.grad;
printf "Gradient of d: %f = 20\n" d.grad;
printf "Gradient of e: %f = 4\n" e.grad;
printf "Gradient of f: %f = 1\n" f.grad

(* Tests with exp *)
let a = make_value ~label:"a" 3. 
let b = make_value ~label:"b" 2. 
let c = make_value ~label:"c" 1. 
let h = mul c (`Float 2.)
let e = add b (`Value h)
let f = exp e 
let g = mul a (`Value f)
let d = mul g (`Float 4.);;
backward d;;
printf "Gradient of a: %f = 4e^(b+2c)\n" a.grad;
printf "Gradient of b: %f = 4*3e^(b+2c)\n" b.grad;
printf "Gradient of c: %f = 2*4*3e^(b+2c)\n" c.grad;
printf "Gradient of d: %f = 1\n" d.grad;;

(* Tests with tanh *)
let x1 = make_value ~label:"x1" 2. 
let x2 = make_value ~label:"x2" 0. 
let w1 = make_value ~label:"w1" (-3.) 
let w2 = make_value ~label:"w2" 1. 
let b = make_value ~label:"b" 6.88 
let x1w1 = mul x1 (`Value w1) 
let x2w2 = mul x2 (`Value w2)
let x1w1x2w2 = add x1w1 (`Value x2w2)
let n = add x1w1x2w2 (`Value b)
let o = tanh n;;
backward o;;
printf "Gradient of x1: %f = -1.5\n" x1.grad;
printf "Gradient of x2: %f = 0.5\n" x2.grad;
printf "Gradient of w1: %f = 1.0\n" w1.grad;
printf "Gradient of w2: %f = 0.0\n" w2.grad;
printf "Gradient of x1w1: %f = 0.5\n" x1w1.grad;
printf "Gradient of x2w2: %f = 0.5\n" x2w2.grad;
printf "Gradient of x1w1x2w2: %f = 0.5\n" x1w1x2w2.grad;
printf "Gradient of b: %f = 0.5\n" b.grad;
printf "Gradient of n: %f = 0.5\n" n.grad;
printf "Gradient of o: %f = 1\n" o.grad;;


let a = make_value 3. 
let b = make_value 1. 
let c = a +.. b
