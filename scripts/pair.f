prefab: pair
    $0502 attr!
    5 bmp#!
    include anim.f
    include state.f
    fgetset dir dir!          \ angle (0=right,90=down...)
    fgetset speed speed!
;prefab

anim: idle_down_a  4 , 6 , ;anim
anim: idle_up_a    8 , 10 , ;anim
anim: idle_right_a 0 , 2 , ;anim
anim: walk_up_a  8 , 9 , 10 , 11 , ;anim
anim: walk_down_a    4 , 5 , 6 , 7 , ;anim
anim: walk_right_a 0 , 1 , 2 , 3 , ;anim

: ?animate  ( speed up down left right -- )
    dir f>s 45 135  within? if drop drop nip animate exit then
    dir f>s 225 315 within? if drop drop drop animate  exit then
    dir f>s 45 < dir f>s 315 > or if nip nip nip animate  0 flip!  exit then
    dir f>s 135 225 within? if drop nip nip animate  1 flip!  then
;

0 state: stop idle    
1 state: walk walking

: idle-animation  1e 30e f/  idle_up_a idle_down_a idle_right_a idle_right_a  ?animate ;
: walk-animation  1e 15e f/  walk_up_a walk_down_a walk_right_a walk_right_a  ?animate ;

:start stop 0e speed! ;
:step stop  dir-key-held? if walk then ;

:start walk  ;
:step walk
    dir-key-held? if
        0.5e speed! 
        kb>xdir kb>ydir fangle dir!
    else
        stop
    then
;

pair :: think
    \ logic
    do-state
    car1 20e near? if win then
 
    \ physics
    dir speed fvec vy! vx!
    do-collisions

    \ animation
    state# case
        idle of idle-animation endof
        walking of walk-animation endof
    endcase
;

pair :: start
    0e mbx! 24e mby! 16e mbw! 8e mbh!
    ~sprex
    -16e ofsx! -32e ofsy!
    stop
;
