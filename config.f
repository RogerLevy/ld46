require sprex.f

: load-data
    s" data.f" included
    s" scenes.f" included
;

: init-game
    [ dev not ] [if] display al_hide_mouse_cursor [then]
    1 load
    \ 0 object as pair become start
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