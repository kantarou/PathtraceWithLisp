(load "src/Ray.fasl")

(defclass HitRecord ()
  ((trace
    :accessor hit-recode-trace
    :initform 0.0
    )
   (point
    :accessor hit-recode-point
    :initform #(0 0 0)
    )
   (normal
    :accessor hit-recode-normal
    :initform #(0 0 0))))

(defclass Hitable () ())

(defmethod hit ( (ray Ray) (obj Hitable) (rec HitRecord) t_min t_max ))

