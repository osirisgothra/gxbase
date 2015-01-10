
function __bashrc_ext_hook()
{
	trap DEBUG
	trap RETURN
	trap ERR
	return

	builtin echo "$FUNCNAME : args=$@"	

#	trap '__bashrc_ext_hook DEBUG "${BASH_COMMAND}" "$BASH_ARGC" "$#" "${BASH_ARGV[@]}" "$@"' DEBUG
#	trap '__bashrc_ext_hook RETURN "${BASH_COMMAND}" "$BASH_ARGC" "$#" "${BASH_ARGV[@]}" "$@"' RETURN
#	trap '__bashrc_ext_hook ERR "${BASH_COMMAND}" "$BASH_ARGC" "$#" "${BASH_ARGV[@]}" "$@"' ER
}

# allow the hook proc to handle our hooks as well (avoids needing -ET)
#declare -ft __bashrc_ext_hook 

trap '__bashrc_ext_hook DEBUG "${BASH_COMMAND}" "$BASH_ARGC" "$#" "${BASH_ARGV[@]}" "$@"' DEBUG
trap '__bashrc_ext_hook RETURN "${BASH_COMMAND}" "$BASH_ARGC" "$#" "${BASH_ARGV[@]}" "$@"' RETURN
trap '__bashrc_ext_hook ERR "${BASH_COMMAND}" "$BASH_ARGC" "$#" "${BASH_ARGV[@]}" "$@"' ERR
trap '__bashrc_ext_hook SIGINT "${BASH_COMMAND}" "$BASH_ARGC" "$#" "${BASH_ARGV[@]}" "$@"' SIGINT
trap '__bashrc_ext_hook SIGHUP "${BASH_COMMAND}" "$BASH_ARGC" "$#" "${BASH_ARGV[@]}" "$@"' SIGHUP
trap '__bashrc_ext_hook SIGKILL "${BASH_COMMAND}" "$BASH_ARGC" "$#" "${BASH_ARGV[@]}" "$@"' SIGKILL


