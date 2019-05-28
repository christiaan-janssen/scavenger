(in-package #:scavenger)

(defparameter *player* '(:x 1 :y 1))

(defun move-player (direction)
  (cond
    ((eq direction :up) (setf (getf *player* :y)
                                 (1+ (getf *player* :y))))
    ((eq direction :down) (setf (getf *player* :y)
                                (1- (getf *player* :y))))
    ((eq direction :right) (setf (getf *player* :x)
                                (1+ (getf *player* :x))))
    ((eq direction :left) (setf (getf *player* :x)
                                (1- (getf *player* :x))))))
