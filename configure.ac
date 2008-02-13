########################################################################

AC_PREREQ(2.61)
AC_INIT([ndims git utilities],
	[1.17.1],
	[hun@n-dimensional.de],
	[ndim-git-utils])
AC_CONFIG_AUX_DIR([auto-aux])
AC_CONFIG_HEADER([include/config.h])
AC_CONFIG_SRCDIR([git-amb/git-amb.in])
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE([-Wall -Werror foreign 1.10 dist-bzip2
                  check-news readme-alpha std-options])

########################################################################

AC_PROG_SED
AC_PROG_CC

########################################################################

AM_PATH_PYTHON([2.4], [:], [:])
AM_CONDITIONAL([HAVE_PYTHON], [ test "x$PYTHON" != "x:" ])

########################################################################

m4_pattern_forbid([NDIM_DETECT_MAN2TXT])dnl
NDIM_DETECT_MAN2TXT()dnl

########################################################################

AC_CONFIG_FILES([Makefile])
AC_CONFIG_FILES([git-amb/git-amb.man])
AC_CONFIG_FILES([git-amb/git-amb])
AC_CONFIG_FILES([git-buildmsg/git-buildmsg])
AC_CONFIG_FILES([git-rebase-subtree/git-rebase-subtree])
AC_CONFIG_FILES([git-rebase-subtree/git-rebase-subtree.man])
AC_CONFIG_FILES([git-ndim-sh/git-ndim-sh])
AC_CONFIG_FILES([nbb/nbb_lib.py:nbb/nbb_lib.in])
AC_OUTPUT

########################################################################
