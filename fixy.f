variable (f)
: conv  (f) !  (f) sf@ f>p ;

: fix-objects
    max-objects 0 do
        i object [[ en if
            x conv x!
            y conv y!
            angle conv angle!
            scalex conv scalex!
            scaley conv scaley!
            ofsx conv ofsx!
            ofsy conv ofsy!
            orgx conv orgx!
            orgy conv orgy!
        then ]]
    loop
;
