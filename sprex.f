( scaled/rotated sprites - fairly slow )
( high bit of attributes enables transformation )

/OBJECT
    pgetset angle angle!
    pgetset scalex scalex!
    pgetset scaley scaley!
    pgetset ofsx ofsx!
    pgetset ofsy ofsy!
    pgetset orgx orgx!
    pgetset orgy orgy!
to /OBJECT

: sprex/  attr $80000000 or attr! ;
: sprex   attr $80000000 and 0<> ;

: drawex  ( - )
    bmp# bitmap @ ?dup if
        ( bitmap ) ix iy iw ih al_create_sub_bitmap >r
        r@
            r@ bmpw p 2 / orgx + p>f
            r@ bmph p 2 / orgy + p>f
            x pfloor r@ bmpw p 2 / + ofsx + p>f
            y pfloor r@ bmph p 2 / + ofsy + p>f
            scalex p>f scaley p>f angle p>f deg>rad flip
                al_draw_scaled_rotated_bitmap
        r> al_destroy_bitmap
    then
;

: paintex ( - )
    1 al_hold_bitmap_drawing
    max-objects 0 do
        i object to me
        en if
            sprex if
                drawex
            else
                draw
            then
        then
    loop
    0 al_hold_bitmap_drawing
;
