open Import;;

type t =
  { tr_type : Krb_int32.t
  ; contents : Octet_string.t
  }

module Format = struct
  type t = Krb_int32.Format.t * Octet_string.Format.t

  let asn =
    sequence2
      (tag_required ~label:"tr_type" 0 Krb_int32.Format.asn)
      (tag_required ~label:"contents" 1 Octet_string.Format.asn)
end

let format_of_t t =
  ( Krb_int32.format_of_t t.tr_type
  , Octet_string.format_of_t t.contents)
