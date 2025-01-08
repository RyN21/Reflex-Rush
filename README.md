A 2 dimensional game built with Ruby on Gosu
Ruby Version 3.2.2
Gems:
  gosu
  Rspec
  Pry

Built from ground up by first creating a window, player, and rock object. 
The object of the game is to not get hit by the flying rocks. 

Player features:
  Move right and left along the x axis
  Smooth jump - Jump strength declines as player gets higher
  Gravity pulls player to ground when not jumping
  Indicates when player and rock makes contact by relative distance 

Rock features:
  Rock bounces within the window and floor of the snece
  Rock has a slight rotation for visual effect
  Points are scored the rock taps the ceiling (Player successfully avoided rock each time it taps ceiling)

Window Features:
  Has an array of backgrounds for each level
  Gives commands to move player
  Draws score and level
  Plays game music on loop
