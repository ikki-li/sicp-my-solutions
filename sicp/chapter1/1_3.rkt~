#lang racket

(define (square x) (* x x))
(define (sum-of-squares x y)
  (+ (square x) (square y)))
(define (fn x y z)
  (cond ((and (> x z) (> y z))
         (sum-of-squares x y))
        ((and (> x y) (> z y))
         (sum-of-squares x z))
        ((and (> z x) (> y x))
         (sum-of-squares z y))))