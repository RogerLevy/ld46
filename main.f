
empty only forth definitions
include lib/gl1pre

require lib/fv2d.f
require keys.f
require lib/filelib.f
require ld46-utils.f
require input.f
require scene.f

require script.f
include scripts
include config

include lib/gl1post
export? [if] \ turnkey (save) breaks reloading
    turnkey "Alright, We're Gonna Walk Now..."
[then]  
init
