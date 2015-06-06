open Import;;

type t =
  { year : int
  ; month : int
  ; day : int
  ; hour : int
  ; minute : int
  ; second : int
  }

module Format = struct
  type t = Asn_time.t

  let asn = generalized_time
end

(* Per RFC 4120, all kerberos times are UTC, no fractional seconds. *)
let format_of_t t =
  { Asn_time.
    date = (t.year, t.month, t.day)
  ; time = (t.hour, t.minute, t.second, 0.)
  ; tz = None
  }
