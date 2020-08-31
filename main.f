
empty only forth definitions

include lib/roger.f
include lib/fixed.f
include lib/stackarray.f
include lib/game.f        \ Load prelude of game lib

require lib/pv2d.f        \ Experimental 2d float ops
require keys.f            \ Key code constants
require lib/filelib.f     \ File ops
require utils.f           \ Miscellanea
require input.f           \ Standard input polling (kb and mouse)
require scene.f           \ Scene system; tilemaps, objects, tileset data

require script.f          \ Object scripting system
include scripts.f         \ Load scripts (define behavior for game objects)
include config.f          \ Configure the game core

include lib/go.f          \ Load epilogue of game lib; startup, main loop, shutdown

export? [if] \ turnkey (save) breaks reloading
    turnkey "Alright, We're Gonna Walk Now..."
[then]  
init -audio
