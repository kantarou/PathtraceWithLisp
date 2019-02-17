(defvar compile-files
  '("Vector3D.lisp"
    "Matrix.lisp"
    "Ray.lisp"
    "Image.lisp"
    "Hitable.lisp"
    "Sphere.lisp"
    "main.lisp"
    ))

;;(mapcar #'compile-file compile-files)


;; compile to exe file
(mapcar #'load compile-files)
(sb-ext:save-lisp-and-die "pathtrace-lisp"
                          :toplevel #'main
                          :executable t)

#|
Hitable.lisp
Sphere.lisp
compile.lisp
|#
