require sprex.f

:noname
    selected 0= if exit then
    etype ALLEGRO_EVENT_KEY_CHAR = if
        <r> keycode = if
            shift? if
                selected [[ angle 45e f- angle! ]]
            else
                selected [[ angle 45e f+ angle! ]]
            then
        then
    then
; is objed-ext

cr .( Extension: in OBJED, R and Shift+R rotate the current object ) \ "

' draw-sprites-ex is render-sprites

1 load