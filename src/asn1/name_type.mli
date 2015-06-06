type t =
| Unknown
| Principal
| Srv_inst
| Srv_hst
| Srv_xhst
| Uid
| X500_principal
| Smtp_name
| Enterprise

include Asn1_intf.S with type t := t
