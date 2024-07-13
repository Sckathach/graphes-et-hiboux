(*
    The owl to protect the code from bugs

       ^...^
      / o,o \
      |):::(|
    ====w=w===
*)


open Singeries.Aigle
module N = Neo(struct
  let url = "http://localhost:7474/db/neo4j/tx/commit" 
  let username = "neo4j"
  let password = "cameleon"
end)

let () =
  Lwt_main.run (N.add_node "test3");
  Lwt_main.run (N.add_edge "test3" "test2")



(* open Graph *)
(* open Singeries.Hibou *)
(* open Singeries.Helpers *)
(* open Singeries.Chouette *)
(* open Singeries.Aigle *)
(**)
(* let g = G.empty  *)
(*   |> G.add_vertices (range 14) *)
(*   |> G.add_edges [ *)
(*     (0, 1); (0, 2); (0, 3); *)
(*     (1, 2); (1, 7); *)
(*     (2, 3); (2, 4); *)
(*     (3, 14);  *)
(*     (4, 5); *)
(*     (5, 6); (5, 14); (5, 13); (5, 9); (5, 11);  *)
(*     (6, 7);  *)
(*     (7, 8);  *)
(*     (9, 10);  *)
(*     (11, 12) *)
(*   ] *)
(* let a = G.adjacency_matrix g *)
(* let c = A.closeness a *)
(**)
(* let () = print_endline "Bonsoir" *)
(* let () = graph_to_dot g *)
(* open Lwt.Infix *)
(* open Cohttp *)
(* open Cohttp_lwt_unix *)
(**)
(* let post_request url body_str = *)
(*   let uri = Uri.of_string url in *)
(*   let headers = Header.init () *)
(*                 |> fun h -> Header.add h "Accept" "application/json;charset=UTF-8" *)
(*                 |> fun h -> Header.add h "Content-Type" "application/json" *)
(*                 |> fun h -> Header.add h "Authorization" "Basic bmVvNGo6Y2FtZWxlb24=" in *)
(*   let body = Cohttp_lwt.Body.of_string body_str in *)
(*   Client.post ~headers ~body uri >>= fun (resp, body) -> *)
(*   let code = resp |> Response.status |> Code.code_of_status in *)
(*   Cohttp_lwt.Body.to_string body >>= fun body -> *)
(*   Lwt_io.printf "Response code: %d\nBody:\n%s\n" code body *)
(**)
(* let () = *)
(*   let url = "http://localhost:7474/db/neo4j/tx/commit" in *)
(*   let body_str =  *)
(*     "{\"statements\": [{\"statement\": \"match (n) return n\"}]}"  *)
(*   in *)
(*   Lwt_main.run (post_request url body_str) *)
