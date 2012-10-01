AC_PREREQ([2.60])
AC_INIT([stcdude], [0.1], [andrew@ncrmnt.org],[stcdude],[http://github.com/nekromant/stcdude])
AM_INIT_AUTOMAKE([foreign -Wall -Werror])
AC_CONFIG_HEADERS([config.h])
AC_C_INLINE

# Checks for programs.
AC_PROG_CC
AM_PROG_CC_C_O

AC_MSG_NOTICE([ *** MADE IN USSR WITH LOVE *** ])
sleep 2

# Checks for libraries.

# Checks for header files.
AC_CHECK_HEADERS([fcntl.h stdint.h stdlib.h string.h sys/ioctl.h sys/time.h termios.h unistd.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_C_INLINE
AC_TYPE_SIZE_T
AC_TYPE_UINT16_T

# Checks for library functions.
AC_FUNC_ERROR_AT_LINE
AC_FUNC_MALLOC
AC_CHECK_FUNCS([bzero gettimeofday memset strchr strdup strncasecmp strtoul])

AC_CONFIG_FILES([Makefile
                 src/Makefile])

PKG_CHECK_MODULES([LUA], [lua >= 5.1])

#AC_MSG_CHECKING([whether we are enabling goodbye])
AC_ARG_WITH([scripts-path],
  [AS_HELP_STRING([--with-scripts-path], [location of the lua scripts])],
  [SCRIPTS_PATH="-DSCRIPTS_DIR='$withval'"])

AC_SUBST([SCRIPTS_PATH])
AC_SUBST([stcdudedir],@datadir@/stcdude)
AC_OUTPUT
