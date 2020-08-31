( Simple tilemap collision )

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
        map locate-tile @ ;

    : cel? BIT_CEL and ; \ ' ceiling '
    : flr? BIT_FLR and ; \ ' floor '
    : wlt? BIT_WLT and ; \ ' wall left '
    : wrt? BIT_WRT and ; \ ' wall right '
    
    0 value nx
    0 value ny
    0 value t
    
    : gap  16 p ; 
    : px  x mbx + ;
    : py  y mby + ;
    \ : mbw iw s>f ;
    \ : mbh ih s>f ;    

    : xy>cr  ( x y - c r )
        gap p/ p>s swap gap p/ p>s swap ;
        
    : pt  ( x y - n )  \ point
        xy>cr  map@ dup to t   tileprops@ ;          

    ( increment coordinates )
    : ve+  swap gap +  px mbw + 1 p -  min  swap ;
    : he+  gap +  mbh ny + 1 p -  min ;

    : +vy  +to ny ny py - vy! ;
    : +vx  +to nx nx px - vx! ;

    ( push up/down )
    : pu ( xy ) nip gap mod negate +vy
        true to floor?  t on-tilemap-collide  ;
    : pd ( xy ) nip gap mod negate gap + +vy
        true to ceiling?  t on-tilemap-collide ;

    ( check up/down )
    : cu mbw gap p/ p>s 2 + 0 do 2dup pt cel? if pd unloop exit then ve+ loop 2drop ;
    : cd mbw gap p/ p>s 2 + 0 do 2dup pt flr? if pu unloop exit then ve+ loop 2drop ;

    ( push left/right )
    : pl ( xy ) drop gap mod negate +vx
        true to rwall?  t on-tilemap-collide ;
    : pr ( xy ) drop gap mod negate gap + +vx
        true to lwall?  t on-tilemap-collide ;

    ( check left/right )
    : cl  mbh gap p/ p>s 2 + 0 do 2dup pt wrt? if pr unloop exit then he+ loop 2drop ;
    : crt mbh gap p/ p>s 2 + 0 do 2dup pt wlt? if pl unloop exit then he+ loop 2drop ;

    : ud vy if vy 0< if px ny cu exit then px ny mbh + cd then ;
    : lr vx if vx 0< if nx ny cl exit then nx mbw + ny crt then ;

    : init   px vx + to nx  py vy + to ny 
        0 to lwall? 0 to rwall? 0 to floor? 0 to ceiling? ;

    : do-tilemap-physics ( tilemap - ) to map  init ud lr ;

    export do-tilemap-physics
end-module
