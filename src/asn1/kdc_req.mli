type t =
  { msg_type : [ `As_req | `Tgs_req ]
  ; padata : Pa_data.t list
  ; req_body : Kdc_req_body.t
  }

include Asn1_intf.S with type t := t
