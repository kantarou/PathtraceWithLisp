;; (load "src/Material.fasl")
;; (load "src/Ray.fasl")

(defclass Lambertian (Material)
  ((albedo
    :initarg :albedo
    :accessor lambertian-albedo)))


(defmethod scatter ((lambertian Lambertian)
		    (ray-in Ray)
		    (rec HitRecord)
			attenuation
		    (scattered Ray))

  (let ((target (v+ (v+ (hit-recode-point rec)
		   				(hit-recode-normal rec))
		   			(random-in-unit-sphere))))

		(setf (ray-origin scattered) (hit-recode-point rec))
		(setf (ray-direction scattered) 
				(v- target
					(hit-recode-point rec)))
		;; (mapcar #'(lambda (x) (format destination "~D " x))  (ray-direction scattered))
    	(setf (aref attenuation 0) (aref (lambertian-albedo lambertian) 0))
		(setf (aref attenuation 1) (aref (lambertian-albedo lambertian) 1))
		(setf (aref attenuation 2) (aref (lambertian-albedo lambertian) 2))
    	t))

(defclass Metal (Material)
  ((albedo
	:initarg :albedo
    :accessor metal-albedo)
;;    (fuzz
;;     :initarg :fuzz
;; 	:accessor metal-fuzz)
	))


(defun reflect (vec normal)
	(v- vec
		(v* (* 2 (v-dot vec normal))
			normal)))

(defmethod scatter ((lambertian Metal)
		    (ray-in Ray)
		    (rec HitRecord)
			attenuation
		    (scattered Ray))
 
  (let ((target (v+ (v+ (hit-recode-point rec)
		   			    (hit-recode-normal rec))
		   			(random-in-unit-sphere)))
		(reflected (reflect (v-unit (ray-direction ray-in)) 
							(hit-recode-normal rec))))

	(setf (ray-origin scattered) (hit-recode-point rec))
	(setf (ray-direction scattered) reflected)

	(setf (aref attenuation 0) (aref (metal-albedo lambertian) 0))
	(setf (aref attenuation 1) (aref (metal-albedo lambertian) 1))
	(setf (aref attenuation 2) (aref (metal-albedo lambertian) 2))

    (> (v-dot (ray-direction scattered)
			  (hit-recode-normal rec))
		0)))