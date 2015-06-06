type t = string

module Format = struct
  type t = string
  let asn = Asn.ia5_string
end

let format_of_t t = t
