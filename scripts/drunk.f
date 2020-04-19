prefab: drunk
    $0100 attr!  \ 16x32 sprite
    3 bmp#!
    : extensions:  /userfields ;
    : ;extensions  drop ;
    extensions:
        include anim.f
        getset state# state#!        
        fgetset dir dir!          \ angle (0=right,90=down...)
        fgetset speed speed!
        getset flail flail!      \ flail selector
        getset adrenalin adrenalin!
        getset attention attention!
    ;extensions
;prefab

require lib/strout.f

anim: idle_down_a 0 , ;anim
anim: idle_up_a 1 , ;anim
anim: idle_right_a 6 , ;anim
anim: walk_down_a 2 , 3 , ;anim
anim: walk_up_a 4 , 5 , ;anim
anim: walk_right_a 6 , 7 , 8 , 9 , ;anim
anim: waddle_down_a 10 , 11 , 12 , 13 , ;anim
anim: waddle_up_a 14 , 15 , 16 , 17 , ;anim
anim: waddle_right_a 18 , 9 , 19 , ;anim

0 constant idle
1 constant walk

: awithin?  2dup <= if within? else rot 360 - rot 360 - rot within? then ;

: idle-animation
    dir f>s 315 45  awithin? if 0e idle_right_a animate  0 flip!  then
    dir f>s 45 135  awithin? if 0e idle_down_a  animate  then
    dir f>s 135 225 awithin? if 0e idle_right_a animate  1 flip!  then
    dir f>s 225 315 awithin? if 0e idle_up_a    animate  then
;

: walk-animation
    1e 12e f/ ( animation speed )
    dir f>s 45 135  awithin? if walk_down_a  animate  exit then
    dir f>s 225 315 awithin? if walk_up_a    animate  exit then
    dir f>s 45 < dir f>s 315 > or if walk_right_a animate  0 flip!  exit then
    dir f>s 135 225 awithin? if walk_right_a animate  1 flip!  exit then
    fdrop
;

: waddle-animation
    1e 12e f/ ( animation speed )
    dir f>s 45 135  awithin? if waddle_down_a  animate  exit then
    dir f>s 225 315 awithin? if waddle_up_a    animate  exit then
    dir f>s 45 < dir f>s 315 > or if waddle_right_a animate  0 flip!  exit then
    dir f>s 135 225 awithin? if waddle_right_a animate  1 flip!  exit then
    fdrop
;


: focus 1 object ;

\ : -v  0 0 vx 2! ;
\ : rdelay  0.5 2 between delay ;

: distance  's xy xy fdist ;
: close?  focus distance 50e f< ;

\ : /wander  
\     0 perform> begin    
\         leader @ if
\             close? if
\                 360 rnd 0.5 vec vx 2! rdelay -v rdelay 
\             else
\                 pause
\             then
\         else
\             -v rdelay 360 rnd 0.5 vec vx 2! rdelay 
\         then
\     again ;

: chase   focus 's xy  xy  2f-  fangle dir! 0.6666e speed! ;

\ : enlist  p1 leader !  enlisted# state !  /wander
\     me party push 
\     act> 
    
: stumbling
    state# walk = adrenalin 1 = and if
        0e speed! idle state#!
    then
    
    adrenalin 1 > if
        walk state#!
        attention 1 = if
            360e frnd dir! 0.6666e speed! 
        else
            attention 1 > if
                close? not if chase else 0e speed! then
            then
        then
    then
    
    attention 1 - 0 max attention!
    adrenalin 1 - 0 max adrenalin!
;

:noname 
    0 object [[ attention 0 = adrenalin 0 = ]] or if
        0 play
        0 object [[
            180 rnd 180 + attention!
            500 rnd 500 + adrenalin!
        ]]
    then
; is call-msg


drunk :: think
    
    \ logic
    stumbling       

    \ physics
    dir speed fvec vy! vx!
    do-collisions    
    
    \ animation
    state# case
        idle of idle-animation endof
        walk of
            lifetime 30 mod 0 = if 5 rnd flail! then
            flail 2 >= if walk-animation else waddle-animation then
        endof
    endcase

    lifetime 1 + lifetime!
;

drunk :: debug
    ." Adrenalin: " adrenalin . ." Attention: " attention .
;

drunk :: start
    180 rnd 180 + attention!
    500 rnd 500 + adrenalin!
    walk state#!
    0e angle!
    0e mbx! 16e mby! 16e mbw! 16e mbh!
;    
