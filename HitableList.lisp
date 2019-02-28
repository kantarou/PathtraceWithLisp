(load "Hitable.lisp")

(defclass HitableList (Hitable)
  ((list-size
    :accessor hitable-list-list-size
    :initarg  :list-size)
   (list
    :accessor hitable-list-list
    :initarg :list
    ;:type 'Hitable
    )))

(defmethod hit ((obj Hitablelist)
		(ray Ray)
		(rec Hitrecord)
		t_min
		t_max)
  (let (temp_rec
	(hit_anything nil)
	(closet_so_far t_max))

    ;Here Write
    (loop for i from 0 to (hitable-list-list-size obj)
	 (if (hit (hitable-list-list obj) ray t_min closet_so_far temp_rec)
	     (progn
	       (setf hit_anything t)
	       (setf closet_so_far temp_rec)
	       (setf rec temp_rec))))

    hit_anything))










