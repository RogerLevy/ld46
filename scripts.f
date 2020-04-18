

require lib/fv2d.f
require sprex.f
require objlib.f
require ld46-utils.f

/OBJECT
    fgetset vx vx!
    fgetset vy vy!
to /OBJECT

: prefab: prefab:
    1e scalex! 1e scaley! \ all floats need to be initialized ...
    0e angle!
    0e vx! 0e vy!
;

require tilecol.f  ( needs vx vy )
anew scripts
0 script scripts/lemming
1 script scripts/lemmingr
2 script scripts/testani
3 script scripts/drunk
4 script scripts/player
5 script scripts/greencar