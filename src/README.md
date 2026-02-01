# What files to put here

files which have to be edited within godot or an other code editor

- all godot releated files

Please try to keep the deepth of the folder structur shallow so that it is easy to navigate.

I propose:

```
src
	|-main
	|   |-main.tscn -> main entry point of the game
	|    L> ... other global files which are used in all scenes
	|-game
	|   |-game.tscn -> global game scene which is the base of all game scenes
	|   |-game.gd -> script which is attached to the root node of the game.tscn
	|   |-objects
	|   |   |-player/...
	|   |   |-coins/...
	|   |   |-> ... subfolders for each game related object e.g. player
	|   |-levels (for level definitions, level layouts if we ar going to have levels...)
	|   |   |->level1
	|   |   |->level2
	|   |   |->...
	|-mainmenu
	|-... other e.g. settings menus
	|-ui -> folder for global ui elements which can be used everywhere
```
