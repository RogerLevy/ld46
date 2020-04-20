: sound-cycler:  ( - <name> <sounds,> )  ( - )
    create 0 , here 0 , 
    does> >r r@ @ r@ 4 + @ mod 2 + cells r@ + @ play 1 r> +! ;
    
: ;sc  here over cell+ - cell/ swap ! ;

sound-cycler: *alley* 1 , ;sc
sound-cycler: *bbq* 2 , 3 , ;sc
sound-cycler: *depot* 4 , 5 , ;sc
sound-cycler: *distraction* 6 , 7 , 8 , 9 , ;sc
sound-cycler: *end* 10 , 11 , 12 , 13 , 14 , 15 , 16 , 17 , ;sc
sound-cycler: *grab* 18 , 19 , 20 , 21 , 22 , ;sc
sound-cycler: *pizza* 23 , 24 , 25 , ;sc
sound-cycler: *ramble* 26 , 27 , 28 , ;sc
sound-cycler: *sit* 29 , 30 , 31 , ;sc
sound-cycler: *start* 32 , 33 , 34 , ;sc