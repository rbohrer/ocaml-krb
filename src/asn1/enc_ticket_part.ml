open Import;;

type t =
  { flags : Ticket_flags.t
  ; key : Encryption_key.t
  ; crealm : Realm.t
  ; cname : Principal_name.t
  ; transited : Transited_encoding.t
  ; authtime : Kerberos_time.t
  ; starttime : Kerberos_time.t option
  ; endtime : Kerberos_time.t
  ; renew_till : Kerberos_time.t option
  ; caddr : Host_addresses.t
  ; authorization_data : Authorization_data.t
  }

module Format = struct
  type t =
    Ticket_flags.Format.t
    * (Encryption_key.Format.t
    * (Realm.Format.t
    * (Principal_name.Format.t
    * (Transited_encoding.Format.t
    * (Kerberos_time.Format.t
    * (Kerberos_time.Format.t option
    * (Kerberos_time.Format.t
    * (Kerberos_time.Format.t option
    (* Non-empty *)
    * (Host_addresses.Format.t option
    (* Non-empty *)
    * Authorization_data.Format.t option)))))))))

  let asn =
    Application_tag.tag `Enc_ticket_part
      (sequence
       ( (tag_required ~label:"flags" 0 Ticket_flags.Format.asn)
       @ (tag_required ~label:"key" 1 Encryption_key.Format.asn)
       @ (tag_required ~label:"crealm"2  Realm.Format.asn)
       @ (tag_required ~label:"cname" 3 Principal_name.Format.asn)
       @ (tag_required ~label:"transited" 4 Transited_encoding.Format.asn)
       @ (tag_required ~label:"authtime" 5 Kerberos_time.Format.asn)
       @ (tag_optional ~label:"starttime" 6 Kerberos_time.Format.asn)
       @ (tag_required ~label:"endtime" 7 Kerberos_time.Format.asn)
       @ (tag_optional ~label:"renew_till" 8 Kerberos_time.Format.asn)
       @ (tag_optional ~label:"caddr" 9 Host_addresses.Format.asn)
      -@ (tag_optional ~label:"authorization_data" 10 Authorization_data.Format.asn)))
end

let format_of_t t =
  let caddr =
    match t.caddr with
    | [] -> None
    | lst -> Some lst
  in
  let authorization_data =
    match t.authorization_data with
    | [] -> None
    | lst -> Some lst
  in
   (Ticket_flags.format_of_t t.flags
  ,(Encryption_key.format_of_t t.key
  ,(Realm.format_of_t t.crealm
  ,(Principal_name.format_of_t t.cname
  ,(Transited_encoding.format_of_t t.transited
  ,(Kerberos_time.format_of_t t.authtime
  ,(Option.map Kerberos_time.format_of_t t.starttime
  ,(Kerberos_time.format_of_t t.endtime
  ,(Option.map Kerberos_time.format_of_t t.renew_till
  ,(Option.map Host_addresses.format_of_t caddr
  , Option.map Authorization_data.format_of_t authorization_data))))))))))
