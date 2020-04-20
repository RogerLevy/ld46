require ld46-utils.f

1 value nextid

: one-object  ( prefab# - ) 
    max-objects 0 do
        i object [[ en not if
            become nextid id! 1 +to nextid
            at@ 2s>f xy!
            start
        me ]] unloop exit then
        ]] 
    loop -1 abort" Out of object mem."
;

: dismiss  ( object - ) [[ 0 en! 0 id! ]] ;


require lib/fv2d.f

max-objects stack found
: surrounding  {: f: radius | len -- stack len :}
    0 to len
    max-objects 0 do
        i object me <> if
            i object 's xy xy fdist radius f<= if
                i object found push 1 +to len then
        then
    loop
    found len
;
