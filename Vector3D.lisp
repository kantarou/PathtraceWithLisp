
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
	(v* (/ 1.0 (v-norm a)) a))

(defun v-cross (a b)
   (let ((v (make-array 3)))
    (setf (aref v 0) (- (* (aref a 1) (aref b 2)) (* (aref a 2) (aref b 1))))
	(setf (aref v 1) (- (* (aref a 2) (aref b 0)) (* (aref a 0) (aref b 2))))
	(setf (aref v 2) (- (* (aref a 0) (aref b 1)) (* (aref a 1) (aref b 0))))
	v))



; (defclass Vec3 ()
; 	((e		:accessor vec3-array
; 		    :initarg  :vec3
; 		    :initform (make-array '(3) :initial-contents '(0 0 0)))))

; ; (defun make-instance-vec3 (e1)
; ; 	(make-instance 'vec3 :vec3 :initform e1))

; (defun make-instance-vec3 (e1 e2 e3)
; 	(make-instance 'vec3 :vec3 (coerce `(,e1 ,e2 ,e3) 'vector)))


; (defmethod v+ ((a Vec3) (b Vec3))
; 		(apply #'make-instance-vec3  (coerce (map 'vector #'+ (vec3-array a) (vec3-array b)) 'list)))

; (defvar a (make-instance-vec3 1 2 3))
; (defvar b (make-instance-vec3 1 0 3))

; (print (v+ a b))
