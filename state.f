getset state# state#!

32 cell array state[]

: do-state state# state[] @ ?dup if execute then ;

: does-state  does>
    dup @ state# = if drop exit then
    dup @ state#!  4 + @ execute  do-state ;

: state:  ( state# - <startername> <statename> )
    create dup ,  ['] noop ,  does-state
    constant 
;

: :start  :noname  ' >body 4 + ! ;
: :step   :noname  ' >body @ state[] ! ;