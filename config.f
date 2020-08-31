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


