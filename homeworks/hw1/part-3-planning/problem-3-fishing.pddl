
(define (problem go-fish)
   (:domain fishing)

   (:objects
      npc - player
      cottage gardenpath fishingpond gardenpath windingpath talltree drawbridge courtyard towerstairs tower dungeonstairs dungeon greatfeastinghall throneroom - location
      in out north south east west up down - direction
      pole rose crown fish - item
   )

   (:init
      (connected cottage out gardenpath)
      (connected gardenpath in cottage)
      (connected gardenpath south fishingpond)
      (connected fishingpond north gardenpath)
      (at npc cottage)
      (at pole cottage)
      (haslake fishingpond)
   )

   (:goal (and (inventory npc fish)))
)
