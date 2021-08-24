(load "src/Vector3D.fasl")

(defclass Color ()
	((color :accessor color-array
		:initarg  :color
		:initform (make-array 3 :element-type 'fixnum
				                :initial-contents '(0 0 0)))))




(defmethod print-color ((pixel Color) &optional (destination t))
	 (map 'vector #'(lambda (x) (format destination "~D " x)) (color-array pixel))
	 (format destination "~%"))



(defclass Image ()
	       ((width  
		    	:accessor image-width
		    	:initarg  :width
		    	:initform 1)
		    (height  
		    	:accessor image-height
		    	:initarg  :height
		    	:initform 1)
		    (image 
	       		:accessor image-array
	       		:initform (make-array 1))))


(defun make-instance-image (width height)
	(let ((image (make-instance 'image :width width :height height)))
	  (setf (image-array image) 
	  		(make-array (* width height)  :initial-element (make-instance 'color)))
	  image))


(defmethod get-image-color ((image Image) x y)
	(aref (image-array image) 
			(+ (* y (image-width image)) x)))


(defmethod set-image-color ((image Image) x y (color Color))
  (setf (aref (image-array image) (+ (* y (image-width image)) x)) color))


(defmethod save-image-ppm (name (image Image))
	(let (file-name width height)
		(setf file-name (format nil "~A~A" name ".ppm"))
		(setf width  (image-width  image))
		(setf height (image-height image))

		
		(with-open-file (file file-name
				      :direction :output
				      :if-exists :overwrite
				      :if-does-not-exist :create)
			(format file "P3~%~D ~D~%255~%" width height)
			(let ((y (1- height)) 
				  color)
				(loop 
					(if (< y 0) 
						(return nil))
					(dotimes (x width)
						(setf color (get-image-color image x y))
						(print-color color file)
						(format file "~%"))
					(decf y))))))


