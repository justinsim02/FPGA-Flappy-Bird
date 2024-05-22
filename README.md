# FPGA-Flappy-Bird
In this game, the user controls a dot’s vertical movement as it flies past obstacles. These obstacles are vertical lines with a small opening for the bird to pass through, the position of the hole is randomly generated and are spaced out about 5 pixels apart.

Materials:
DE1-SoC FPGA board
DE-1 LED Display Expansion Board 16x16

Modules:
LEDDriver
 a given module that instantiates the LED Board (‘set once and forget it’)
bird_position
Determines the vertical position of our bird. If KEY3 is pressed, the bird will “fly” up, if not then the bird will drop
Horizontal position is fixed
tube_position
Moves the tubes towards the left of the board
Vertical position remains fixed after tube pair is created
tube_creation
Randomly generates tube sizes and initiates them on the right side of the board
Lab7
Top level module that is uploaded onto the board

