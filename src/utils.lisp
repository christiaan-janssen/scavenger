(in-package #:scavenger)

(defun random-elt (lst)
  (nth (random (length lst)) lst))
