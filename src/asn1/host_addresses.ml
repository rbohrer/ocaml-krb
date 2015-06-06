open Import

(* Always used as on optional field - only use if nonempty *)
type t = Host_address.t list

module Format = struct
  type t = Host_address.Format.t list

  let asn = sequence_of Host_address.Format.asn
end

let format_of_t t =
  match t with
  | [] -> failwith "Bug in ASN1 library: tried to use empty host_addresses"
  | lst -> List.map Host_address.format_of_t lst
