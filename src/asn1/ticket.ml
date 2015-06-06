open Import;;

type t =
  { realm : Realm.t
  ; sname : Principal_name.t
  ; enc_part : Encrypted_data.t (* Decrypts to EncTicketPart *)
  }

module Format = struct
  type t =
    int * Realm.Format.t * Principal_name.Format.t * Encrypted_data.Format.t

  let asn =
    Application_tag.tag `Ticket
      (sequence4
         (tag_required 0 ~label:"tkt-vno" int)
         (tag_required 1 ~label:"realm" Realm.Format.asn)
         (tag_required 2 ~label:"sname" Principal_name.Format.asn)
         (tag_required 3 ~label:"enc_part" Encrypted_data.Format.asn))
end

let format_of_t t =
  ( 5
  , Realm.format_of_t t.realm
  , Principal_name.format_of_t t.sname
  , Encrypted_data.format_of_t t.enc_part )
