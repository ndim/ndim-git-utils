# version 1.11
dnl NDIM_CHECK_SH_COMMAND_SUBSTITUTION([ACTION-IF-SUPPORTED],
dnl                                    [ACTION-IF-NOT-SUPPORTED)dnl
dnl
m4_pattern_forbid([NDIM_CHECK_SH_PARAM_SUBSTITUTION])dnl
AC_DEFUN([NDIM_CHECK_SH_PARAM_SUBSTITUTION],[dnl
AS_IF([test "x$ndim_sh_param_substitution" = "x"], [dnl
AC_MSG_CHECKING([\${foo%%bar} type sh param substitution])
ndim_sh_param_substitution=no
ndim_testvalue="12.34.56-1.23.4-615asdg"
test "x${ndim_testvalue%%-*}" = "x12.34.56" \
     && test "x${ndim_testvalue%-*}" = "x12.34.56-1.23.4" \
     && test "x${ndim_testvalue##*-}" = "x615asdg" \
     && test "x${ndim_testvalue#*-}" = "x1.23.4-615asdg" \
     && ndim_sh_param_substitution=yes
AC_MSG_RESULT([$ndim_sh_param_substitution])])
m4_ifval([$1], [
if test "x$ndim_sh_param_substitution" = "xyes"; then
$1
fi
])dnl
m4_ifval([$2], [
if test "x$ndim_sh_param_substitution" = "xno"; then
$2
fi
])
])dnl
dnl
dnl Local Variables:
dnl mode: autoconf
dnl End:
