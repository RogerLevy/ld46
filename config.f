require sprex.f


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
            think  x vx f+ x!  y vy f+ y!
        then ]]
    loop
;