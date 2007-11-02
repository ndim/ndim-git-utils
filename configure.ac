AC_PREREQ(2.61)
AC_INIT([ndims git utilities],
	[1.1.1],
	[hun@n-dimensional.de],
	[ndim-git-utils])
AC_CONFIG_SRCDIR([src/git-amb.1.in])
AC_CONFIG_AUX_DIR([auto-aux])
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE([-Wall foreign 1.10 dist-bzip2])

m4_pattern_forbid([NDIM_DETECT_MAN2TXT])dnl
NDIM_DETECT_MAN2TXT()dnl

AC_CONFIG_FILES([Makefile])
AC_CONFIG_FILES([src/git-amb.1])
AC_OUTPUT
