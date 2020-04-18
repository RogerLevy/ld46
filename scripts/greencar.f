prefab: greencar
    $0001 attr!  \ 32x16 sprite
    6 bmp#!
    ~sprex
;prefab

greencar :: think
    0 bmp# frame ixy!
;
