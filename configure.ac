AC_PREREQ(2.61)
AC_INIT([ndims git utilities],
	[1.8],
	[hun@n-dimensional.de],
	[ndim-git-utils])
AC_CONFIG_SRCDIR([git-amb/git-amb.in])
AC_CONFIG_AUX_DIR([auto-aux])
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE([-Wall foreign 1.10 dist-bzip2 readme-alpha std-options])

m4_pattern_forbid([NDIM_DETECT_MAN2TXT])dnl
NDIM_DETECT_MAN2TXT()dnl

AC_CONFIG_FILES([Makefile])
AC_CONFIG_FILES([git-amb/git-amb.man])
AC_CONFIG_FILES([git-amb/git-amb])
AC_OUTPUT
