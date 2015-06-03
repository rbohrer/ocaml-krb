type t = int

module Format = struct
  type t = int

  let asn = Asn.int
end

let format_of_t t = t
