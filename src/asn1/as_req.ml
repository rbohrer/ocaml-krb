type t =
  { padata : Pa_data.t list
  ; req_body : Kdc_req_body.t
  }

module Format = struct
  type t = Kdc_req.Format.t

  let asn = Application_tag.tag `As_req Kdc_req.Format.asn
end

let format_of_t t =
  Kdc_req.format_of_t
    { Kdc_req.
      msg_type = `As_req
    ; padata = t.padata
    ; req_body = t.req_body
    }

(* CR bbohrer: delete this crap
let my_codec = Asn.(codec ber Format.asn)

let encode () = Asn.(encode my_codec (format_of_t { padata = []; req_body = 0}))

let test () =
  Printf.printf "%s" (Cstruct.to_string (encode ()))

let () = test ()
*)
