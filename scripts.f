require lib/fv2d.f
require sprex.f
require objlib.f
require ld46-utils.f
[undefined] vx [if]
    /OBJECT
        fgetset vx vx!
        fgetset vy vy!
        getset lifetime lifetime!
    to /OBJECT
    /sdata
        method debug debug!
    to /sdata
[then]
require tilecol.f  ( needs vx vy )

anew scripts
: prefab: prefab:
    1e scalex! 1e scaley! \ all floats need to be initialized ...
    0e angle!
    0e vx! 0e vy!
;
: do-collisions
    bgp3 do-tilemap-physics
;

0 script scripts/lemming
1 script scripts/lemmingr
2 script scripts/testani
3 script scripts/drunk
4 script scripts/player
5 script scripts/greencar