;;;; scavenger.asd

(asdf:defsystem #:scavenger
  :description "Remake of the Unit3D tutorial in Lisp"
  :author "Christiaan Janssen <christiaan@drunkturtle.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:trivial-gamekit)
  :components ((:file "package")
               (:file "src/player")
               (:file "src/utils")
               (:file "src/asset-load")
               (:file "scavenger")))
