
(define (problem full-open-coconut)
    (:domain open-a-coconut)

    (:objects
        self - player
        table ground oven microwave - location
        left right up down - direction
        coconut - coconut
        hammer - hammer
        knife - knife
        towel - towel
        glass - container
        meat - item
    )

    (:init
        (connected table down ground)
        (connected ground up table)
        (connected table right oven)
        (connected oven left table)
        (connected table left microwave)
        (connected microwave right table)
        (at coconut table)
        (has_water coconut)
        (has_meat coconut)
        (at screwdriver table)
        (at hammer table)
        (at knife table)
        (at towel table)
        (at glass table)
        (at self table)
    )

    (:goal (and (has_water glass) (at meat table)))
)
