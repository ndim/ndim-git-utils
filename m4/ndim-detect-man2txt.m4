# serial 1.6.3
dnl
dnl NDIM_DETECT_MAN2TXT
dnl
dnl Syntax:
dnl
dnl   configure.ac:
dnl     NDIM_DETECT_MAN2TXT()dnl
dnl
dnl   Makefile.am:
dnl     if HAVE_NDIM_MAN2TXT
dnl     .txt.man:
dnl          $(NDIM_MAN2TXT) $< > $@
dnl     endif
dnl
dnl Define AM_CONDITIONAL HAVE_NDIM_MAN2TXT.
dnl If that is true, define NDIM_MAN2TXT.
dnl
m4_pattern_forbid([NDIM_DETECT_MAN2TXT])dnl
AC_DEFUN([NDIM_DETECT_MAN2TXT], [dnl
NDIM_CHECK_SH_FUNCTIONS([], [dnl
AC_MSG_ERROR([Sorry, POSIX sh with functions required.])
])dnl
AC_ARG_VAR([MAN])
AC_PATH_PROG([MAN], [man], [false])
AC_ARG_VAR([COL])
AC_PATH_PROG([COL], [col], [false])
AM_CONDITIONAL([HAVE_NDIM_MAN2TXT],
               [test "x$MAN" != "xfalse" &&
                test "x$COL" != "xfalse" &&
                test "x$(echo "ABXY" | $COL -b)" = "xBY"])
AC_MSG_CHECKING([man and col -b work correctly])
AS_IF([test "x$HAVE_NDIM_MAN2TXT_FALSE" = "x#"], [dnl
	AC_MSG_RESULT([yes])
	NDIM_MAN2TXT='m2t(){ $(MAN) "$$(dirname "[$$]1")/$$(basename "[$$]1")"|$(COL) -b; }; m2t'
      ],[dnl
	AC_MSG_RESULT([no $(echo "ABXY" | $COL -b)])
	NDIM_MAN2TXT='false'
])
AC_SUBST([NDIM_MAN2TXT])
])dnl
dnl
dnl Local Variables:
dnl mode: autoconf
dnl End:
