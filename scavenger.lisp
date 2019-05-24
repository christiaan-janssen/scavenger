;;;; scavanger.lisp

(in-package #:scavenger)

(ql:quickload :trivial-gamekit)
(ql:quickload :iterate)
(use-package :iterate)


(gamekit:register-resource-package :keyword "~/quicklisp/local-projects/scavenger/assets/")

(gamekit:define-image :wall-01 "Sprites/TileSet/wall01.png")
(gamekit:define-image :wall-02 "Sprites/TileSet/wall02.png")
(gamekit:define-image :wall-03 "Sprites/TileSet/wall03.png")

(gamekit:define-image :floor-01 "Sprites/TileSet/floor01.png")
(gamekit:define-image :floor-02 "Sprites/TileSet/floor02.png")
(gamekit:define-image :floor-03 "Sprites/TileSet/floor03.png")
(gamekit:define-image :floor-04 "Sprites/TileSet/floor04.png")
(gamekit:define-image :floor-05 "Sprites/TileSet/floor05.png")
(gamekit:define-image :floor-06 "Sprites/TileSet/floor06.png")
(gamekit:define-image :floor-07 "Sprites/TileSet/floor07.png")
(gamekit:define-image :floor-08 "Sprites/TileSet/floor08.png")

(gamekit:define-image :player "Sprites/PlayerIdle/01.png")

(defvar *walls* '(:wall-01 :wall-02 :wall-03))
(defvar *floors* '(:floor-01 :floor-02 :floor-03 :floor-04 :floor-05 :floor-06 :floor-07 :floor-08))

(defvar *tile-size* 32)
(defvar *board-size* 10)

(defun random-elt (lst)
  (nth (random (length lst)) lst))

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

(defmethod gamekit:draw ((app scavenger))
  (mapcar (lambda (tile)
            (gamekit:draw-image (gamekit:vec2 (getf tile :x) (getf tile :y)) (getf tile :tile))) *level*)
  (gamekit:draw-image (gamekit:vec2 32 32) :player)
  (sleep 0.1))

(defun start ()
  (create-board)
  (gamekit:start 'scavenger))

(defun stop ()
  (gamekit:stop))
