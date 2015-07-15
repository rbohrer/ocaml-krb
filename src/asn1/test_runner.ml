open Import;;

let all_types = Types.all

let count_occurrences lst x =
  List.length (List.filter (fun y -> x = y) lst)

let run () =
  let encoding_rules = [Asn.ber; Asn.der] in
  let results =
    List.map (fun tp ->
      let module Type = (val tp : Asn1_intf.S) in
      let asn = Type.Format.asn in
      let codecs = List.map (fun er -> Asn.codec er asn) encoding_rules in
      let input = Asn.random asn in
      let test_results =
        List.map (fun codec ->
          match Asn.decode codec (Asn.encode codec input) with
          | Some (x, _) -> x = input
          | _ -> false)
          codecs
      in
      List.for_all (fun x -> x) test_results)
      all_types
  in
  Printf.printf "%d tests run, %d succeeded, %d failed\n"
    (List.length all_types)
    (count_occurrences results true)
    (count_occurrences results false)

let () = run ()
