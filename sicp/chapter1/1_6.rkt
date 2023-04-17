#lang racket

(define (square x)
  (* x x))

(define (abs x)
  (if (< x 0)
      (- x)
      x))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (good-enough? guess x)
  (< (abs (- x (square guess))) 0.001))

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(new-if (= 2 3) 0 5)

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

; (displayln (sqrt 36))
; Lisp (and Racket) uses applicative-order evaluation,
; It means that the interpreter first tries to evaluate
; the operator and all operands. "if" is a special form,
; not procedure, because the interpreter evaluates the  
; value of one of the two subexpressions (then-clause or
; (else-clause), not both.
;
; In the present case, created by us operator "new-if"
; will be calculated using applicative-order model. So,
; interpreter tries to evaluate all operands, including
; (sqrt-iter (improve guess x) x). Recursion doesn't
; end, because interpreter every time will try to calculate
; all operands. That lead to overflows the stack and cause
; error.