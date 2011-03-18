# serial 15
dnl NDIM_CHECK_SH_PARAM_EXPANSION([ACTION-IF-SUPPORTED],
dnl                               [ACTION-IF-NOT-SUPPORTED])dnl
dnl
m4_pattern_forbid([NDIM_CHECK_SH_PARAM_EXPANSION])dnl
AC_DEFUN([NDIM_CHECK_SH_PARAM_EXPANSION],[dnl
AS_IF([test "x$ndim_sh_param_expansion" = "x"], [dnl
AC_MSG_CHECKING([\${foo%%bar} type sh param expansion])
ndim_sh_param_expansion=no
ndim_testvalue="12.34.56-1.23.4-615asdg"
test "x${ndim_testvalue%%-*}" = "x12.34.56" \
     && test "x${ndim_testvalue%-*}" = "x12.34.56-1.23.4" \
     && test "x${ndim_testvalue##*-}" = "x615asdg" \
     && test "x${ndim_testvalue#*-}" = "x1.23.4-615asdg" \
     && ndim_sh_param_expansion=yes
AC_MSG_RESULT([$ndim_sh_param_expansion])
])
m4_ifval([$1], [AS_IF([test "x$ndim_sh_param_expansion" = "xyes"], [$1])
])dnl
m4_ifval([$2], [AS_IF([test "x$ndim_sh_param_expansion" = "xno"],  [$2])
])dnl
])dnl
dnl
dnl Local Variables:
dnl mode: autoconf
dnl End:
