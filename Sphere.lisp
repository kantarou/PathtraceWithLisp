(load "Hitable.fasl")

(defclass Sphere (Hitable)
  ((center :accessor sphere-center
	   :initarg :center)
   (radius :accessor sphere-radius
	   :initarg :radius)))


(defmethod hit ((obj Sphere) (r Ray) (rec HitRecord) t-min t-max )
  (declare (fixnum t-min t-max))
  (let* ((oc (- (ray-origin r)
		(sphere-center obj)))
	 (a  (v-dot (ray-direction r) (ray-direction r)))
	 (b  (v-dot oc (ray-direction r)))
	 (c  (v-dot oc oc))
	 (discriment (- (* b b)
			(* a c))))

    (if (> discriment 0)
	(let (temp (/ (- (* -1 b) (sqrt discriment)) a))
	  (if (and (< temp t-max)
		   (> temp t-min))
	      (progn
		(setf (hit-recode-trace rec) temp)
		(setf (hit-recode-point rec)
		      (point-at-parameter (hit-recode-trace rec) r))
		(setf (hit-recode-normal rec)
		      (/ (- (hit-recode-point rec) (sphere-center obj))
			 (sphere-radius obj)))
		t))

	  (setf temp (/ (+ (* -1 b) (sqrt discriment))
			a))
	  (if (and (< temp t-max)
		   (> temp t-min))
	      (progn
		(setf (hit-recode-trace rec) temp)
		(setf (hit-recode-point rec)
		      (point-at-parameter (hit-recode-trace rec) r))
		(setf (hit-recode-normal rec)
		      (/ (- (hit-recode-point rec) (sphere-center obj))
			 (sphere-radius obj)))
		t)))
	nil)))

