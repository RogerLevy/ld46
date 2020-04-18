prefab: testani
    \ 224 ix! 0 iy!
    $0303 attr!  \ 64x64 sprite
    2 bmp#!
;prefab

: extensions:  /userfields ;
: ;extensions  drop ;

extensions:
    include anim.f
;extensions

anim: cycle_a 0 , 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9 , 10 , 11 ,
    12 , 13 , 14 , 15 , ;anim

testani :: think
    0.5e +counter counter cycle_a frame ixy!
;
