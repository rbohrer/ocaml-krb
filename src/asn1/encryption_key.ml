open Import;;

type t =
  { keytype : Encryption_type.t
  ; keyvalue : Octet_string.t
  }

module Format = struct
  type t = Encryption_type.Format.t * Octet_string.Format.t

  let asn =
    sequence2
      (tag_required ~label:"keytype" 0 Encryption_type.Format.asn)
      (tag_required ~label:"keyvalue" 1 Octet_string.Format.asn)
end

let format_of_t t =
  ( Encryption_type.format_of_t t.keytype
  , Octet_string.format_of_t t.keyvalue )
