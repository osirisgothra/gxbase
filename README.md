gxbase
========================================

<h2>GXBASE Related Projects</h2>

<h3>Update</h3>

Completely reorganized project into a single repository (finally!).
It took a bit longer to learn git than I thought it would but I think
I have it now. This is how the project is to be laid out:
 
 repo: gxbase
        +------0.0.0.0 - initial commit (when project was at birth)
        +------0.1.0.0 - the "generation 1" gxbase which is very 
                         different (aka the "experimental" gxbase)
        +------0.2.0.0 - from birth to current "generation 2" 
                         (also known as the "real" gxbase)
			  +------0.2.0.1 - special final commit of 0-2-0, (read "0-2-0 FINAL" below)
               0.2.14.8- starting point from here on (read about versions below)


        +------gxbase-helpers.git (submodule)  the helpers will be referenced 
                                               in order to align their versions
                                               together** 
                  +------- mini.git (submodule)  any mini projects used by helpers***
                  

<h3>Versioning System</h3>

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

<h3>0-2-0 FINAL NOTE</h3>

	I was leery about merging ALL of the gxbase code into a single git repository, worried I might lose something
in the process. To make sure that didn't happen, I created one last [1][doubly detached branch], 0.2.0.1, which is
the exact state of 0-2-0.git before it's deletion and merge into the current repository. I don't see too much
difference with it on the surface, but if something is missing from the current tree (ATTOTW; 0.2.8.14), this is
the first place one should look. I have high hopes everything went okay, and once the first release goes out
it will be <b>deleted</b> so do not depend on it being present indefinitely because that is not the case in
which I intend to imply. 


<h3><a name="doublydetached">Doubly Detached?</a></h3>

   Not a real git term, but the first 3 or 4 branches, ending with 0.2.8.14, are detached from each other, and only
are relevant within that branch. Therefore I coined the name 'doubly detached' because they do not inherit much
from the previous branch, nor do they contribute much to the next branch, as far as commit data is concerned, even
if the data is identical or progressive in view, git does not see it that way, thus the name. So don't get too hot
when you see this because it is probably not generally good practice to do this, however, I was not familiar with
(or using) git at all when this project began. Those branches that are detached are just imported from that era.
As stated above, the 0.2.0.1 branch will be deleted since it is near-identical to the first commit of 0.2.8.14, and
as I confirm this, I plan to be rid of it by 1.2.1.15, which is the projected first release version.


<p><font style="size:x-small">(End of README.md)</font></p>

 [1][url="README.md#doublydetached"]                                                  
