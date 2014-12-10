#!/bin/bash --norc 
#===============================================================================
#
#          FILE: gxbase.sh
# 
#         USAGE: ./gxbase.sh 
# 
#   DESCRIPTION: Gxbase main shell (the core of gxbase)
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Gabriel Thomas Sharp (gts), osirisgothra@hotmail.com
#  ORGANIZATION: Paradisim Enterprises, LLC - http://paradisim.twilightparadox.com
#       CREATED: 11/26/2014 07:31
#      REVISION:  ---
#===============================================================================

# % = options via 'set -o/+o option'  (-o means ENABLED, +o means disabled)
# ^ = options via 'shopt -s/-u option' 
# UPPERCASE = enabled setting
# lowercase = disabled option

GXBASE_FEATURES=( 	%ALLEXPORT
			%braceexpand
			%EMACS
			%ERREXIT
			%ERRTRACE
			%FUNCTRACE
			%hashall
			%HISTEXPAND
			%HISTORY
			%IGNOREEOF
			%interactive-comments
			%KEYWORD
			%MONITOR
			%NOCLOBBER
			%NOEXEC
			%NOGLOB
			%NOLOG
			%NOTIFY
			%NOUNSET
			%ONECMD
			%PHYSICAL
			%PIPEFAIL
			%POSIX
			%PRIVILEGED
			%VERBOSE
			%VI
			%XTRACE
			^autocd
			^cdable_vars
			^cdspell
			^checkhash
			^checkjobs
			^checkwinsize
			^CMDHIST
			^compat31
			^compat32
			^compat40
			^compat41
			^compat42
			^COMPLETE_FULLQUOTE
			^direxpand
			^dirspell
			^dotglob
			^execfail
			^expand_aliases
			^extdebug
			^extglob
			^EXTQUOTE
			^failglob
			^FORCE_FIGNORE
			^globasciiranges
			^globstar
			^gnu_errfmt
			^histappend
			^histreedit
			^histverify
			^HOSTCOMPLETE
			^huponexit
			^INTERACTIVE_COMMENTS
			^lastpipe
			^lithist
			^login_shell
			^mailwarn
			^no_empty_cmd_completion
			^nocaseglob
			^nocasematch
			^nullglob
			^PROGCOMP
			^PROMPTVARS
			^restricted_shell
			^shift_verbose
			^SOURCEPATH
			^xpg_echo
);

