prefab: drunk
    $0100 attr!  \ 16x32 sprite
    3 bmp#!
    include anim.f
    include state.f 
    fgetset dir dir!          \ angle (0=right,90=down...)
    fgetset speed speed!
    getset flail flail!      \ flail selector
    getset adrenalin adrenalin!
    getset attention attention!
    getset compliance compliance!  \ 0 = non-compliant
;prefab

require lib/strout.f

anim: idle_down_a     0 , ;anim
anim: idle_up_a       1 , ;anim
anim: idle_right_a    6 , ;anim
anim: walk_down_a     2 , 3 , ;anim
anim: walk_up_a       4 , 5 , ;anim
anim: walk_right_a    6 , 7 , 8 , 9 , ;anim
anim: waddle_down_a   10 , 11 , 12 , 13 , ;anim
anim: waddle_up_a     14 , 15 , 16 , 17 , ;anim
anim: waddle_right_a  18 , 9 , 19 , ;anim
anim: fall_down_a     25 , ;anim
anim: fall_right_a    22 , ;anim
anim: sitting_down_a  26 , 27 , ;anim
anim: sitting_right_a 23 , 24 , ;anim
anim: lie_a           28 , 29 , ;anim

: ?animate  ( speed up down left right -- )
    dir f>s 45 135  within? if drop drop nip animate exit then
    dir f>s 225 315 within? if drop drop drop animate  exit then
    dir f>s 45 < dir f>s 315 > or if nip nip nip animate  0 flip!  exit then
    dir f>s 135 225 within? if drop nip nip animate  1 flip!  then
;

0 state: stop idle    
1 state: walk walking 
2 state: sit  sitting 
3 state: konk unconscious 
4 state: fall falling 

: idle-animation  0e idle_up_a idle_down_a idle_right_a idle_right_a  ?animate ;
: walk-animation  1e 12e f/ walk_up_a walk_down_a walk_right_a walk_right_a  ?animate ;
: waddle-animation  1e 12e f/ waddle_up_a waddle_down_a waddle_right_a waddle_right_a   ?animate ;
: lie-animation  1e 12e f/ lie_a animate ;
: sitting-animation  1e 12e f/ sitting_down_a sitting_down_a sitting_right_a sitting_right_a ?animate ;
: fall-animation  0e fall_down_a fall_down_a fall_right_a fall_right_a  ?animate ;

: focus     player1 ;
: distance  's xy xy fdist ;
: close?    focus distance 35e f< ;
: chase     focus 's xy  xy  2f-  fangle dir! 0.6666e speed!  true to following?  ;
: deplete
    attention 1 - 0 max attention!
    adrenalin 1 - 0 max adrenalin!
;

:start stop 0e speed! ;
:step stop
    attention 1 > focus 0<> and if
        close? not if chase walk then
    then
    deplete
;


:start sit 0e speed!  2 rnd compliance!  false to following?  *sit* ;
:step sit  ;

:start walk
    true to following?
    1 compliance!
;
:step walk
    adrenalin 0 = if sit exit then
    attention 1 = if
        *distraction*
        3 rnd compliance!
        360e frnd dir! 0.6666e speed!
        false to following?
    else
        lifetime 120 mod 0= if 5 rnd 0= if *ramble* then then
        attention 1 > focus 0<> and if
            close? if stop else chase then
        then
    then
    deplete
;

:noname 
    drunk1 [[ attention 0 = adrenalin 0 = or ]] if
        *joeyell*
        drunk1 [[
            compliance 0 <> if
                360 rnd 180 + attention!
                500 rnd 500 + adrenalin!
            then
        ]]
    then
; is call-msg

drunk :: think
    
    \ logic
    do-state

    \ physics
    dir speed fvec vy! vx!
    do-collisions    
    
    \ animation
    state# case
        idle of idle-animation endof
        walking of
            lifetime 30 mod 0 = if 5 rnd flail! then
            flail 2 >= if walk-animation else waddle-animation then
        endof
        sitting of sitting-animation endof
        falling of fall-animation endof
        unconscious of lie-animation endof
    endcase

    lifetime 1 + lifetime!
;

drunk :: debug
    ." Drenlin: " adrenalin . ." Attn: " attention . 
;

drunk :: start
    me to drunk1
    360 rnd 180 + attention!
    500 rnd 500 + adrenalin!
    0e angle!  90e dir!
    0e mbx! 24e mby! 16e mbw! 8e mbh!
    *start* *joestart*
    1 lifetime!  \ avoid double sounds
    walk
;    
