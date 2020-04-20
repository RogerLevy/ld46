require sprex.f
require lib/strout.f

/OBJECT
    fgetset vx vx!
    fgetset vy vy!
    getset lifetime lifetime!
    fgetset mbx mbx!
    fgetset mby mby!
    fgetset mbw mbw!
    fgetset mbh mbh!
to /OBJECT

method debug debug!

require tilecol.f  ( needs vx vy )

0 value player1
0 value drunk1
0 value car1
0 value following?


: load
    load
    max-objects 0 do i object [[ en if start then ]] loop
;

: game-update
    2x cls

    1 object [[
        x floor 160e f- 0e fmax  y floor 120e f- 0e fmax
        fover fover    bgp1 [[ tm.scrolly! tm.scrollx! ]]
        fover fover    bgp2 [[ tm.scrolly! tm.scrollx! ]]
                       bgp4 [[ tm.scrolly! tm.scrollx! ]]    
    ]]    
    bgp1 [[ draw-as-tilemap ]] 
    bgp2 [[ draw-as-tilemap ]] 

    1 object [[
        m x floor 160e f- 0e fmax fnegate zoom f*
          y floor 120e f- 0e fmax fnegate zoom f* al_translate_transform
        m al_use_transform 
    ]]
    draw-sprites-ex

    2x
    bgp4 [[ draw-as-tilemap ]]
;

screen win

: cprint  >r bif 0e 0e 0e 1e at@ 1 1 2+ 2s>f ALLEGRO_ALIGN_CENTER r@ al_draw_text
            bif 1e 1e 1e 1e at@ 2s>f ALLEGRO_ALIGN_CENTER r> al_draw_text ;

0e fvalue counter
0e fvalue throb
: /throb  counter deg>rad fcos fnegate 2e f/ 0.5e f+ to throb 2e +to counter ;


:while win update
    game-update
    finit
    \ 160 116 at zstr[ ." Made it!" ]zstr cprint
    0e 0e 320e 240e
        0e 0e 0e 0.75e al_draw_filled_rectangle
    /throb
    11 bmp 160e 120e fover fover throb fdup 0e 0 al_draw_scaled_rotated_bitmap
;
:while win step
    <enter> pressed if game 1 load then
;


