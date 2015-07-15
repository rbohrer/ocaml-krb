(defun elem-type (elem) (cadr elem))

(defun elem-name (elem) (car elem))

(defun elem-of-sexp (sexp)
  (list (symbol-name (car sexp))
        (symbol-name (cadr sexp))))

(defun elems-of-sexp (sexp)
  (mapcar (function elem-of-sexp) sexp))

(defun ml-ident (ident)
  (map 'string #'(lambda (c) (if (char= #\- c) #\_ c))
       (string-capitalize (string-downcase ident) :end 1)))

(defun ml-type (type)
  (format nil "~a.t" (ml-ident type)))

(defun ml-field (name type)
  (format nil "~a : ~b" (ml-ident name) (ml-type type)))

(defun fields-of-elems (elems)
  (cond
   ((eq elems nil) "")
   ((eq (cdr elems) nil)
    (let ((elem (car elems)))
      (ml-field (elem-name elem) (elem-type elem))))
   (t
    (let ((elem (car elems)))
      (format nil "~a; ~a"
              (ml-field (elem-name elem) (elem-type elem))
              (fields-of-elems (cdr elems)))))))

(defun record-type-of-elems (elems &key (name "t"))
  (format nil "type ~a = {~a}" name (fields-of-elems elems)))

(defun module (name &rest decls)
  (format "module ~a = struct~% ~{~A~^~%~} ~%end"
     (ml-ident name)
     decls))

(defmacro defsequence (name &key (starts-at 0) &rest elems)
  (let* ((elems (elems-of-sexp elems)))
    (ml-file name
             ((record-type-of-elems elems)
              (module "format"
                      ((tuple-type-of-elems (format-type-of-elems elems)))
                      (ml-let 'asn
                              (sequence-asn-of-elems elems)))
              (format-fun-of-elems elems)))))

(defsequence authorization-datum
  (ad-type int32)
  (ad-data octet-string))

(defsequence-of authorization_data authorization_datum)
