require sprex.f

: load-data
    s" data.f" included
    s" scenes.f" included
;

: init-game
    1 load
;


:while game update
    game-update
    
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