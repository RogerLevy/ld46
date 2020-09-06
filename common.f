( --~~ Common Game-specific Extensions ~~-- )

require sprex.f
require lib/strout.f
require soundcyclers.f
require fixy.f

defer call-msg  ' noop is call-msg
screen win
screen title

/OBJECT
    pgetset vx vx!
    pgetset vy vy!
    getset lifetime lifetime!
    pgetset mbx mbx!
    pgetset mby mby!
    pgetset mbw mbw!
    pgetset mbh mbh!
to /OBJECT

method debug debug!
method trigger trigger!  ( object - )

require tilecol.f  ( needs vx vy )

0 value player1
0 value drunk1
0 value car1
0 value following?
0 value level#

create levels 1 , 5 , 9 , 4 , 8 , 3 , 7 , 2 , 6 ,

: load
    load
    fix-objects
    max-objects 0 do
        i object [[ en if start then ]]
    loop
    *start* 
;

: next-level  level# 1 + 9 mod dup to level# cells levels + @ load ;


: game-update
    2x cls

    1 object [[
        x p>s  160 - 0 max  y p>s 120 - 0 max
        2dup  bgp1 [[ tm.scrolly! tm.scrollx! ]]
        2dup  bgp2 [[ tm.scrolly! tm.scrollx! ]]
              bgp4 [[ tm.scrolly! tm.scrollx! ]]    
    ]]    
    bgp1 [[ draw-as-tilemap ]] 
    bgp2 [[ draw-as-tilemap ]] 

    1 object [[
        m x p>s 160 - 0 max negate zoom p* s>f
          y p>s 120 - 0 max negate zoom p* s>f al_translate_transform
        m al_use_transform 
    ]]
    paintex

    2x
    bgp4 [[ draw-as-tilemap ]]
;

: cprint  >r bif 0e 0e 0e 1e at@ 1 1 2+ 2s>f ALLEGRO_ALIGN_CENTER r@ al_draw_text
            bif 1e 1e 1e 1e at@ 2s>f ALLEGRO_ALIGN_CENTER r> al_draw_text ;

0e fvalue counter
0e fvalue throb
: /throb
    counter deg>rad fcos fnegate 2e f/ 0.5e f+ to throb 2e +to counter ;

:while win resume
    0e to counter
    *end*
;
:while win update
    game-update
    finit
    \ 160 116 at zstr[ ." Made it!" ]zstr cprint
    0e 0e 320e 240e
        0e 0e 0e 0.75e al_draw_filled_rectangle
    /throb
    11 bitmap @ 160e 120e fover fover throb fdup 0e 0 al_draw_scaled_rotated_bitmap
;
:while win step
    <enter> pressed if next-level game then
;

:while title resume
;
:while title update
    12 bitmap @ 0e 0e 0 al_draw_bitmap
;
:while title step
    2x
    <enter> pressed if -1 to level# next-level game then
;

:while game update   \ called once a frame to draw graphics
    game-update
    
    [ dev ] [if]
        0 0 at zstr[ 0 object 's debug ]zstr print
    [then]
;

:while game step     \ called once a frame to move objects
    finit
    max-objects 0 do
        i object [[ en if
            think  x vx + x!  y vy + y!
        then ]]
    loop
;