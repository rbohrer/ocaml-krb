type t = int32

module Format = struct
  type t = Z.t

  let asn = Asn.integer
end

let format_of_t = Z.of_int32

module Of_alist (M : Interfaces.ALIST) : Asn1_intf.S with type t = M.t = struct
  include M

  module Format = Format

  module Intable = Interfaces.Intable_of_alist(M)

  let format_of_t t = Z.of_int (Intable.int_of_t t)
end
