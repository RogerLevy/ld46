( scaled/rotated sprites - fairly slow )
( high bit of attributes enables transformation )

/OBJECT
    fgetset angle angle!
    fgetset scalex scalex!
    fgetset scaley scaley!
to /OBJECT

: ~sprex  attr $80000000 or attr! ;
: sprex   attr $80000000 and 0<> ;

: draw-as-sprite-ex  ( bitmap# - )
    bmp ?dup if
        ( bitmap ) ix iy iw ih al_create_sub_bitmap >r
        r@ r@ bmpw 2 / r@ bmph 2 / 2s>f  x floor y floor  
            scalex scaley angle deg>rad flip al_draw_scaled_rotated_bitmap
        r> al_destroy_bitmap
    then
;

: draw-sprites-ex ( - )
    1 al_hold_bitmap_drawing
    max-objects 0 do
        i object to me
        en if
            sprex if
                bmp# draw-as-sprite-ex
            else
                bmp# draw-as-sprite 
            then
        then
    loop
    0 al_hold_bitmap_drawing
;
