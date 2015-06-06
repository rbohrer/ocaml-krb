include Asn1_intf.S with type t = int32

module Of_alist : functor (M : Interfaces.ALIST) -> Asn1_intf.S with type t := M.t
