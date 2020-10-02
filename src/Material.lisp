(load "src/Vector3D.fasl")

(defmacro while (test &body body)
	`(do ()
		 ((not ,test))
		 ,@body))

(defclass Material ()
  ())

(defun random-in-unit-sphere ()
  (let ((p #(0 0 0)))
    (while (progn
	     (setf p (v- (vector (random 1.0) (random 1.0) (random 1.0))
		;; (setf p (v- #(0.5 0.5 0.5)
			         #(1 1 1)))
	     (>= (v-norm p) 1.0)))
    p))

(defun refrect (vec normal)
	(v- vec 
		(v* (v-dot vec normal) 
			normal)))