empty only forth definitions
include lib/gl1pre
require lib/fv2d.f
require keys.f
require lib/filelib.f
require utils.f
require input.f
require scene.f
include scenes
require script.f
include scripts
include config

include lib/gl1post
export [if] \ turnkey (save) breaks reloading
    turnkey gamejam2020
[then]  
init
