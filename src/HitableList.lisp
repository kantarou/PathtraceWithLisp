(load "src/Hitable.fasl")

(defclass HitableList (Hitable)
  ((list-size
    :accessor hitable-list-list-size
    :initarg  :list-size)
   (list
    :accessor hitable-list-list
    :initarg :list
    ;:type 'Hitable
    )))

(defmethod hit ((ray Ray)
		(obj Hitablelist)
		(rec Hitrecord)
		t_min
		t_max)

  (let ((temp_rec (make-instance 'HitRecord))
	(hit_anything nil)
	(closet_so_far t_max))
    
    (loop for i from 0 to (- (hitable-list-list-size obj) 1) do
		(multiple-value-bind (hit-result temp_rec)
				(hit ray (elt (hitable-list-list obj) i)  temp_rec t_min closet_so_far)
			(if hit-result
				(progn
				(setf closet_so_far (hit-recode-trace temp_rec))
				(setf rec temp_rec)
				(setf hit_anything t)))))
    (values hit_anything rec)))

