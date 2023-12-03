let part1 () =
  let lines = ref [] in
  let in_file = open_in "../inputs/dec2.input" in
  try
    while true do
      lines := (input_line in_file) :: !lines
    done with End_of_file -> ();
  let lines = List.rev !lines in
  close_in in_file;

  let configuration color = match color with
  | "red" -> 12
  | "green" -> 13
  | "blue" -> 14
  | _ -> raise (Failure "Unknown color")
  in

  let rec rec_lines lines = match lines with
    | [] -> 0
    | line :: rest -> 
      let split = String.split_on_char ':' line in
      let before_colon = List.nth split 0 in
      let game_num = int_of_string(List.nth (String.split_on_char ' ' before_colon) 1) in

      let after_colon = List.nth split 1 in
      let rounds = String.split_on_char ';' after_colon in
      let validate_draw s = 
        let s = String.trim s |> String.split_on_char ' ' in
        let num = int_of_string(List.nth s 0) in
        let color = List.nth s 1 in
        configuration color >= num
      in
      let rec handle_round rounds = match rounds with
      | [] -> true
      | round :: rest ->
        let draws = String.split_on_char ',' round in
        let valid = List.for_all validate_draw draws in
        if valid then handle_round rest else false
      in

      let valid = handle_round rounds in

      let recurse = rec_lines rest in
      recurse + if valid then game_num else 0
    in
  
  let sum = rec_lines lines in
  print_endline ("Part 1: " ^ (string_of_int sum));
in

let part2 () =
  let lines = ref [] in
  let in_file = open_in "../inputs/dec2.input" in
  try
    while true do
      lines := (input_line in_file) :: !lines
    done with End_of_file -> ();
  let lines = List.rev !lines in
  close_in in_file;

  let rec rec_lines lines = match lines with
    | [] -> 0
    | line :: rest -> 
      let split = String.split_on_char ':' line in

      let after_colon = List.nth split 1 in
      let rounds = String.split_on_char ';' after_colon in
      let parse_draw s = 
        let s = String.trim s |> String.split_on_char ' ' in
        let num = int_of_string(List.nth s 0) in
        let color = List.nth s 1 in
        if color = "red" then (num, 0, 0) else
        if color = "green" then (0, num, 0) else
        if color = "blue" then (0, 0, num) else 
          failwith "Unknown color"
      in
      let combine_triples (x, y,z) (r, g, b) = 
        (max x r, max y g, max z b)
      in
      let rec combine_triple_list triples abc = match triples with 
      | [] -> abc
      | rgb :: rest -> combine_triple_list rest (combine_triples rgb abc)
      in
      let rec handle_rounds rounds triple = match rounds with
      | [] -> let (r, g, b) = triple in r*g*b
      | round :: rest ->
        let draws = String.split_on_char ',' round in
        let triples = List.map parse_draw draws in
        let triple = combine_triple_list triples triple in
        handle_rounds rest triple
      in

      let sum = handle_rounds rounds (0, 0, 0) in

      let recurse = rec_lines rest in
      recurse + sum
    in
  
  let sum = rec_lines lines in
  print_endline ("Part 2: " ^ (string_of_int sum));
in

part1 ();
part2 ()
