let rec next_readings prev = 
  let rec inner prev rest acc = match rest with
  | [] -> acc
  | x :: xs -> inner x xs ((x-prev) :: acc) in
  let first, rest = match prev with
  | x :: xs -> x, xs
  | _ -> raise (Failure "") in
  List.rev (inner first rest []) in

let rec rec_reading readings = 
  if List.for_all (fun a -> a = 0) readings then (0, 0) else
    let new_redings = next_readings readings in
    let front, back = rec_reading new_redings in
    print_endline (string_of_int back);
    List.hd readings - front, (readings |> List.rev |> List.hd) + back in

let lines = ref [] in
let in_file = open_in "../inputs/dec9.input" in
try
  while true do
    lines := (input_line in_file) :: !lines
  done with End_of_file -> ();
let lines = List.rev !lines in
close_in in_file;

let calc_line line =
  String.split_on_char ' ' line
  |> List.map (fun a -> int_of_string a)
  |> rec_reading in

let (sum_front, sum_back) = List.map calc_line lines 
|> List.fold_left (fun (f1, b1) (f2, b2) -> (f1 + f2, b1 + b2)) (0, 0) in

print_endline ("Part 1: " ^ string_of_int sum_back);
print_endline ("Part 2: " ^ string_of_int sum_front);