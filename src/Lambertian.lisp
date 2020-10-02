;; (load "src/Material.fasl")

(defclass Lambertian (Material)
  ((albedo
    :initarg :albedo
    :accessor lambertian-albedo)))


(defmethod scatter ((lambertian Lambertian)
		    (ray-in Ray)
		    (rec HitRecord)
		    (scattered Ray))

  (let ((target (v+ (v+ (hit-recode-point rec)
		   				(hit-recode-normal rec))
		   			(random-in-unit-sphere))))
    (setf scattered (make-instance 'Ray :origine (hit-recode-point rec)
				   						:direction (v- target
						 							  (hit-recode-point rec))))
    (setf attenuation (lambertian-albedo lambertian))
    t))

(defclass Metal (Material)
  ((albedo
	:initarg :albedo
    :accessor metal-albedo)))

(defmethod scatter ((lambertian Metal)
		    (ray-in Ray)
		    (rec HitRecord)
		    (scattered Ray))

  (let ((target (v+ (v+ (hit-recode-point rec)
		   			    (hit-recode-normal rec))
		   			(random-in-unit-sphere))))
    (setf scattered (make-instance 'Ray :origine (hit-recode-point rec)
				   						:direction (v- target
													 (hit-recode-point rec))))
    (setf attenuation (metal-albedo lambertian))
    t))