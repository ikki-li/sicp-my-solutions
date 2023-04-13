#lang racket

(define (p) (p))
(define (test x y)
  (if (= x 0)
      0
      y))
(test 0 (p))

; If interpreter use normal-order evaluation,
; then interpreter evaluates expression without attempt
; to calculate operands, including (p). So, it return
; 0 as a result.

; An applicative evaluation model interpreter
; first calculates the operands. When interpreter
; would try to get the value of the operand (p),
; it would be fall into the infinite loop.