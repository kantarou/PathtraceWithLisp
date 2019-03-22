(defvar compile-files
  '("Vector3D.lisp"
    "Matrix.lisp"
    "Ray.lisp"
    "Image.lisp"
    "Hitable.lisp"
    "HitableList.lisp"
    "Sphere.lisp"
    "main.lisp"))



;; compile to exe file
(setf compile-files
  (mapcar (lambda (x) (concatenate 'string "src/" x)) compile-files))

(print compile-files)

(mapcar #'compile-file compile-files)
(mapcar #'load compile-files)
(sb-ext:save-lisp-and-die "pathtrace-lisp"
                          :toplevel #'main
                          :executable t)

#|
Hitable.lisp
Sphere.lisp
compile.lisp
|#
