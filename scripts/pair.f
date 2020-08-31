prefab: pair
    $0502 attr!
    5 bmp#!
;prefab
ext:
    include anim.f
    include state.f
    pgetset dir dir!          \ angle (0=right,90=down...)
    pgetset speed speed!
    pgetset stamina stamina!
;ext


anim: idle_down_a  4 , 6 , ;anim
anim: idle_up_a    8 , 10 , ;anim
anim: idle_right_a 0 , 2 , ;anim
anim: walk_up_a  8 , 9 , 10 , 11 , ;anim
anim: walk_down_a    4 , 5 , 6 , 7 , ;anim
anim: walk_right_a 0 , 1 , 2 , 3 , ;anim

: ?animate  ( speed up down left right -- )
    dir p>s 45 135  within? if drop drop nip animate exit then
    dir p>s 225 315 within? if drop drop drop animate  exit then
    dir p>s 45 < dir p>s 315 > or if nip nip nip animate  0 flip!  exit then
    dir p>s 135 225 within? if drop nip nip animate  1 flip!  then
;

0 state: stop idle    
1 state: walk walking

: idle-animation  1 30 p/  idle_up_a idle_down_a idle_right_a idle_right_a  ?animate ;
: walk-animation  1 15 p/  walk_up_a walk_down_a walk_right_a walk_right_a  ?animate ;

:start stop 0 speed! ;
:step stop  dir-key-held? if walk then ;

:start walk  ;
:step walk
    dir-key-held? if
        1 2 p/ speed! 
        kb>xdir kb>ydir pangle dir!
    else
        stop
    then
;

: separate
    dir 4 become start dir! 
    xy 3 one-object dup >r [[ xy! start ]]
    dir 180 p + 360 p mod r> [[ drunk-dir! 0 attention!
        *distraction* false to following? ]]
;


pair :: think
    \ logic
    stamina 0 <= if separate exit then
    do-state
    car1 30 near? if win exit then
    <x> letgo if separate exit then
    lifetime 60 mod 0= if 6 rnd 0= if *ramble* then then
 
    \ physics
    dir speed pvec vy! vx!
    do-collisions

    \ animation
    state# case
        idle of idle-animation endof
        walking of walk-animation endof
    endcase
    
    lifetime 1 + lifetime!
    stamina 1 4 p/ - stamina!
;

pair :: start
    0 mbx! 24 p mby! 16 p mbw! 8 p mbh!
    sprex/
    -16 p ofsx! -32 p ofsy!
    stop
    1 lifetime!  \ avoid double sounds
    100 p stamina!
;
