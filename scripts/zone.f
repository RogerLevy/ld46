prefab: zone
;prefab
ext:
    fgetset radius radius!
    64e radius!
;ext

0e fvalue ftemp
: near?  to ftemp  dup if 's xy xy fdist ftemp f<= then ;

zone :: think
   drunk1 radius near? if me drunk1 [[ trigger ]] me dismiss then
;