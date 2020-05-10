
empty only forth definitions
include lib/gl1pre        \ Load prelude of game lib

require lib/fv2d.f        \ Experimental 2d float ops
require keys.f            \ Key code constants
require lib/filelib.f     \ File ops
require ld46-utils.f      \ Miscellanea that I'm used to
require input.f           \ Standard input polling (kb and mouse)
require scene.f           \ Scene system; tilemaps, objects, tileset data

require script.f          \ Object scripting system
include scripts           \ Load scripts (define behavior for game objects)
include config            \ Configure the game core

include lib/gl1post       \ Load epilogue of game lib; startup, main loop, shutdown

export? [if] \ turnkey (save) breaks reloading
    turnkey "Alright, We're Gonna Walk Now..."
[then]  
init
