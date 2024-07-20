open Ocamltorch.Backtrack
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
printf "Gradient of d: %f = 1\n" d.grad;

