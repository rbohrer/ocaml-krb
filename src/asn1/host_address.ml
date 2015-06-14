open Import

type t =
  { addr_type : Address_type.t
  ; address : Octet_string.t
  }

module Format = struct
  type t = Address_type.Format.t * Cstruct.t

  let asn =
    (sequence2
       (tag_required 0 ~label:"addr_type" Address_type.Format.asn)
       (tag_required 1 ~label:"address" Octet_string.Format.asn))
end

let format_of_t t =
  ( Address_type.format_of_t t.addr_type
  , Octet_string.format_of_t t.address )
