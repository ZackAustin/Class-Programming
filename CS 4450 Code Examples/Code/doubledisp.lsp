;; Define 3 class hierarchies
(defclass A () ())
(defclass B (A) ())
(defclass C (B) ())

(defclass V () ())
(defclass W (V) ())
(defclass X (W) ())

;; Define Multimethods
(defgeneric f (p1 p2))
(defmethod f ((p1 A) (p2 V)) (print '(A V)))
(defmethod f ((p1 A) (p2 X)) (print '(A X)))
(defmethod f ((p1 B) (p2 X)) (print '(B X)))
(defmethod f ((p1 C) (p2 V)) (print '(C V)))

;; Create objects
(setf a (make-instance 'A))
(setf b (make-instance 'B))
(setf c (make-instance 'C))
(setf v (make-instance 'V))
(setf w (make-instance 'W))
(setf x (make-instance 'X))

;; Test Combinations
(f a v)   ; (A V)
(f a w)   ; (A V)
(f a x)   ; (A X)
(f b v)   ; (A V)
(f b w)   ; (A V) 
(f b x)   ; (B X)
(f c v)   ; (C V)
(f c w)   ; (C V)
(f c x)   ; (C V)
