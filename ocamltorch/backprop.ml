open Owl
open Printf 

module Value = struct 
  type t = {
    mutable data : float; 
    mutable grad : float; 
    mutable _backward : unit -> unit; 
    _prev : t list; 
    _op : string; 
    label : string; 
  }

  let make_value ?(label="") ?(children=[]) ?(op="") data = {
    data = data;
    grad = 0.0 ;
    _backward = (fun () -> ());
    _prev = children; 
    _op = op; 
    label = label; 
  }

  let string_of_value v = 
    sprintf "%f" v.data

  let add a b = 
    let b = match b with 
      | `Value b -> b 
      | `Float x -> make_value x in 
    let out = make_value ~children:[a; b] (a.data +. b.data) ~op:"+" ~label:(a.label ^ "+" ^ b.label) in 
    let _backward () = 
      a.grad <- a.grad +. 1. *. out.grad; 
      b.grad <- b.grad +. 1. *. out.grad in 
    out._backward <- _backward;
    out 

  let mul a b = 
    let b = match b with 
      | `Value b -> b 
      | `Float x -> make_value x in 
    let out = make_value ~children:[a; b] (a.data *. b.data) ~op:"*" ~label:(a.label ^ "*" ^ b.label) in 
    let _backward () = 
      a.grad <- a.grad +. b.data *. out.grad;
      b.grad <- b.grad +. a.data *. out.grad in 
    out._backward <- _backward;
    out 

  let neg a = 
    mul a (`Float (-1.))

  let tanh a =
    let x = a.data in
    let t = (Maths.exp (2.0 *. x) -. 1.0) /. (Maths.exp (2.0 *. x) +. 1.0) in
    let out = make_value ~children:[a] t ~op:"tanh" ~label:(a.label ^ "tanh") in
    let _backward () =
      a.grad <- a.grad +. (1.0 -. t ** 2.0) *. out.grad;
    in
    out._backward <- _backward;
    out

  let exp a =
    let x = a.data in
    let out = make_value ~children:[a] (Maths.exp x) ~op:"exp" ~label:("exp" ^ a.label ) in
    let _backward () =
      a.grad <- a.grad +. out.data *. out.grad;
    in
    out._backward <- _backward;
    out

  let pow a b =
    let out = make_value ~children:[a] (a.data ** b) ~op:(sprintf "**%f" b) ~label:(a.label ^ "**" ^ string_of_float b) in
    let _backward () =
      a.grad <- a.grad +. b *. out.grad *. (a.data ** (b -. 1.0));
    in
    out._backward <- _backward;
    out

  let backward v = 
    let rec aux = function
      [] -> ()
      | x :: q -> x._backward (); aux (q @ x._prev)
    in 
      v.grad <- 1.0;
      aux [v]

  let (+..) x y = add x (`Value y) 
  let (-..) x y = add x (`Value (neg y))
  let ( *.. ) x y = mul x (`Value y)
end 