require sprex.f

: load-data
    s" data.f" included
    1 load
;

:while game update
    2x cls 
    bgp1 [[ draw-as-tilemap ]] 
    bgp2 [[ draw-as-tilemap ]] 
    draw-sprites-ex
;

:while game step
    max-objects 0 do
        i object [[ en if
            think  x vx f+ x!  y vy f+ y!
        then ]]        
    loop
;