1 value nextid

: one-object  ( prefab# - object )  \ instance an object
    max-objects 0 do
        i object [[ en not if
            become nextid id! 1 +to nextid
            at@ p swap p swap xy!
            start
        me ]] unloop exit then
        ]] 
    loop -1 abort" Out of object mem."
;

: dismiss  ( object - ) [[ 0 en! 0 id! ]] ;

max-objects stack found
: surrounding  {: radius len -- stack len :}
    0 to len
    max-objects 0 do
        i object me <> if
            i object 's xy xy pdist radius <= if
                i object found push 1 +to len then
        then
    loop
    found len
;
