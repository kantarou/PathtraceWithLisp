(load "Ray.fasl")

(defclass HitRecord ()
  ((trace
    :accessor hit-recode-trace)
   (point
    :accessor hit-recode-point)
   (normal
    :accessor hit-recode-normal)))

(defclass Hitable () ())

(defmethod hit ((obj Hitable) (ray Ray) (rec HitRecord) t_min t_max ))

