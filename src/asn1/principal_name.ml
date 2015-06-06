open Import;;

type t =
  { name_type : Name_type.t
  ; name_string : Kerberos_string.t list
  }

module Format = struct
  type t =  Name_type.Format.t * Kerberos_string.Format.t list

  let asn =
    sequence2
      (tag_required 0 ~label:"name_type" Name_type.Format.asn)
      (tag_required 1 ~label:"name_string"
         (sequence_of Kerberos_string.Format.asn))

end

let format_of_t t =
  ( Name_type.format_of_t t.name_type
  , List.map Kerberos_string.format_of_t t.name_string)
