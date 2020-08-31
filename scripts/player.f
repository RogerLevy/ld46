prefab: player
    $0100 attr!  \ 16x32 sprite
    4 bmp#!
;prefab
ext:
    include anim.f
    getset state# state#!        
    pgetset dir dir!          \ angle (0=right,90=down...)
    pgetset speed speed!
;ext

anim: idle_down_a 0 , ;anim
anim: idle_up_a 1 , ;anim
anim: idle_right_a 6 , ;anim
anim: walk_down_a 2 , 3 , ;anim
anim: walk_up_a 4 , 5 , ;anim
anim: walk_right_a 6 , 7 , 8 , 9 , ;anim
anim: call_down_a 13 , 14 , 15 , 15 , 15 , 15 , ;anim
anim: call_up_a 16 , 17 , 18 , 18 , 18 , 18 , ;anim
anim: call_right_a 10 , 11 , 12 , 12 , 12 , 12 , ;anim

0 constant idle
1 constant walk
2 constant calling

: dir-key-held?
    <up> held <down> held <right> held <left> held or or or ;

: kb>xdir  0 <right> held if 1 p + then  <left> held if 1 p - then ;
: kb>ydir  0 <down> held if 1 p + then  <up> held if 1 p - then ;

: awithin?  2dup < if within? else rot 360 + -rot 360 + within? then ;

: idle-animation
    dir p>s 315 45  awithin? if 0 idle_right_a animate  0 flip!  then
    dir p>s 45 135  awithin? if 0 idle_down_a  animate  then
    dir p>s 135 225 awithin? if 0 idle_right_a animate  1 flip!  then
    dir p>s 225 315 awithin? if 0 idle_up_a    animate  then
;

: walk-animation
    1 12 p/ ( animation speed )
    dir p>s 45 135  awithin? if walk_down_a  animate  exit then
    dir p>s 225 315 awithin? if walk_up_a    animate  exit then
    dir p>s 315 45  awithin? if walk_right_a animate  0 flip!  exit then
    dir p>s 135 225 awithin? if walk_right_a animate  1 flip!  exit then
;

: call-animation
    1 8 p/ ( animation speed )
    dir p>s 45 135  awithin? if call_down_a  animate  exit then
    dir p>s 225 315 awithin? if call_up_a    animate  exit then
    dir p>s 315 45  awithin? if call_right_a animate  0 flip!  exit then
    dir p>s 135 225 awithin? if call_right_a animate  1 flip!  exit then
;

: idle-walk
    dir-key-held? if
        1 p speed! walk state#!
        kb>xdir kb>ydir pangle dir!
    else
        0 speed! idle state#!
    then
;

: call 
    calling state#!
    0e counter!
    call-msg
    0e speed!
;


: ?win
    car1 24 near? drunk1 40 near? and following? and if win exit then
;

: z-logic
    following? not if call then
;

: grapple
    *grab*
    37 play \ "sigh..."
    drunk1 dismiss
    dir 11 become dir! start
;

player :: think

    \ logic
    ?win
    <z> pressed if z-logic then
    <x> pressed if drunk1 24 near? if grapple exit then then
    
    state# case
        idle of idle-walk endof
        walk of idle-walk endof
        calling of counter 6 p >= if idle state#! then endof
    endcase
    
    \ physics
    dir speed pvec vy! vx!
    do-collisions
    
    \ animation
    state# case
        idle of idle-animation endof
        walk of walk-animation endof
        calling of call-animation endof
    endcase
;

player :: start
    me to player1
    0 mbx! 24 p mby! 16 p mbw! 8 p mbh!
    sprex/
    90 p dir!
    stop
;