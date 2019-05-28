;;;; scavanger.lisp

(in-package #:scavenger)

(ql:quickload :trivial-gamekit)

(defvar *tile-size* 32)
(defvar *board-size* 10)

(defvar *walls* '(:wall-01 :wall-02 :wall-03))
(defvar *floors* '(:floor-01 :floor-02 :floor-03 :floor-04 :floor-05 :floor-06 :floor-07 :floor-08))

(defparameter *level* ())

(defmethod create-board ()
  (dotimes (i *board-size*)
    (dotimes (j *board-size*)
      (let ((x (* i *tile-size*))
            (y (* j *tile-size*)))
        (cond
          ((or (= i 0 ) (= j 0)) (push (list :x x :y y :tile (random-elt *walls*)) *level*))
          ((or (= i (1- *board-size*)) (= j (1- *board-size*)))
           (push (list :x x :y y :tile (random-elt *walls*)) *level*))
          (t (push (list :x x :y y :tile (random-elt *floors*)) *level*)))))))

(gamekit:defgame scavenger () ()
  (:viewport-width (* *tile-size* *board-size*))
  (:viewport-height (* *tile-size* *board-size*))
  (:viewport-title "Scavenger"))

(gamekit:bind-button :right :pressed (lambda ()  (move-player :right)))
(gamekit:bind-button :left :pressed (lambda ()  (move-player :left)))
(gamekit:bind-button :up :pressed (lambda ()  (move-player :up)))
(gamekit:bind-button :down :pressed (lambda ()  (move-player :down)))



(defmethod gamekit:draw ((app scavenger))
  (mapcar (lambda (tile)
            (gamekit:draw-image (gamekit:vec2 (getf tile :x) (getf tile :y)) (getf tile :tile))) *level*)

  (let ((x (* (getf *player* :x) *tile-size*))
        (y (* (getf *player* :y) *tile-size*)))
    (gamekit:draw-image (gamekit:vec2 x y) :player))
  (sleep 0.1))

(defun start ()
  (create-board)
  (gamekit:start 'scavenger))

(defun stop ()
  (gamekit:stop))
