
(define (problem crack-hot-coconut)
    (:domain open-a-coconut)

    (:objects
        self - player
        table ground oven microwave - location
        left right up down - direction
        coconut - coconut
        hammer - hammer
        knife - knife
        towel - towel
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
        (has_hole coconut)
        (has_meat coconut)
        (at hammer table)
        (at knife table)
        (at towel table)
        (at self table)
    )

    (:goal (and (at meat table) (heated coconut)))
)
