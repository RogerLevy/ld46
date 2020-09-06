
empty only forth definitions

include lib/roger.f
include lib/fixed.f
include lib/stackarray.f
include lib/game.f        \ Prelude of game library

require lib/pv2d.f        \ Experimental 2d float ops
require keys.f            \ Key code constants
require lib/filelib.f     \ File ops
require utils.f           \ Miscellanea
require input.f           \ Standard input polling (kb and mouse)
require scene.f           \ Scene system (loads tilemaps & objects)
require script.f          \ Object scripting system

\ ----------------------------------------------------------------------

include scripts.f         \ Load scripts (define behavior for game objects)

\ ----------------------------------------------------------------------

: load-data  \ called at startup
    s" data.f" included
    s" scenes.f" included
;

: init-game  \ called at startup after load-data; "soft reset"
    z" data/BGM/alritebgm.ogg" streamloop
    [ dev not ] [if] display al_hide_mouse_cursor [then]
    \ 1 load
    \ 0 object as pair become start
    title
;

\ ----------------------------------------------------------------------

include lib/go.f          \ Load epilogue of game lib; startup, main loop, shutdown

export? [if] \ turnkey (save) breaks reloading
    turnkey "Alright, We're Gonna Walk Now..."
[then]  
init
-audio
