(load "src/Image.fasl")
(load "src/Vector3D.fasl")
(load "src/Ray.fasl")
(load "src/Sphere.fasl")
(load "src/Hitable.fasl")
(load "src/HitableList.fasl")


(defmethod get-color ((ray Ray)
		      (world HitableList))

  (let ((rec (make-instance 'HitRecord)))
    (if (hit ray world rec 0.0 sb-ext:double-float-positive-infinity)
	(v* 0.5
	   (v+ (hit-recode-normal rec) #(1 1 1)))
	(progn
	  (let* ((unit-direction (v-unit (ray-direction ray)))
		(temp (* 0.5
			 (+ (aref unit-direction 1) 1))))
	    (v+ (v* (- 1 temp)
		  #(1 1 1))
	       (v* temp
		   #(0.5 0.7 1.0))))))))

  

(defun main ()
  (let ((sky (make-instance-image 200 100))
	(lower-left-corner  #(-2.0 -1.0 -1.0))
	(horizontal #(4.0 0.0 0.0))
	(vertical  #(0.0 2.0 0.0))
	(origin  #(0.0 0.0 0.0))
	(list  `(,(make-instance 'Sphere :center #(0 0 -1) :radius 0.5)
		  ,(make-instance 'Sphere :center #(0 -100.5 -1) :radius 100)))
	(world (make-instance 'HitableList :list-size 2 :list list))
	(camera (make-instance 'Camera)))
    
    
    (let ((width (image-width sky))
	  (height (image-height sky)))
      (dotimes (y height)
	(dotimes (x width)
	  (let* ((u (/ x width))
		 (v (/ y height))
		 
		 (r (make-instance 'ray :origine origin
				   :direction (v+ (v+ lower-left-corner (v* u horizontal)) (v* v vertical))))
		 ;(p (point-at-parameter 2.0 r))

		 (col (make-instance 'Color :color (get-color r world))))
					;(transform-ray-to-color r)))

		 ;;transform color value to RGB
	    (setf (color-array col)
		   (map 'vector #'(lambda (x) (floor (* x 255.99))) (color-array col)))
		 (set-image-color sky x y col)))))
    (save-image-ppm "sky" sky)))

