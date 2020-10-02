(load "src/Ray.fasl")

(defclass HitRecord ()
  ((trace
    :accessor hit-recode-trace
    :initform 0.0)
   (point
    :accessor hit-recode-point
    :initform #(0 0 0))
   (normal
    :accessor hit-recode-normal
    :initform #(0 0 0))
   (material-pointer
    :initarg :material
    :accessor hit-recode-material-pointer)))

(defclass Hitable () 
  ((material-pointer
    :initarg :material
    :accessor hit-material-pointer)))

;(defmethod hit ( (ray Ray)
;		(obj Hitable)
;		(rec HitRecord)
;		t_min
;		t_max ))

