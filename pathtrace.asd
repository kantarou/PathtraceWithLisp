;; ASDF system definition for PathtraceWithLisp.
;;
;; Each :file entry lists the components it actually depends on via
;; :depends-on. ASDF uses this graph to compile/load files in the
;; correct order, instead of hand-written (load ".../X.fasl") calls
;; scattered across the source files.

(asdf:defsystem "pathtrace"
  :description "A simple path tracer written in Common Lisp"
  :pathname "src"
  :components
  ((:file "Vector3D")
   (:file "Matrix")
   (:file "Image")
   (:file "Ray"        :depends-on ("Vector3D" "Image"))
   (:file "Hitable")
   (:file "HitableList" :depends-on ("Hitable" "Ray"))
   (:file "Material"   :depends-on ("Vector3D"))
   (:file "Lambertian" :depends-on ("Material" "Hitable" "Ray"))
   (:file "Sphere"     :depends-on ("Hitable" "Ray"))
   (:file "Camera"     :depends-on ("Ray"))
   (:file "Main"       :depends-on ("Vector3D" "Image" "Ray" "HitableList"
                                     "Sphere" "Lambertian" "Camera"))))
