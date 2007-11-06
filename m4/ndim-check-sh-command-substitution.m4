# version 1.11
dnl NDIM_CHECK_SH_COMMAND_SUBSTITUTION([ACTION-IF-SUPPORTED],
dnl                                    [ACTION-IF-NOT-SUPPORTED)dnl
dnl
m4_pattern_forbid([NDIM_CHECK_SH_COMMAND_SUBSTITUTION])dnl
AC_DEFUN([NDIM_CHECK_SH_COMMAND_SUBSTITUTION],[dnl
ndim_sh_command_substitution=no
test "x$(pwd)" = "x`pwd`" && test "y$(echo "foobar")" = "y`echo foobar`" \
     && ndim_sh_command_substitution=yes
m4_ifval([$1], [
if test "x$ndim_sh_command_substitution" = "xyes"; then
$1
fi
])dnl
m4_ifval([$2], [
if test "x$ndim_sh_command_substitution" = "xno"; then
$2
fi
])
])dnl
dnl
dnl Local Variables:
dnl mode: autoconf
dnl End:
