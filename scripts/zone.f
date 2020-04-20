prefab: zone
    fgetset radius radius!
    64e radius!
;prefab

0e fvalue ftemp
: near?  to ftemp  dup if 's xy xy fdist ftemp f<= then ;

zone :: think
   drunk1 radius near? if me drunk1 [[ trigger ]] me dismiss then
;