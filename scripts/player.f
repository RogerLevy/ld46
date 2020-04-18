prefab: player
    $0100 attr!  \ 16x32 sprite
    4 bmp#!
;prefab

: extensions:  /userfields ;
: ;extensions  drop ;

\ maybe move this up, for intuitiveness?
extensions:
    include anim.f
    getset state# state#!
    getset dir dir!          \ angle (0=right,90=up...)
;extensions

anim: idle_down_a 0 , ;anim
anim: idle_up_a 1 , ;anim
anim: idle_right_a 6 , ;anim
anim: walk_down_a 2 , 3 , ;anim
anim: walk_up_a 4 , 5 , ;anim
anim: walk_right_a 6 , 7 , 8 , 9 , ;anim

0 constant idle
1 constant walk

: dir-key-pressed?
    <left> pressed  if dir 180 dir! 180 <> exit then 
    <right> pressed if dir 0 dir!   0 <> exit then 
    <up> pressed    if dir 90 dir!  90 <> exit then 
    <down> pressed  if dir 270 dir! 270 <> exit then
    0 ;

: dir-key-letgo?
    dir case
        0 of <right>  letgo exit endof
        90 of <up>    letgo exit endof
        180 of <left> letgo exit endof
        270 of <down> letgo exit endof
    endcase
;    

player :: think
    state# case
        idle of
            dir-key-pressed? if walk state#! recurse exit then
            dir case
                0 of 0 flip! 0e idle_right_a frame ixy! endof
                90 of 0e idle_up_a frame ixy! endof
                180 of 1 flip! 0e idle_right_a frame ixy! endof
                270 of 0e idle_down_a frame ixy! endof
            endcase
        endof
        walk of
            dir-key-letgo? if idle state#! recurse exit then
            dir-key-pressed? if walk state#! recurse exit then
            1e 8e f/ +counter 
            dir case
                0 of   x 1e f+ x! counter walk_right_a frame ixy!  0 flip! endof
                90 of  y 1e f- y! counter walk_up_a frame ixy! endof
                180 of x 1e f- x! counter walk_right_a frame ixy!  1 flip! endof
                270 of y 1e f+ y! counter walk_down_a frame ixy! endof
            endcase
        endof
    endcase    
;
