########################################################################

AC_PREREQ([2.71])
m4_define([ngu_version],
          m4_esyscmd([./build-helpers/package-version . version-stamp]))
AC_INIT([ndims git utilities],
	[m4_defn([ngu_version])],
	[https://github.com/ndim/ndim-git-utils/issues],
	[ndim-git-utils],
	[https://github.com/ndim/ndim-git-utils/])
AC_CONFIG_AUX_DIR([auto-aux])
AC_CONFIG_HEADERS([include/config.h])
AC_CONFIG_SRCDIR([git-amb/git-amb.in])
AC_CONFIG_MACRO_DIRS([auto-m4 m4])
AM_INIT_AUTOMAKE([
  -Wall
  -Werror
  foreign
  1.16.4
  no-dist-gzip
  dist-xz
  subdir-objects
  readme-alpha
  std-options
  tar-pax
])

########################################################################

AC_PROG_GREP
AC_PROG_SED

AC_PROG_CC

m4_pattern_forbid([NDIM_REQUIRE_POSIX_SH])dnl
NDIM_REQUIRE_POSIX_SH()dnl
m4_pattern_forbid([NDIM_DETECT_MAN2TXT])dnl
NDIM_DETECT_MAN2TXT()dnl

########################################################################

AC_ARG_VAR([GIT], [git revision control system])
AS_VAR_IF([GIT], [], [dnl
AC_PATH_PROG([GIT], [git], [no])
])
AM_CONDITIONAL([HAVE_GIT], [test "x$GIT" != xno])
m4_pattern_forbid([NDIM_GITEXECDIR])dnl
NDIM_GITEXECDIR()dnl

########################################################################

m4_pattern_forbid([NDIM_BUILD_RPMS])dnl
NDIM_BUILD_RPMS()dnl

########################################################################

AC_CONFIG_FILES([
  GNUmakefile
  Makefile
])
AC_OUTPUT

########################################################################
