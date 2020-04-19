prefab: player
    $0100 attr!  \ 16x32 sprite
    4 bmp#!
    : extensions:  /userfields ;
    : ;extensions  drop ;
    extensions:
        include anim.f
        getset state# state#!        
        fgetset dir dir!          \ angle (0=right,90=down...)
        fgetset speed speed!
    ;extensions

;prefab

anim: idle_down_a 0 , ;anim
anim: idle_up_a 1 , ;anim
anim: idle_right_a 6 , ;anim
anim: walk_down_a 2 , 3 , ;anim
anim: walk_up_a 4 , 5 , ;anim
anim: walk_right_a 6 , 7 , 8 , 9 , ;anim

0 constant idle
1 constant walk

: dir-key-held?
    <up> held <down> held <right> held <left> held or or or 
;

: kb>xdir  0e <right> held if 1e f+ then  <left> held if 1e f- then ;
: kb>ydir  0e <down> held if 1e f+ then  <up> held if 1e f- then ;

: awithin?  2dup < if within? else rot 360 + -rot 360 + within? then ;

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
    dir f>s 315 45  awithin? if walk_right_a animate  0 flip!  exit then
    dir f>s 135 225 awithin? if walk_right_a animate  1 flip!  exit then
;

player :: think
    dir-key-held? if
        1e speed! walk state#!
        kb>xdir kb>ydir fangle dir!
    else
        0e speed! idle state#!
    then
    
    dir speed fvec vy! vx!
    state# case
        idle of
            idle-animation
        endof
        walk of
            walk-animation
        endof
    endcase
    do-collisions
;
