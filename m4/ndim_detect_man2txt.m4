# serial 1.1
m4_pattern_forbid([NDIM_DETECT_MAN2TXT])dnl
AC_DEFUN([NDIM_DETECT_MAN2TXT], [dnl
AC_ARG_VAR([MAN])
AC_PATH_PROG([MAN], [man], [false])
AC_ARG_VAR([COL])
AC_PATH_PROG([COL], [col], [false])
AM_CONDITIONAL([HAVE_NDIM_MAN2TXT],
               [test "x$MAN" != "xfalse" &&
                test "x$COL" != "xfalse" &&
                test "x$(echo "ABXY" | $COL -b)" = "xBY"])
AC_MSG_CHECKING([man and col -b work correctly])
if test "x$HAVE_NDIM_MAN2TXT_FALSE" = "x#"; then
	AC_MSG_RESULT([yes])
	AC_SUBST([NDIM_MAN2TXT], ['m2t(){ $(MAN) "$$(dirname "$$][1")/$$(basename "$$][1")"|$(COL) -b; }; m2t'])dnl
else
	AC_MSG_RESULT([no $(echo "ABXY" | $COL -b)])
fi
])dnl
dnl
dnl Local Variables:
dnl mode: autoconf
dnl End:
