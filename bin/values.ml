open Ocamltorch.Backtrack
open Printf


(* Tests with + and * *)
let a = make_value ~label:"a" 2.0 
let b = make_value ~label:"b" 3.0 
let c = add a (`Value b) 
let d = make_value ~label:"d" 6.0 
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

