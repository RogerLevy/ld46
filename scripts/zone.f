prefab: zone
;prefab
ext:
    pgetset radius radius!
    64 p radius!
;ext

zone :: think
    drunk1 radius near? if me drunk1 [[ trigger ]] me dismiss then
;