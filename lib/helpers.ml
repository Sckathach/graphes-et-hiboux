open Owl
open Printf

let is_close ?(eps = 0.001) x y = Maths.abs (x -. y) < eps 

let string_of_char = String.make 1

let failwiths fmt = failwith (sprintf fmt)
