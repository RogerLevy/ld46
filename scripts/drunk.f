prefab: drunk
    $0100 attr!  \ 16x32 sprite
    3 bmp#!
;prefab

: extensions:  /userfields ;
: ;extensions  drop ;

extensions:
    include anim.f
;extensions

anim: idle_down_a 0 , ;anim
anim: idle_up_a 1 , ;anim
anim: idle_right_a 6 , ;anim
anim: walk_down_a 2 , 3 , ;anim
anim: walk_up_a 4 , 5 , ;anim
anim: walk_right_a 6 , 7 , 8 , 9 , ;anim

drunk :: think
    1e 16e f/ +counter counter idle_down_a frame ixy!
;
