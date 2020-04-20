require ld46-utils.f
require lib/fv2d.f
require objlib.f
require common.f

anew scripts
: prefab:
    prefab:
    1e scalex! 1e scaley! \ all floats need to be initialized ...
    0e angle!
    0e ofsx! 0e ofsy!
    0e vx! 0e vy!
    0e mbx! 0e mby!
    16e mbw! 16e mbh!
    /userfields
;
: ;prefab drop ;

: do-collisions
    bgp3 do-tilemap-physics
;

0 script scripts/lemming
1 script scripts/lemmingr
2 script scripts/testani
3 script scripts/drunk
4 script scripts/player
11 script scripts/pair       \ <--- depends on some player code
5 script scripts/greencar
6 script scripts/purplecar

12 script scripts/zone
7 script scripts/alleyzone
8 script scripts/bbqzone
9 script scripts/depotzone
10 script scripts/pizzazone
