(defun set-vector (a x y z)
	(setf (aref a 0) x)
	(setf (aref a 1) y)
	(setf (aref a 2) z)
	a)

(defun v+ (a b)
	(map 'vector #'+ a b))

(defun v* (a b)
	(let ((result (make-array (length b))))
		(dotimes (i (length b) result)
			(setf (aref result i) (*(aref b i) a)))))

(defun v- (a b)
	(v+ a (v* -1 b)))


(defun v-sum (a)
	(let ((result 0))
		(dotimes (i (length a) result)
			(setf result (+ result (aref a i))))))


(defun v-dot (a b)
	(v-sum (map 'vector #'* a b)))

(defun v-norm (a)
	(sqrt (v-dot a a)))

(defun v-unit (a)
	(v* (/ 1.0 (v-norm a)) 
	    a))

(defun v-cross (a b)
   (let ((v (make-array 3)))
    (setf (aref v 0) (- (* (aref a 1) (aref b 2)) 
						(* (aref a 2) (aref b 1))))
	(setf (aref v 1) (- (* (aref a 2) (aref b 0)) 
						(* (aref a 0) (aref b 2))))
	(setf (aref v 2) (- (* (aref a 0) (aref b 1)) 
						(* (aref a 1) (aref b 0))))
	v))
