(in-package :cl-user)
(defpackage caveman-test-asd
  (:use :cl :asdf))
(in-package :cl-user)
(defpackage cl-yold
  (:use :cl :asdf))
(in-package :cl-yold)

(defsystem cl-yold
  :version "0.1"
  :author ""
  :license ""
  :depends-on ()
  :components ((:file "cl-yold"))
  :description "")
