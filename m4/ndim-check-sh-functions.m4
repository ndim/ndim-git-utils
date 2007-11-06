# version 1.11
dnl NDIM_CHECK_SH_FUNCTIONS([ACTION-IF-SUPPORTED],
dnl                         [ACTION-IF-NOT-SUPPORTED)dnl
dnl
AC_DEFUN([NDIM_CHECK_SH_FUNCTIONS],[dnl
NDIM_CHECK_SH_COMMAND_SUBSTITUTION([], [dnl
AC_MSG_ERROR([Sorry, POSIX sh with \$() required.])dnl
])dnl
ndim_sh_functions=no
if test "x$(moo() { echo "meh"; }; moo)" = "xmeh"
then
    ndim_sh_functions=yes
fi
m4_ifval([$1], [
if test "x$ndim_sh_functions" = "xyes"; then
$1
fi
])dnl
m4_ifval([$2], [
if test "x$ndim_sh_functions" = "xno"; then
$2
fi
])
])dnl
dnl
dnl Local Variables:
dnl mode: autoconf
dnl End:
