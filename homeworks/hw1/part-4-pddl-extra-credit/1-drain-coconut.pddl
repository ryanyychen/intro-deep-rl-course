
(define (problem drain-coconut)
    (:domain open-a-coconut)

    (:objects
        self - player
        table - location
        left right up down - direction
        coconut - coconut
        hammer - hammer
        screwdriver - screwdriver
        glass - container
    )

    (:init
        (at coconut table)
        (has_water coconut)
        (at screwdriver table)
        (at hammer table)
        (at glass table)
        (at self table)
    )

    (:goal (and (has_water glass)))
)
