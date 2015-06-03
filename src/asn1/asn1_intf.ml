module type S = sig
  type t
  module Format : sig
    type t

    val asn : t Asn.t
  end

  val format_of_t : t -> Format.t
end
