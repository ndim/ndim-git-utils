########################################################################

AC_PREREQ(2.61)
AC_INIT([ndims git utilities],
	[m4_esyscmd([./build-helpers/package-version . version-stamp])],
	[hun@n-dimensional.de],
	[ndim-git-utils],
	[https://github.com/ndim/ndim-git-utils/])
AC_CONFIG_AUX_DIR([auto-aux])
AC_CONFIG_HEADER([include/config.h])
AC_CONFIG_SRCDIR([git-amb/git-amb.in])
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE([-Wall -Werror foreign 1.11.1 no-dist-gzip dist-xz
                  subdir-objects
                  readme-alpha std-options tar-pax])

########################################################################

AC_PROG_SED
AC_PROG_CC

m4_pattern_forbid([NDIM_REQUIRE_POSIX_SH])dnl
NDIM_REQUIRE_POSIX_SH()dnl
m4_pattern_forbid([NDIM_DETECT_MAN2TXT])dnl
NDIM_DETECT_MAN2TXT()dnl

########################################################################

AC_ARG_VAR([GIT], [git revision control system])
AC_PATH_PROG([GIT], [git], [no])
AM_CONDITIONAL([HAVE_GIT], [test "x$GIT" != "xno"])
m4_pattern_forbid([NDIM_GITEXECDIR])dnl
NDIM_GITEXECDIR()dnl

########################################################################

AC_ARG_VAR([RPMBUILD], [rpm package manager build utility])
AC_PATH_PROG([RPMBUILD], [rpmbuild], [no])

AC_ARG_VAR([FEDPKG], [fedora package build utility])
AC_PATH_PROG([FEDPKG], [fedpkg], [no])

AM_CONDITIONAL([HAVE_RPMBUILD], [test "x$RPMBUILD" != "xno"])
AM_CONDITIONAL([HAVE_FEDPKG], [test "x$FEDPKG" != "xno"])

AC_MSG_CHECKING([rpmbuild %{fedora} version])
NDIM_FEDORA_VERSION="n/a"
if test "x$RPMBUILD" != "xno"; then
   NDIM_FEDORA_VERSION="$(${RPMBUILD} --eval '%{fedora}')"
fi
AC_MSG_RESULT([$NDIM_FEDORA_VERSION])
AC_SUBST([NDIM_FEDORA_VERSION])

AC_MSG_CHECKING([rpmbuild %{_arch}])
NDIM_RPM_ARCH="n/a"
if test "x$RPMBUILD" != "xno"; then
   NDIM_RPM_ARCH="$(${RPMBUILD} --eval '%{_arch}')"
fi
AC_MSG_RESULT([$NDIM_RPM_ARCH])

AC_MSG_CHECKING([spec file for main package 'BuildArch: noarch'])
dnl Note: m4 eats [], so we need to put more here than sed actually needs
if test "xnoarch" = "x$(${SED} -n '/^%package/q; s/^BuildArch:[[[:space:]]]*\(noarch\)[[[:space:]]]*/\1/p' "${srcdir}/package.spec.in")"; then
   NDIM_MAINPKG_NOARCH=yes
else
   NDIM_MAINPKG_NOARCH=no
fi
AC_MSG_RESULT([$NDIM_MAINPKG_NOARCH])

AC_SUBST([NDIM_i386_MOCK_ROOT], [fedora-${NDIM_FEDORA_VERSION}-i386])
AM_CONDITIONAL([RUN_EXTRA_i386_BUILD],
               [test "x$NDIM_MAINPKG_NOARCH" = "xno" &&
	        test "x$NDIM_RPM_ARCH" = "xx86_64" &&
	        test -f "/etc/mock/${NDIM_i386_MOCK_ROOT}.cfg"])

########################################################################

AC_CONFIG_FILES([GNUmakefile])
AC_CONFIG_FILES([Makefile])
AC_CONFIG_FILES([git-amb/git-amb.man])
AC_CONFIG_FILES([git-amb/git-amb])
AC_CONFIG_FILES([git-buildmsg/git-buildmsg])
AC_CONFIG_FILES([git-rebase-subtree/git-rebase-subtree])
AC_CONFIG_FILES([git-rebase-subtree/git-rebase-subtree.man])
AC_CONFIG_FILES([git-ndim-sh/git-ndim-sh])
AC_OUTPUT

########################################################################
