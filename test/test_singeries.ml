open OUnit2
open Singeries.Helpers

(* Test helper functions *)
let test_is_close _ = 
  assert_bool "Is close" (is_close 0. 0.00001)

(* Test suite *)
let suite = 
  "Test des singeries"
  >::: [
    "test_is_close" >:: test_is_close
  ]

let () = run_test_tt_main suite 
