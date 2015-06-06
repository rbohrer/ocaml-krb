open Import

(* CR bbohrer: This should probably be a variant type,
   or at least maybe address should be a different type *)
type t =
  { addr_type : Address_type.t
  ; address : string
  }

module Format = struct
  type t = Address_type.Format.t * Cstruct.t

  let asn =
    (sequence2
       (tag_required 0 ~label:"addr_type" Address_type.Format.asn)
       (tag_required 1 ~label:"address" octet_string))
end

let format_of_t t =
  ( Address_type.format_of_t t.addr_type
  , Cstruct.of_string t.address )
