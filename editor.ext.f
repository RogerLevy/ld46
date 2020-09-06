( --~~ Game-specific extensions for the editor ~~-- )

require sprex.f

:noname
    selected 0= if exit then
    etype ALLEGRO_EVENT_KEY_CHAR = if
        <r> keycode = if
            shift? if
                selected [[ angle 45 p - angle! ]]
            else
                selected [[ angle 45 p + angle! ]]
            then
        then
    then
; is objed-ext

cr .( Extension: in OBJED, R and Shift+R rotate the current object ) \ "

: ld46-render-sprites
    paintex
    bgp4 [[ draw-as-tilemap ]] 
;
' ld46-render-sprites is render-sprites

1 load