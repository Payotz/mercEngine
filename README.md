A WIP 2D engine made in Dlang using SDL.

### How do I get set up? ###

You need [Dub](http://code.dlang.org/download) and [DMD](http://dlang.org/download.html#dmd) to build it.

### Dependencies ###

SDL2.dll 

SDL2_mixer

SDL2_ttf

SDL2_net

SDL2_image

lua 5.3

### How it works ? ###

Put the Runtime Binaries inside /build/ and just run dub at the root of the directory.

Actual Game Project files are in /build/resources. 

start.lua is modified to load the 'main.lua' files inside a respective Game Folder, hence loading Game.



### DISCLAIMER ###
Assets are placeholder and are not mine.

As of now, the scripting language is incomplete.

You can check the bindings in /source/ml_engine/core/script

This project is still highly unstable
