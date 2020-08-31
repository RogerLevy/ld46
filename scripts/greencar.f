prefab: greencar
    $0001 attr!  \ 32x16 sprite
    6 bmp#!
    sprex/
;prefab
ext:
    getset state# state#!        
;ext

greencar :: start
    me to car1
    0 bmp# frame ixy!
;
