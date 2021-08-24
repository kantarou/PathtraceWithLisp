(load "src/Ray.fasl")

(defclass Camera ()
  ((origin     :accessor camera-origin
	       :initform #(0 0 0))
   (lower-left-corner    :accessor camera-lower-left-corner
			 :initform #(-2 -1 -1))
   (horizontal    :accessor camera-horizontal
		  :initform #(4 0 0))
   (vertical    :accessor camera-vertical
		:initform #(0 2 0))))

(defmethod get-ray ((camera Camera) u v)
  (make-instance 'Ray
		 :origine (camera-origin camera)
		 :direction (v- (v+ (v+ (camera-lower-left-corner camera)
								(v* u (camera-horizontal camera)))
				    		(v* v (camera-vertical camera)))
						(camera-origin camera))))
