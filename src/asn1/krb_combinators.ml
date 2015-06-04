open Asn;;

(* ?cls:None specifies Context-specific ASN tags, which we use a lot*)
let tag_required tag ?label t = (required ?label (explicit ?cls:None tag t))
let tag_optional tag ?label t = (optional ?label (explicit ?cls:None tag t))
