;; Define 3 class hierarchies
(defclass A () ())
(defclass B (A) ())
(defclass C (B) ())

(defclass V () ())
(defclass W (V) ())
(defclass X (W) ())

;; Define Multimethods
(defgeneric f (p1 p2))
(defmethod f ((p1 V) (p2 A)) (print '(V A)))
(defmethod f ((p1 X) (p2 A)) (print '(X A)))
(defmethod f ((p1 X) (p2 B)) (print '(X B)))
(defmethod f ((p1 V) (p2 C)) (print '(V C)))

;; Create objects
(setf a (make-instance 'A))
(setf b (make-instance 'B))
(setf c (make-instance 'C))
(setf v (make-instance 'V))
(setf w (make-instance 'W))
(setf x (make-instance 'X))

;; Test Combinations
(f v a)   ; (A V)
(f v b)   ; (A V)
(f v c)   ; (A X)
(f w a)   ; (A V)
(f w b)   ; (A V) 
(f w c)   ; (B X)
(f x a)   ; (C V)
(f x b)   ; (C V)
(f x c)   ; (C V)
