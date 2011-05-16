# serial 1.15
dnl NDIM_CHECK_SH_COMMAND_SUBSTITUTION([ACTION-IF-SUPPORTED],
dnl                                    [ACTION-IF-NOT-SUPPORTED])dnl
m4_pattern_forbid([NDIM_CHECK_SH_COMMAND_SUBSTITUTION])dnl
AC_DEFUN([NDIM_CHECK_SH_COMMAND_SUBSTITUTION],[dnl
AS_IF([test "x$ndim_sh_command_substitution" = "x"], [dnl
AC_MSG_CHECKING([\$(cmd) type sh command substition])
ndim_sh_command_substitution=no
test "x$(pwd)" = "x`pwd`" && test "y$(echo "foobar")" = "y`echo foobar`" \
     && ndim_sh_command_substitution=yes
AC_MSG_RESULT([$ndim_sh_command_substitution])])
m4_ifval([$1], [AS_IF([test "x$ndim_sh_command_substitution" = "xyes"], [$1])])
m4_ifval([$2], [AS_IF([test "x$ndim_sh_command_substitution" = "xno" ], [$2])])
])dnl
dnl
dnl Local Variables:
dnl mode: autoconf
dnl End:
