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

let my_codec = Asn.(codec der Format.asn)

let encode () = Asn.(encode my_codec (Asn.random Format.asn))

let test () =
  Printf.printf "%s" (Cstruct.to_string (encode ()))

let () = test ()
let x = Enc_ticket_part.format_of_t
