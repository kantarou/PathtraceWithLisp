(load "Hitable.fasl")

(defclass Sphere (Hitable)
  ((center :accessor sphere-center
	   :initarg :center)
   (radius :accessor sphere-radius
	   :initarg :radius)))


(defmethod hit ((r Ray) (obj Sphere) (rec HitRecord) t-min t-max)
  (let* ((oc (v- (ray-origin r)
		(sphere-center obj)))
	 (a  (v-dot (ray-direction r) (ray-direction r)))
	 (b  (v-dot oc (ray-direction r)))
	 (c  (- (v-dot oc oc)
		(* (sphere-radius obj) (sphere-radius obj))))
	 (discriment (- (* b b)
			(* a c))))
    
    (if (> discriment 0)
	(let ((temp))
	  (setf temp (/ (- (* -1 b) (realpart (sqrt discriment))) a))
	  (if (and (< temp t-max)
		   (> temp t-min))
	      (progn
		(setf (hit-recode-trace rec) temp)
		(setf (hit-recode-point rec)
		      (point-at-parameter (hit-recode-trace rec) r))

		(setf (hit-recode-normal rec)
		      (v* (/ 1 (sphere-radius obj))
		       (v- (hit-recode-point rec) (sphere-center obj))))
		t)

	      (progn
		(setf temp (/ (+ (* -1 b) (realpart (sqrt discriment))) a))
		(if (and (< temp t-max)
			 (> temp t-min))
		    (progn
		      (setf (hit-recode-trace rec) temp)
		      (setf (hit-recode-point rec)
			    (point-at-parameter (hit-recode-trace rec) r))
		
		      (setf (hit-recode-normal rec)
			    (v* (/ 1 (sphere-radius obj))
				(v- (hit-recode-point rec) (sphere-center obj))))		
		      t)))))
	nil)))

