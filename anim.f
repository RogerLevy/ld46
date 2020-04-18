fgetset counter counter!

: +counter counter f+ counter! ;

: anim:  create here 0 , ;

: ;anim  here over cell+ - cell/ swap ! ;

( TODO: could be optimized with a "bmpcols" array )

: framexy  ( f: counter anim - ix iy )
    dup @ >r cell+ f>s r> mod cells + @
    bmp# bmp bmpw iw / /mod ih * swap iw * swap 
;

: ixy!  iy! ix! ;

: animate  +counter counter framexy ixy! ;