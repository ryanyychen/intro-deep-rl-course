
(define (domain fishing)
   (:requirements :strips :typing)
   (:types player location direction monster item)

   (:action go
      :parameters (?dir - direction ?p - player ?l1 - location ?l2 - location)
      :precondition (and (at ?p ?l1) (connected ?l1 ?dir ?l2) (not (blocked ?l1 ?dir ?l2)))
      :effect (and (at ?p ?l2) (not (at ?p ?l1)))
   )

   (:action get
      :parameters (?i - item ?p - player ?l - location)
      :precondition (and (at ?p ?l) (at ?i ?l))
      :effect (and (not (at ?i ?l)) (inventory ?p ?i))
   )

   (:action drop
      :parameters (?i - item ?p - player ?l - location)
      :precondition (and (at ?p ?l) (inventory ?p ?i))
      :effect (and (at ?i ?l) (not (inventory ?p ?i)))
   )

   (:action gofish
      :parameters (pole - item ?p - player ?l - location fish - item)
      :precondition (and (at ?p ?l) (inventory ?p pole) (haslake ?l))
      :effect (and (at fish ?l))
   )
)
