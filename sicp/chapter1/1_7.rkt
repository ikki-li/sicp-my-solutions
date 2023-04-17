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

; First strategy

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

(define (good-enough? guess x)
  (displayln guess)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
  (sqrt-iter 1.0 x))

; Large number calculation:
;
; (sqrt 12345678901234)
;
; Iterations trace:
; 1.0
; 6172839450617.5
; 3086419725309.75
; 1543209862656.875
; 771604931332.4375
; 385802465674.21875
; 192901232853.10938
; 96450616458.55469
; 48225308293.27734
; 24112654274.63867
; 12056327393.319334
; 6028164208.659653
; 3014083128.3297105
; 1507043612.1639276
; 753525902.074542
; 376771142.9778979
; 188401955.01397642
; 94233741.7076047
; 47182376.47141617	
; 23722017.581583798
; 12121224.408177208
; 6569870.942541849
; 4224503.311279173
; 3573450.5222935397
; 3514142.3366335463
; 3513641.86446291
; 3513641.8288200637
; 3513641.8288200637
;
; In this case evaluation not stop because
; of the floating point rounding problem.
; It is expressed in the fact that subexpression
; (- (square guess) x)) in definition
; of the predicate "good-enough?" will return
; the same number.
;
;
; Small number calcualtion:
;
; (sqrt 0.000000001)
;
; Iterations trace:
; 1.0
; 0.5000000005
; 0.25000000125
; 0.125000002625
; 0.06250000531249991
; 0.03125001065624928
; 0.03125001065624928
;
; Function quickly return the inaccurate results.
; The problem is that a predetermined tolerance
; (0.001) is too big for this number.
;
;
; Alternative strategy 

(define (new-sqrt-iter previous-guess guess x)
  (if (new-good-enough? previous-guess guess)
          guess
          (new-sqrt-iter guess (improve guess x)
                     x)))

(define (new-good-enough? previous-guess guess)
  (displayln guess)
  (< (abs (/ (- guess previous-guess) guess)) 0.001))

(define (new-sqrt x)
  (new-sqrt-iter 0 1.0 x))

; Large number calculation:
;
; (sqrt 12345678901234)
;
; Iterations trace:
;
; 1.0
; 6172839450617.5
; 3086419725309.75
; 1543209862656.875
; 771604931332.4375
; 385802465674.21875
; 192901232853.10938
; 96450616458.55469
; 48225308293.27734
; 24112654274.63867
; 12056327393.319334
; 6028164208.659653
; 3014083128.3297105
; 1507043612.1639276
; 753525902.074542
; 376771142.9778979
; 188401955.01397642
; 94233741.7076047
; 47182376.47141617
; 23722017.581583798
; 12121224.408177208
; 6569870.942541849
; 4224503.311279173
; 3573450.5222935397
; 3514142.3366335463
; 3513641.86446291
; 3513641.86446291
;
; Small number calcualtion:
;
; (sqrt 0.000000001)
;
; Iterations trace:
; 1.0
; 0.5000000005
; 0.25000000125
; 0.125000002625
; 0.06250000531249991
; 0.03125001065624928
; 0.015625021328119184
; 0.007812542664015912
; 0.0039063353316584545
; 0.0019532956630331404
; 0.0009769038091493795
; 0.0004889637256929178
; 0.0002455044335888825
; 0.00012478883989199918
; 6.64011885034502e-5
; 4.073057995332169e-5
; 3.26410788451968e-5
; 3.163866056593726e-5
; 3.162278058889937e-5
; 3.162278058889937e-5
;
; The new function works better for small and large
; numbers. We got more accurate value for
; (sqrt 0.000000001) and got pass the floating point
; problem when calculating (sqrt 12345678901234).