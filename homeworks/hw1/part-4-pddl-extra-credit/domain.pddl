
(define (domain open-a-coconut)
    (:requirements :strips :typing)
    (:types
        coconut - item
        hammer - item
        screwdriver - item
        knife - item
        container - item
        towel - item
        player location direction
    )

    (:predicates
        (has_hole ?coconut - coconut) ; whether the coconut has a hole
        (is_open ?coconut - coconut) ; whether the coconut is open
        (has_water ?i - item) ; whether the item has water
        (has_meat ?coconut - item) ; whether the coconut has meat
        (heated ?coconut - coconut) ; whether the coconut is hot
        (in ?i1 - item ?i2 - item) ; whether i1 is in i2
        (on ?i1 - item ?i2 - item) ; whether i1 is on i2
        (ontop ?i - item) ; whether item is on top of something
        (pressed ?i - item) ; whether something is on the item
        (hot ?l - location) ; specifically for oven, true if oven is hot
        (inventory ?p - player ?i - item) ; whether the player has the item in their inventory
        (connected ?l1 - location ?d - direction ?l2 - location) ; whether l1 is connected to l2 via direction d
    )

    (:action move
        :parameters (?p - player ?l1 - location ?d - direction ?l2 - location)
        :precondition (and (at ?p ?l1) (connected ?l1 ?d ?l2))
        :effect (and (not (at ?p ?l1)) (at ?p ?l2))
    )

    (:action get
      :parameters (?i - item ?p - player ?l - location)
      :precondition (and (at ?p ?l) (at ?i ?l) (not (pressed ?i)) (not (ontop ?i)))
      :effect (and (not (at ?i ?l)) (inventory ?p ?i))
    )

    (:action drop
        :parameters (?i - item ?p - player ?l - location)
        :precondition (and (at ?p ?l) (inventory ?p ?i))
        :effect (and (at ?i ?l) (not (inventory ?p ?i)))
    )

    (:action position
        :parameters (?i1 - item ?i2 - item ?p - player ?l - location)
        :precondition (and (at ?p ?l) (at ?i1 ?l) (at ?i2 ?l) (not (pressed ?i1)) (not (pressed ?i2)))
        :effect (and (on ?i1 ?i2) (pressed ?i2) (ontop ?i1)) ; places i1 on top of i2
    )

    (:action remove
        :parameters (?i1 - item ?i2 - item ?p - player ?l - location)
        :precondition (and (at ?p ?l) (at ?i2 ?l) (on ?i1 ?i2) (not (pressed ?i1)))
        :effect (and (not (on ?i1 ?i2)) (not (pressed ?i2)) (not (ontop ?i1))) ; removes i1 from on top of i2
    )

    (:action poke
        :parameters (?i1 - coconut ?i2 - screwdriver ?i3 - hammer ?p - player ?l - location)
        :precondition (and (at ?p ?l) (at ?i1 ?l) (on ?i2 ?i1) (on ?i3 ?i2) (not (pressed ?i3)))
        :effect (and (in ?i2 ?i1) (not (on ?i2 ?i1))) ; pokes hole in coconut with screwdriver, screwdriver now in coconut
    )

    (:action takeout
        :parameters (?i1 - item ?i2 - item ?p - player ?l - location)
        :precondition (and (at ?p ?l) (at ?i1 ?l) (at ?i2 ?l) (in ?i1 ?i2) (not (pressed ?i1)))
        :effect (and (not (in ?i1 ?i2)) (not (pressed ?i2)) (not (ontop ?i1)) (has_hole ?i2)) ; takes screwdriver out of coconut, coconut now has hole
    )

    (:action drain
        :parameters (?i1 - coconut ?i2 - container ?p - player ?l - location)
        :precondition (and (at ?p ?l) (at ?i1 ?l) (at ?i2 ?l) (has_hole ?i1) (has_water ?i1) (not (has_water ?i2)) (on ?i1 ?i2))
        :effect (and (not (has_water ?i1)) (has_water ?i2)) ; drains water from coconut into container
    )

    (:action wrap
        :parameters (?i1 - coconut ?i2 - towel ?p - player ?l - location)
        :precondition (and (at ?p ?l) (at ?i1 ?l) (at ?i2 ?l) (not (pressed ?i1)) (not (pressed ?i2)))
        :effect (and (on ?i2 ?i1) (pressed ?i1) (ontop ?i2)) ; wraps coconut with towel, towel now on top of coconut
    )

    (:action strike
        :parameters (?i1 - coconut ?i2 - towel ?i3 - hammer ?p - player ?l - location)
        :precondition (and (at ?p ?l) (at ?i1 ?l) (at ?i2 ?l) (at ?i3 ?l) (on ?i2 ?i1) (on ?i3 ?i2) (not (pressed ?i3)) (not (ontop ?i1)) (not (has_water ?i1)))
        :effect (and (is_open ?i1)) ; strike coconut with hammer, coconut is now open
    )

    (:action smash
        :parameters (?i - coconut ?p - player)
        :precondition (and (at ?p ground) (at ?i ground) (not (is_open ?i)) (not (pressed ?i)) (not (ontop ?i)) (not (has_water ?i)))
        :effect (and (is_open ?i)) ; smashes coconut on ground, coconut is now open
    )

    (:action preheat
        :parameters (?p - player)
        :precondition (and (at ?p oven) (not (hot oven)))
        :effect (and (hot oven)) ; preheats the oven
    )

    (:action bake
        :parameters (?i - coconut ?p - player)
        :precondition (and (at ?p oven) (hot oven) (not (pressed ?i)) (inventory ?p ?i))
        :effect (and (heated ?i) (not (hot oven))) ; bakes the coconut in the oven, oven now cold
    )

    (:action heat
        :parameters (?i - coconut ?p - player)
        :precondition (and (at ?p microwave) (not (pressed ?i)) (inventory ?p ?i))
        :effect (and (heated ?i)) ; heats the coconut in the microwave
    )

    (:action separatemeat
        :parameters (?i1 - coconut ?i2 - knife ?p - player ?l - location)
        :precondition (and (at ?p ?l) (at ?i1 ?l) (at ?i2 ?l) (is_open ?i1) (on ?i2 ?i1) (not (pressed ?i2)) (has_meat ?i1))
        :effect (and (not (has_meat ?i1)) (at meat ?l)) ; separates meat from coconut with knife, place meat at location
    )
)
