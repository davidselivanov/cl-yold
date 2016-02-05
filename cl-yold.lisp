;;;
;;; File: cl-yold.lisp
;;; Author: David Selivanov <rtmpdavid@gmail.com>
;;;
;;; Created: Setting Orange, the 35th day of Chaos in the YOLD 3182
;;;
;;; Copyright © 2016 David Selivanov <rtmpdavid@gmail.com>
;;; This program is free software. It comes without any warranty, to
;;; the extent permitted by applicable law. You can redistribute it
;;; and/or modify it under the terms of the Do What The Fuck You Want
;;; To Public License, Version 2, as published by Sam Hocevar.
;;; See the COPYING file for more details.

(in-package :cl-user)
(defpackage cl-yold
  (:use :cl)
  (:export :yold))
(in-package :cl-yold)

(defparameter *days*
  (list "Sweetmorn" "Boomtime" "Pungenday" "Prickle-Prickle" "Setting Orange"))

(defparameter *seasons*
  (list "Chaos" "Discord" "Confusion" "Bureaucracy" "The Aftermath"))

(defparameter *holydays*
  (list
   '("Mungday" "Chaoflux")
   '("Mojoday" "Discoflux")
   '("Syaday" "Confuflux")
   '("Zaraday" "Bureflux")
   '("Maladay" "Afflux")))


(defun holydayp (day)
  (or (= 4 day) (= 49 day)))

(defun get-holyday (season day)
  (print day)
  (nth (if (> day 4) 1 0) (nth season *holydays*)))

(defun leapp (year)
  (if (not (zerop (mod year 4))) nil
      (if (not (zerop (mod year 100))) t
          (if (not (zerop (mod year 400))) nil
              t))))

(defun yold (&optional (date (get-universal-time)))
  (multiple-value-bind (sec min hour mon-d mon year day dp zone)
      (decode-universal-time date)
    (let* ((days (floor (/ (- date (encode-universal-time 0 0 0 1 1 year zone))
                           (* 60 60 24)))))
      (if (and (leapp year) (= days 60)) (format nil "It's St. Tib's Day, ~a YOLD!" (+ year 1166))
          (progn
            (if (and (leapp year) (> days 60)) (decf days))
            (format nil "~@[It's ~a! ~]~a, the ~:r day of ~a, YOLD ~a"
                    (if (holydayp (floor (mod days 73)))
                        (get-holyday (floor (/ days 73)) days)
                        nil)
                    (nth (floor (mod days 5)) *days*)
                    (mod (1+ days) 73)
                    (nth (floor (/ days 73)) *seasons*)
                    (+ year 1166)))))))
