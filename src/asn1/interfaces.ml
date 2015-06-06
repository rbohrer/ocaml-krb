open Batteries;;

include Batteries.Interfaces

module type Intable = sig
  type t

  val t_of_int : int -> t
  val int_of_t : t -> int
end

module OrderedType_of_Intable (M : Intable) = struct
  type t = M.t

  let compare t t' = Int.compare (M.int_of_t t) (M.int_of_t t')
end

module type ALIST = sig
  type t
  val alist : (t * int) list
end

(* Slower than a custom Intable implementation *)
module Intable_of_alist (M : ALIST) : Intable with type t = M.t = struct
  type t = M.t

  let t_of_int n =
    fst (List.find_exn (fun (_, n') -> n = n') Error.Conversion_error M.alist)

  let int_of_t t =
    snd (List.find_exn (fun (t', _) -> t = t') Error.Conversion_error M.alist)

end
