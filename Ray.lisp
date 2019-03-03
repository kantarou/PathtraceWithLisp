(load "Vector3D.fasl")
(load "Image.fasl")


(defclass Ray ()
  ((A		:accessor ray-origin
		:initarg  :origine
		:initform (make-array '(3) :initial-contents '(0 0 0)))
   (B     :accessor ray-direction
	  :initarg  :direction
	  :initform (make-array '(3) :initial-contents '(0 0 0)))))

#|
(defun make-instance-ray (e1 e2)
  (make-instance 'ray :origine e1 :direction e2))
|#

(defmethod point-at-parameter (x (ray Ray))
  (let ((A (ray-origin ray)) (B (ray-direction ray)))
    (v+ (v* x B) A)))


(defmethod hit-sphere (center radius (r Ray))
  (let (oc a b c discriminant)
    (setf oc (v- (ray-origin r) center))
    (setf a (v-dot (ray-direction r) (ray-direction r)))
    (setf b (* 2.0 (v-dot oc (ray-direction r))))
    (setf c (- (v-dot oc oc) (* radius radius)))
    (setf discriminant (- (* b b) (* 4 a c)))

    (if (< discriminant 0)
	-1.0
	(/ (- (- b) (sqrt discriminant)) (* 2.0 a)))))

#|
(defmethod transform-ray-to-color ((r Ray))
  
  (let ((temp (hit-sphere #(0 0 -1) 0.5 r)) N)
    (if (> temp 0.0)
	(progn
	  (setf N (v-unit (v- (point-at-parameter temp r) #(0 0 -1))))
	  (setf N (v+ N #(1.0 1.0 1.0)))
	  (setf N (v* 0.5 N))
	  (make-instance 'color :color N))
	
	(let* ((unit-direction (v-unit (ray-direction r)))
	       (temp (+ (* 0.5 (aref unit-direction 1)) 1.0))
	       result)
	  (setf result
		(v+ (v* (- 1.0 temp) #(1.0 1.0 1.0)) (v* temp #(0.5 0.7 1.0))))
	  (make-instance 'color :color result)))))
|#
