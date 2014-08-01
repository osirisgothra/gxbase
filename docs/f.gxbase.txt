List of known gxbase flags and optional description

GXBASE_DEBUG_ON       																	Display lots of debug messages (on stderr), and log to file too
GXBASE_DEBUG_LOG																				Log debug messages to file only (appends to ~/.gxdebug.log)
GXBASE_DEBUG_OFF																				Send debug messages to /dev/null
DISABLE_PREREQUISITE__SOFT_ALERTS												Make all prerequsite check alerts 'loud' on /dev/stdout
DISABLE_PREREQUISITE__LOUD_ALERTS												Make all prerequsite check alerts 'soft' (no normal output at all)*
DISABLE_PREREQUISITE__SKIP_PREREQUISITE_CHECK       		Skip all pre-requisite checks completely**
DISABLE_PREREQUISITE__USER_NOT_ROOT											Allow running as root which is not recommended (UID=0)
DISABLE_PREREQUISITE__PRIMARY_GROUP_NOT_ROOT            Allow user with primary group that is 'root' (GID=0)
DISABLE_PREREQUISITE__BINARIES_DATAFILE_EXISTS          Do not check for /preq.d/binaries.dat binary pre-checkpoint

* does not disable debug messages
** This flag is created after the 4th consecutive error-free startup and shutdown of gxbase
