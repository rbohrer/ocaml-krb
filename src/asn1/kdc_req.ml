open Import;;

type t =
  { msg_type : [ `As_req | `Tgs_req ]
  ; padata : Pa_data.t list
  ; req_body : Kdc_req_body.t
  }

module Format = struct
  type t =
      int (* pvno - 5 *)
    * int (* msg_type *)
    * Pa_data.Format.t list option (* Non-empty *)
    * Kdc_req_body.Format.t

  let asn =
    Asn.(sequence4
           (tag_required 1 ~label:"pvno" int)
           (tag_required 2 ~label:"msg_type" int)
           (tag_optional 3 ~label:"padata" (sequence_of Pa_data.Format.asn))
           (tag_required 4 ~label:"req_body" Kdc_req_body.Format.asn))
end

let format_of_t t =
  let msg_type = Application_tag.int_of_t t.msg_type in
  let padata =
    match t.padata with
    | [] -> None
    | lst -> Some (List.map Pa_data.format_of_t lst)
  in
  ( 5 (* Where 5 means krb5 - this is a constant forever *)
  , msg_type
  , padata
  , Kdc_req_body.format_of_t t.req_body
  )
