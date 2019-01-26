(load "Image.fasl")
(load "Vector3D.fasl")
(load "Ray.fasl")

(defun main ()
  (let (sky lower-left-corner horizontal vertical origin)
    (setf sky (make-instance-image 200 100))
    (setf lower-left-corner #(-2.0 -1.0 -1.0))
    (setf horizontal #(4.0 0.0 0.0))
    (setf vertical   #(0.0 2.0 0.0))
    (setf origin	 #(0.0 0.0 0.0))
    
    (let ((width (image-width sky)) (height (image-height sky)))
      (dotimes (y height)
	(dotimes (x width)
	  
	  (let* ((u (/ x width))
		 (v (/ y height))
		 
		 (r (make-instance 'ray :origine origin
				   :direction (v+ (v+ lower-left-corner (v* u horizontal)) (v* v vertical))))
		 
		 (col
		  (transform-ray-to-color r)))

	    ;;transform color value to RGB
	    (setf (color-array col)
		  (map 'vector #'(lambda (x) (floor (* x 255.99))) (color-array col)))
	    (set-image-color sky x y col)))))
    (save-image-ppm "sky" sky)))
