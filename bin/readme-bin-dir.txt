
	bin - miscelaneous scripts and programs

   Where?

	 	This is supposed to be located in the /usr/share/gxbase/extras/bin folder. You should add the
		following lines to your ~/.bashrc to use it:

		  PATH=/usr/share/gxbase/extras/bin:$PATH

			UPDATE: gxbase now keeps it's binary and script items in $GXBASE_ROOT/bin
			which is different depending on where you installed it (using install.sh or manually editing the config files)
			
   What is it?

	 It contains some programs you may find helpful, it does best when defined FIRST in your system's PATH
	 variable since it shares the same names as it's sister programs. In the case you do NOT want this kind
	 of functionaliy, then do NOT put it in the first slot of your system PATH, instead, tack it onto the end
	 of your system path variable as per usual path additions.

	 Why is it?

	 Many linux programs are getting better at making things easy to run and use. These scripts basically extend the 
	 bridge ALL the way across to allow some of lifes nagging repititions be done automatic. For example, for those
	 who keep this folder as recommended in your ~/bin, you'll notice that vim will autoselect gvim when running in
	 gui mode, and allows only one instance anywhere (unless configured to do otherwise, on both counts).


	 When to use it...

	 take a look, try it out..


	 Who made it?

	 see the LICENSE and README for that info...
