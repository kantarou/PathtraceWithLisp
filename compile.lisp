(defvar compile-files
  '("Vector3D.lisp"
    "Matrix.lisp"
    "Ray.lisp"
    "Image.lisp"
    "Hitable.lisp"
    "Sphere.lisp"
    ))

(mapcar #'compile-file compile-files)


#|
Hitable.lisp
Sphere.lisp
compile.lisp
|#
