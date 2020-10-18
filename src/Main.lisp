(load "src/Image.fasl")
(load "src/Vector3D.fasl")
(load "src/Ray.fasl")
(load "src/Hitable.fasl")
(load "src/HitableList.fasl")
(load "src/Sphere.fasl")
(load "src/Material.fasl")
(load "src/Lambertian.fasl")
(load "src/Camera.fasl")

(defmethod get-color ((ray Ray)
		      (world HitableList)
			  depth)

  (let ((rec (make-instance 'HitRecord)))
    (multiple-value-bind (hit-result rec)
	(hit ray world rec 0.001 sb-ext:double-float-positive-infinity)
      (if hit-result
		(let ((scattered (make-instance 'Ray))
			  (attenuation #(0 0 0)))
			(if (and (< depth 50)
				(scatter (hit-recode-material-pointer rec) ray rec attenuation scattered))

					(map 'vector #'* attenuation (get-color scattered world (+ depth 1)))				
					#(0 0 0)))
		 (progn
			(let* ((unit-direction (v-unit (ray-direction ray)))
				(temp (* 0.5
						(+ (aref unit-direction 1) 1.0))))
				(v+ (v* (- 1.0 temp)
						#(1 1 1))
					(v* temp
						#(0.5 0.7 1.0)))))))))

  

(defun main ()
  (let* ((sky (make-instance-image 200 100))
	 (ns 500)
	 (origin  #(0.0 0.0 0.0))
	 (list  `(,(make-instance 'Sphere :center #(0 0 -1) :radius 0.5 :material (make-instance 'Lambertian :albedo #(0.8 0.3 0.3)))
		   	  ,(make-instance 'Sphere :center #(0 -100.5 -1) :radius 100 :material (make-instance 'Lambertian :albedo #(0.8 0.8 0.0)))
			  ,(make-instance 'Sphere :center #(1 0 -1) :radius 0.5 :material (make-instance 'Metal :albedo #(0.8 0.6 0.2)))
		      ,(make-instance 'Sphere :center #(-1 0 -1) :radius 0.5 :material (make-instance 'Metal :albedo #(0.8 0.8 0.8)))))
	 (world (make-instance 'HitableList :list-size 4 :list list))
	 (camera (make-instance 'Camera)))
    
    (setf *random-state* (make-random-state t))

    (let ((width (image-width sky))
	  	  (height (image-height sky)))
      
		(dotimes (y height)
			(dotimes (x width)
				(let ((col (make-instance 'Color :color '(0 0 0))))
					
					(dotimes (s ns)
						(let* ((u (/ (+ x (random 1.0))
							    width))
							(v (/ (+ y (random 1.0))
							      height))
							(r (get-ray camera u v))
							(p (point-at-parameter 2.0 r)))
							;; add some color for antialias
							(setf (color-array col)
								(v+ (color-array col)
									(get-color r world 0)))))
					
					;;transform color value to RGB
					(setf (color-array col)
					(v* (/ 1.0 ns) (color-array col)))
					(setf (color-array col)
					(map 'vector #'(lambda (x) (floor (* x 255.99))) (color-array col)))
					(set-image-color sky x y col)))))
      
    (save-image-ppm "sky" sky)))





