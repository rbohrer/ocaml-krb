open Import;;

module Datum = struct
  type t =
    { ad_type : Krb_int32.t
    ; ad_data : Octet_string.t
    }

  module Format = struct
    type t = Krb_int32.Format.t * Octet_string.Format.t

    let asn =
      sequence2
        (tag_required ~label:"ad_type" 0 Krb_int32.Format.asn)
        (tag_required ~label:"ad_data" 1 Octet_string.Format.asn)
  end

  let format_of_t t =
    Krb_int32.format_of_t t.ad_type, Octet_string.format_of_t t.ad_data
end

type t = Datum.t list

module Format = struct
  type t = Datum.Format.t list

  let asn = sequence_of Datum.Format.asn
end

let format_of_t = List.map Datum.format_of_t
