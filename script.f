256 constant max-prefabs

/OBJECT
    getset objtype objtype!
to /OBJECT

/objslot 128 - constant /userfields  \ For object-specific stuff

max-prefabs /objslot array prefab
max-prefabs 1024 array sdata  \ static data such as actions

: lastword  last @ ctrl>nfa count ;

((
Define a prefab 
---------------
Prefabs are to object types as prototypes are to classes. 
Currently it's only where you define the initial values of 
common fields.  Object-specific fields should be initialized 
in the object's START method.
))

: prefab: ( n - <name> ) ( - n )
    dup constant dup prefab [[
    dup >r lastword r> sdata place
    dup objtype!
        16 * s>f fdup xy!  \ default positioning; can be changed using the prefabs.iol file
    true en!
;

: ;prefab ]] ;

: ext: /userfields ;
: ;ext ;


( SDATA refers to Static Data; same idea as static props of a class. )
32  \ name (1+31)
value /sdata

( Methods are vectored words; the sdata is treated as the table. )
: (method!) create /sdata , does> @ objtype sdata + ! ;
: (method) create /sdata  , does> @ objtype sdata + @ execute ;
: method  (method) (method!) cell +to /sdata ;
: ::  ( prefab - <name> )
    prefab [[ :noname ' >body @ objtype sdata + ! ]] ;

method start start!   \ executed when obj is instanced
method think think!   \ executed once a frame

: become  ( n ) >r
    x y
    r> prefab me /objslot move
    y! x! ;

: script  ( n - <name> )   \ (re)load a script
    dup prefab 's en abort" Prefab # already taken"
    false to warnings?
    include
    true to warnings?
;

create temp$ 256 allot

: hone  ( - <name> ) me >r   \ convenience word to reload a script
    false to warnings?
    >in @ ' >body @ swap >in !
    s" scripts/" temp$ place  bl parse temp$ append  temp$ count GetPathSpec included
    true to warnings?
    r> as
;  

: load-prefabs 
    z" prefabs.iol" ?dup if ?exist if
        r/o[ 0 prefab [ lenof prefab /objslot * ]# read ]file
    then then
    s" scripts.f" included
;

: like:  ( - <name> )   \ simple inheritance
    objtype >r
    ' >body @ dup become
    r> objtype!
    ( old ) sdata 32 + objtype sdata 32 + /sdata 32 - move  ( preserve name )
;