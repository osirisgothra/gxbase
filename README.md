<h1>gxbase</h1>
<h2>GXBASE Related Projects</h2>
<h3>GXBASE is now depreciated</h3>

This project is now depreciated and has moved on to [autox](http://osirisgothra.github.io/autox). I have however
standardized this repository and made installation easier. Please read the end
of the document for how standardization changed. The original README has changed
to suit forkers, the only people who would want to get this project's code
and is also included below this paragraph:

| |
|-----------------------------------------------------------------|
| BEGIN gxbase/README (the inline version of gxbase/README) |
|-----------------------------------------------------------------|
| |	

NOTICE - DEPRECIATED
--------------------

This project is now depreciated and will not be getting
anymore updates except for coercing/directing those interested
to it's child project, the end-result of the development done 
here and elsewhere (much like the original gxbase, which was
codenamed excore, gxcore, gx, xc, etc. depending on where it
was at that time (most of which was on gitorious, not here at
github).

I have kept a few "historical" stages available here. They are
very different stages that originall had codenames but since I
cant remember exactly, I decided to just sick with the numbering
system:

| Branch | Branch Description
|--------|--------------------------------------------------------|
|0.0.0.0 | first incantation (core?)                              |
|0.1.0.0 | second incantation (gxcore or xc?)                     |
|0.2.0.0 | third (gx or excore?)                                  |
|0.2.0.1 | fourth (gxbase I)                                      |
|-----------------------------------------------------------------|
|master  | fifth (gxbase final)                                   |
|dev     | fifth (gxbase final, dev*)                             |
|--------|--------------------------------------------------------|
*though 'dev' implies future development, it is likely not to happen. I set this up like this so that if for some
crazy reason I change my mind or someone decides to fork, it will be available to fill that need. The branches that
are related (or not related) are:


Unrelated | Comment(s)
----------|-----------------------------------------------------------------------------------------
0.0.0.0   | no relations
0.1.0.0   | no relations
0.2.0.0   | no relations, but contents *may* have been duplicated from above


Related      | How?
-------------|--------------------------------------------------------------------------------------------------------------
0.2.0.1      |original rewrite of gxbase
old/misc mods|changes done in 2013-14
master       |merged from *old/misc mods* above and LOCKED
dev          |merged from master and LOCKED


*Possible* Installation - USE AT OWN RISK!
----------------------------------------------------------------------------------------------------------------------------

The below install instructions were for the release that did not happen. If you wish to *try* to use gxbase, follow
these instructions:

1) start a bash shell and login as the user you wish to use gxbase with, if you want system-wide then
   login with the root account or use sudo before the commands.

2) Type (or cut and paste) the following -- typing is recommended because less errors are likely!


For Current User Only
---------------------
``bash
mkdir ~/.local/share -p
cd ~/.local/share
git clone git://github.com/osirisgothra/gxbase
cd ~/.local/share/gxbase
echo export PATH=$_/tools:$_/bin:$_/lib:$_:$PATH >> ~/.bashrc
``

Entire System-Wide
------------------
``bash
mkdir /usr/local/share -p
cd /usr/local/share
git clone git://github.com/osirisgothra/gxbase
cd /usr/local/share/gxbase
echo export PATH=$_/tools:$_/bin:$_/lib:$_:$PATH >> /etc/bash.bashrc
``

3) after logging off and logging back on, the gxbase interpreter ('gxbase') and it's tools
will be available. However, it is depreciated so it never got into development, so unless
you are forking this project, doing so is pointless for the most part unless you are
just curious.

4) **Stop here until you wish to rid yourself of GXBASE**

5) Uninstallation is the reverse of the installation
   assuming you didnt modify your .bashrc or bash.bashrc since
   the installation:

User
----
``bash
TMP=$(mktemp)
rm -fr ~/.local/share/gxbase
cat ~/.bashrc | grep gxbase -v > $TMP
mv $TMP ~/.bashrc -f
unset TMP
source ~/.bashrc #to get rid of gxbase in path
hash -r #to get rid of refs to gxbase executables
``

System-Wide
-----------
``bash
TMP=$(mktemp)
rm -fr /usr/local/share/gxbase
cat /etc/bash.bashrc | grep gxbase -v > $TMP
mv $TMP /etc/bash.bashrc -f
unset TMP
source /etc/bash.bashrc #to get rid of gxbase in path
hash -r #to get rid of refs to gxbase executables
``

:sparkle:&nbsp;It is probably better just to relogin than to rely on sourcing but
it nearly fool proof, except on heavily customized systems.

:sparkle:&nbsp;If you use other startup files (like .bash-login, etc) then you will
have to take different steps which should be obvious given the above instructions

:sparkle:&nbsp;NetworkFs based systems that want gxbase over all machines should use
the /usr/share location instead of /usr/local/share per the filesystem standardization
rules set forth for linux.

:sparkle:&nbsp;Windows users: unless you are using cygwin, i don't think this is
for you. It may not even work there. That does not mean you cant fork it to make
it work for windows.

:sparkle:&nbsp;Mac users: assuming you know the little details, should be able to
use this without too much trouble.

:sparkle:&nbsp;The next release (first release) is not going to be done by me. But keep
watch because someone may decide to take over the project. But don't hold your breath!

:sparkle:&nbsp; The original README now follows, it is pointless, but here it is...


Original Documentation
----------------------------------------------------------------------
The original README section is omitted to prevent confusion and worthless
duplication. Open (or click) the [README](http://github.com/osirisgothra/gxbase/blob/master/README) document for that!

|-----------------------------------------------------------------|
| **END** of gxbase/README (the inline version of gxbase/README) |
|-----------------------------------------------------------------|


Standardization
---------------

In a nutshell, has been applied project wide. The X.X.X.X branches represent old parts of the project
no longer in production. From here on out, all main work will be done in 'dev' and all stable changes will be 
merged to 'master'. This is less confusion for everyone. Also, as per standardization, all version numbers will be in
the form of tags and releases on github. The versioning system has been simplified and now is just year.month of that
release, if at all.

This project is dated.

Most of this project is being stripped of it's parts and being incorporated into autox, which represents the 'meat'
of the project's 3-year research/development run. I never intended this to be a serious project and was certain
it would never be released. However, since it was a lot of sidework, i choose to keep it here (plus I can't really
remove this repository anyway).

For a usable implementation of what you see here, please visit instead the autox website:

http://osirisgothra.github.io/autox


