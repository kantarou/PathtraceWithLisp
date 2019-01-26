(defun determinant-3 (m)
		(- (+ (* (aref m 0 0) (aref m 1 1) (aref m 2 2))
		      (* (aref m 0 1) (aref m 1 2) (aref m 2 0))
		      (* (aref m 0 2) (aref m 1 0) (aref m 2 1)))
		   (+ (* (aref m 0 0) (aref m 1 2) (aref m 2 1))
		      (* (aref m 0 1) (aref m 1 0) (aref m 2 2))
		      (* (aref m 0 2) (aref m 1 1) (aref m 2 0)))))


; (defvar matrix #2a((99 100 101) (100 102 102) (100 104 103)))
; (print (determinant-3 matrix))
