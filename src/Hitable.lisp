;; (load "src/Ray.fasl")

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
    :accessor hit-recode-material-pointer
    :initform (make-instance 'Lambertian :albedo #(0.8 0.3 0.3)))))

(defclass Hitable () 
  ((material-pointer
    :initarg :material
    :accessor hit-material-pointer)))

