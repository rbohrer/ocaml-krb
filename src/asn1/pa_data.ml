open Import;;

type t =
  { padata_type : Krb_int32.t
  ; padata_value : string
  }

module Format = struct
  type t = Krb_int32.Format.t * Cstruct.t

  let asn =
    sequence2
      (* First value is 1 not 0 *)
      (tag_required ~label:"padata_type" 1 Krb_int32.Format.asn)
      (tag_required ~label:"padata_value" 2 octet_string)
end

let format_of_t t =
  (Krb_int32.format_of_t t.padata_type, Cstruct.of_string t.padata_value)
