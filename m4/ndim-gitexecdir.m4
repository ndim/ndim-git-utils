# serial 1
dnl NDIM_GITEXECDIR
dnl
m4_pattern_forbid([NDIM_GITEXECDIR])dnl
AC_DEFUN([NDIM_GITEXECDIR], [dnl
AC_ARG_WITH([gitexecdir],
	[AS_HELP_STRING([--with-gitexecdir],
	                [location of git execdir @<:@default=${pkglibexecdir}@:>@])],
	[],
	[with_gitexecdir=auto])
AC_MSG_CHECKING([for git execdir])
AS_IF([test "x$with_gitexecdir" = "xsystem-default"],
      [AC_MSG_ERROR([--with-gitexecdir=system-default requires git to be installed])
       gitexecdir="$(env GIT_EXEC_PATH= ${GIT} --exec-path)"],
      [test "x$with_gitexecdir" = "xauto"],
      [gitexecdir="\${pkglibexecdir}"],
      [gitexecdir="${with_gitexecdir}"])
AC_MSG_RESULT([${gitexecdir}])
AC_SUBST([gitexecdir])
])dnl
dnl
dnl Local Variables:
dnl mode: autoconf
dnl End:
