(require :asdf)

;; Register this project's directory with ASDF so it can find pathtrace.asd,
;; then let ASDF resolve compilation/load order from the :depends-on graph
;; declared there, instead of a hand-maintained file list.
(let ((project-root (make-pathname :name nil :type nil
                                    :defaults (or *load-truename*
                                                  *default-pathname-defaults*))))
  (push project-root asdf:*central-registry*))

(declaim (optimize (speed 3) (debug 0) (safety 0)))

(asdf:load-system "pathtrace")

(sb-ext:save-lisp-and-die "pathtrace-lisp"
                          :toplevel #'main
                          :executable t)
