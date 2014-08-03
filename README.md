gxbase
======

GXBASE Related Projects

Update

Completely reorganized project into a single repository (finally!).
It took a bit longer to learn git than I thought it would but I think
I have it now. This is how the project is to be laid out:
 
 repo: gxbase
        +------0.0.0.0 - initial commit (when project was at birth)
        +------0.1.0.0 - the "generation 1" gxbase which is very 
                         different (aka the "experimental" gxbase)
        +------0.2.0.0 - from birth to current "generation 2" 
                         (also known as the "real" gxbase)
               0.2.14.8- starting point from here on (read about versions below)


        +------gxbase-helpers.git (submodule)  the helpers will be referenced 
                                               in order to align their versions
                                               together** 
                  +------- mini.git (submodule)  any mini projects used by helpers***
                  

Versioning System

Every project needs a versioning system. Originally, gen1 was called 0-1-0 (or 0.1.0) and
gen2 was called 0-2-0 (0.2.0) and it's somewhat confusing for others. From here on, the
versioning for generation 2 will be like so:

     OFFICIAL-RELEASE-NUMBER.2.TWO-DIGIT-YEAR.MONTH (.commit)  

        OFFICIAL-RELEASE-NUMBER			Should be self explanitory. Since I havent done any official releases
                                    yet, this will stay at '0' for now.

        2                           Marker for generation 2. This is done in order to keep it separate from
                                    the generation 1 code, in case it ever gets restarted, i could possibly
                                    branch off of it with a forked repo, it would follow the same scheme, except
															      instead of this number being ``2'', it would be ``1''.
				
				TWO-DIGIT-YEAR							Another no-brainer, its the year, last two digits (2014 would be ``14'').
			
				MONTH												Again, not hard to guess, that's right, it's the month (1 = Jan 2 = Feb, etc)
  
		    (.commit)                   Whenever I reference a version, I'll tack on the latest commit code at the end
                                    which will actually be represented only by the first four digits since the
                                    likelyhood of a commit with the same 4 first digits in the same version code
                                    is HIGHLY unlikely. If for some reason there is a ambiguity, I'll add enough
                                    extra digits to resolve it.								

                                                 
