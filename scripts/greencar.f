prefab: greencar
    $0001 attr!  \ 32x16 sprite
    6 bmp#!
    ~sprex
    getset state# state#!        
;prefab

greencar :: start
    me to car1
    0 bmp# frame ixy!
;
