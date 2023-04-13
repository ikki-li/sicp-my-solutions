#lang racket

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; According to the combination evaluation rule (1.1.3)
; value of all subexpressions will be calculated first.
; In order to calculate the value of the operator
; in the function body, we need to get the value
; of the predicate (> b 0). If its return "true",
; then operator will be "+", otherwise the operator
; will be "-". Thus, combination difined in the body
; of function, when substituting arguments, will be
; reduce to (+ a b) or (- a b).
