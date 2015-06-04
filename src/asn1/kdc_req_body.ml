open Import

(* CR bbohrer: Encode invariant that cname is only used for as-req *)
type t =
  { kdc_options : Kdc_options.t
  ; cname : Principal_name.t option (* Used only in As-req *)
  ; realm : Realm.t
  ; sname : Principal_name.t option
  ; from : Kerberos_time.t option
  ; till : Kerberos_time.t
  ; rtime : Kerberos_time.t option
  ; nonce : Uint32.t
  ; etype : Encryption_type.t list (* In preference order*)
  ; addresses : Host_addresses.t option
  ; enc_authorization_data : Encrypted_data.t option
  ; additional_tickets :  Ticket.t list
  }

module Format = struct
  type t =
      Kdc_options.Format.t
    * (Principal_name.Format.t option (* Used only in As-req *)
    * (Realm.Format.t
    * (Principal_name.Format.t option
    * (Kerberos_time.Format.t option
    * (Kerberos_time.Format.t
    * (Kerberos_time.Format.t option
    * (Uint32.Format.t
    * (Encryption_type.Format.t list (* In preference order*)
    * (Host_addresses.Format.t option
    * (Encrypted_data.Format.t option
    *  Ticket.Format.t list option))))))))))

  let asn =
    sequence
       ( tag_required 0 ~label:"kdc_options" Kdc_options.Format.asn
       @ tag_optional 1 ~label:"cname" Principal_name.Format.asn
       @ tag_required 2 ~label:"realm" Realm.Format.asn
       @ tag_optional 3 ~label:"sname" Principal_name.Format.asn
       @ tag_optional 4 ~label:"from" Kerberos_time.Format.asn
       @ tag_required 5 ~label:"till" Kerberos_time.Format.asn
       @ tag_optional 6 ~label:"rtime" Kerberos_time.Format.asn
       @ tag_required 7 ~label:"nonce" Uint32.Format.asn
       @ tag_required 8 ~label:"etype" (sequence_of Encryption_type.Format.asn)
       @ tag_optional 9 ~label:"addresses" Host_addresses.Format.asn
       @ tag_optional 10 ~label:"enc_authorization_data" Encrypted_data.Format.asn
      -@ tag_optional 11 ~label:"additional_tickets" (sequence_of Ticket.Format.asn))
end

let format_of_t t =
  let additional_tickets =
    match t.additional_tickets with
    | [] -> None
    | lst -> Some (List.map Ticket.format_of_t lst)
  in
  (Kdc_options.format_of_t t.kdc_options,
  (Option.map Principal_name.format_of_t t.cname,
  (Realm.format_of_t t.realm,
  (Option.map Principal_name.format_of_t t.sname,
  (Option.map Kerberos_time.format_of_t t.from,
  (Kerberos_time.format_of_t t.till,
  (Option.map Kerberos_time.format_of_t t.rtime,
  (Uint32.format_of_t t.nonce,
  (List.map Encryption_type.format_of_t t.etype,
  (Option.map Host_addresses.format_of_t t.addresses,
  (Option.map Encrypted_data.format_of_t t.enc_authorization_data,
   additional_tickets)))))))))))
