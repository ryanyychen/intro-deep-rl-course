'''
    (:action preheat
        :parameters (?p - player)
        :precondition (and (at ?p oven) (not (hot oven)))
        :effect (and (hot oven)) ; preheats the oven
    )

    (:action bake
        :parameters (?i1 - coconut ?p - player)
        :precondition (and (at ?p oven) (hot oven) (not (pressed ?i1)))
        :effect (and (heated ?i1) (not (hot oven))) ; bakes the coconut in the oven, oven now cold
    )

    (:action heat
        :parameters (?i1 - coconut ?p - player)
        :precondition (and (at ?p microwave) (not (pressed ?i1)))
        :effect (and (heated ?i1)) ; heats the coconut in the microwave
    )

    (:action separatemeat
        :parameters (?i1 - coconut ?i2 - knife ?p - player ?l - location)
        :precondition (and (at ?p ?l) (at ?i1 ?l) (at ?i2 ?l) (is_open ?i1) (on ?i2 ?i1) (not (pressed ?i2)) (has_meat ?i1))
        :effect (and (not (has_meat ?i1)) (at meat ?l)) ; separates meat from coconut with knife, place meat at location
    )
'''