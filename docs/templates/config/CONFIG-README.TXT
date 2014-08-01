TODO: please write documentation here saying why config templates is needed

Quick notes by developer:

- config templates is an example to what ~/.config/gxbase should start out having or typically have
- GXBASE_ROOT usually contains the install prefix + /gxbase, this may change to GXBASE_PREFIX in the future
  but should be thought of as the prefix for now (until the /gxbase suffix is removed)
- flag files usually are empty denoting a boolean in nature value, present means true, absense means false
- furthermore, flag files that are present can contain a value, like "T" if you need a tri-state checkbox
- longer settings should be kept in conf files or xml files, not flag files
- the gx.flag command is the interface used to manipulate flags, not direct touch/rm/tee
- GXBASE_ROOT is the most important item and must be present
- logs should now be stored here only
- permissions should be 644  (rw-r--r--) for normal data and 600 (rw-------) for protected data
- temporary areas like /var/tmp and /tmp should have permissions of at least 775 (rwxrwxr-x) 
- local temp folders should have 755 (rwx-r-xr-x) permissions

this and other data here needs to be put into organized help asap


* I. N.A.P. M.O.R.E. (I need a program manager or reigonal executor!)
