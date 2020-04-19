require sprex.f

: load
    load
    max-objects 0 do i object [[ en if start then ]] loop
;

: load-data
    s" data.f" included
    s" scenes.f" included
;

: init-game
    1 load
;


:while game update
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
    
    [ dev ] [if]
        0 0 at zstr[ 0 object 's debug ]zstr print
    [then]
;

:while game step
    finit
    max-objects 0 do
        i object [[ en if
            think  x vx f+ x!  y vy f+ y!
        then ]]
    loop
;