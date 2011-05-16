# version 1.15
dnl NDIM_REQUIRE_POSIX_SH()dnl
dnl dnl
m4_pattern_forbid([NDIM_REQUIRE_POSIX_SH])dnl
AC_DEFUN([NDIM_REQUIRE_POSIX_SH],[dnl
NDIM_CHECK_SH_COMMAND_SUBSTITUTION([], [dnl
AC_MSG_ERROR([Sorry, POSIX sh with \$() required.])[]dnl
])
NDIM_CHECK_SH_PARAM_EXPANSION([], [dnl
AC_MSG_ERROR([Sorry, POSIX sh with \${foo%%bar} & Co. required.])[]dnl
])
])dnl
dnl
dnl Local Variables:
dnl mode: autoconf
dnl End:
