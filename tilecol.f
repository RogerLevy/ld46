( Simple tilemap collision )

require ld46-utils.f

: ~solid  attr $40000000 or attr! ;

( what sides the object collided )
0 value lwall?
0 value rwall?
0 value floor?
0 value ceiling?

defer on-tilemap-collide ( tileval - )
    ' drop is on-tilemap-collide  

#1 constant BIT_CEL
#2 constant BIT_FLR
#4 constant BIT_WLT
#8 constant BIT_WRT

module collisioning
    
    0 value map

    : tileprops@   ( tileval - bitmask )
        $ffff and 1 = 
        ; \ $ffff and map 's tm.bmp# tileflags ;
    
    : map@  ( col row - tile )
        map find-tile @ ;

    : cel? BIT_CEL and ; \ ' ceiling '
    : flr? BIT_FLR and ; \ ' floor '
    : wlt? BIT_WLT and ; \ ' wall left '
    : wrt? BIT_WRT and ; \ ' wall right '
    
    0e fvalue nx
    0e fvalue ny
    0 value t
    
    : gap  16e ; 
    : px  x ;
    : py  y ;
    : mbw iw s>f ;
    : mbh ih s>f ;    

    : xy>cr  ( f: x y - c r )
        fswap gap f/ f>s gap f/ f>s ;
        
    : pt  ( f: x y - n )  \ point
        xy>cr  map@ dup to t   tileprops@ ;          

    ( increment coordinates )
    : ve+  fswap gap f+  px mbw f+ 1e f-  fmin  fswap ;
    : he+  gap f+  mbh ny f+ 1e f-  fmin ;

    : +vy  +to ny ny py f- vy! ;
    : +vx  +to nx nx px f- vx! ;

    ( push up/down )
    : pu ( xy ) fnip gap fmod fnegate +vy  true to floor?  t on-tilemap-collide  ;
    : pd ( xy ) fnip gap fmod fnegate gap f+ +vy  true to ceiling?  t on-tilemap-collide ;

    ( check up/down )
    : f2dup fover fover ;
    : f2drop fdrop fdrop ;
    : cu mbw gap f/ f>s 2 + 0 do f2dup pt cel? if pd unloop exit then ve+ loop f2drop ;
    : cd mbw gap f/ f>s 2 + 0 do f2dup pt flr? if pu unloop exit then ve+ loop f2drop ;

    ( push left/right )
    : pl ( xy ) fdrop gap fmod fnegate +vx  true to rwall?  t on-tilemap-collide ;
    : pr ( xy ) fdrop gap fmod fnegate gap f+ +vx  true to lwall?  t on-tilemap-collide ;

    ( check left/right )
    : cl  mbh gap f/ f>s 2 + 0 do f2dup pt wrt? if pr unloop exit then he+ loop f2drop ;
    : crt mbh gap f/ f>s 2 + 0 do f2dup pt wlt? if pl unloop exit then he+ loop f2drop ;

    : ud vy 0e f<> if vy 0e f< if px ny cu exit then px ny mbh f+ cd then ;
    : lr vx 0e f<> if vx 0e f< if nx ny cl exit then nx mbw f+ ny crt then ;

    : init   px vx f+ to nx  py vy f+ to ny 
        0 to lwall? 0 to rwall? 0 to floor? 0 to ceiling? ;

    : do-tilemap-physics ( tilemap - ) to map  init ud lr ;

    export do-tilemap-physics
end-module
