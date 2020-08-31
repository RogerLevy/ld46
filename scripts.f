require objlib.f
require common.f

anew scripts
: prefab:
    prefab:
    1 p scalex! 1 p scaley!   \ scale needs to be initialized ...
    0 angle!
    0 ofsx! 0 ofsy!
    0 vx! 0 vy!
    0 mbx! 0 mby!
    16 mbw! 16 mbh!
;

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
