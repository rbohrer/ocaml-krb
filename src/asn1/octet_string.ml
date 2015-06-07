(* CR bbohrer: replace all octet_string's with this*)

open Import

type t = string

module Format = struct
  type t = Cstruct.t

  let asn = octet_string
end

let format_of_t = Cstruct.of_string
