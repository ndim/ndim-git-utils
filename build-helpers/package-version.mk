BUILD_SCRIPT_DIR = build-helpers

# Check that package version matches git version before creating dist tarballs
dist-hook: git-version-check git-version-stamp
distcheck-hook: git-version-check

# Note: We cannot run autogen.sh from here, because we would need some way to
#       restart the whole dist process from the start and there is none.
# FIXME: NEWS check uses ${foo%%-*} POSIX shell, tested
#        with bash, dash, busybox.
EXTRA_DIST += $(top_srcdir)/$(BUILD_SCRIPT_DIR)/package-version
git-version-check:
	@git_ver=`$(top_srcdir)/$(BUILD_SCRIPT_DIR)/package-version $(top_srcdir) version-stamp`; \
	if test "x$${git_ver}" = "x$(PACKAGE_VERSION)"; then :; else \
		echo "ERROR: PACKAGE_VERSION and 'git describe' version do not match:"; \
		echo "         current 'git describe' version: $${git_ver}"; \
		echo "         current PACKAGE_VERSION:        $(PACKAGE_VERSION)"; \
		rm -rf "$(top_srcdir)/autom4te.cache"; \
		if test -f "$(top_srcdir)/autogen.sh"; then \
			echo "Update PACKAGE_VERSION by running $(top_srcdir)/autogen.sh."; \
		else \
			echo "Update PACKAGE_VERSION by running autoreconf(1)."; \
		fi; \
		exit 1; \
	fi; \
	case `sed 15q $(top_srcdir)/NEWS` in \
	*"$${git_ver%%-*}"*) : ;; \
	*) \
	  echo "NEWS not updated for version $${git_ver%%-*}; not releasing" 1>&2; \
	  exit 1;; \
	esac

# Version stamp files can only exist in tarball source trees.
#
# So there is no need to generate them anywhere else or to clean them
# up anywhere.
git-version-stamp:
	echo "$(PACKAGE_VERSION)" > "$(distdir)/version-stamp"

# Update *.h file to contain up-to-date version number
A_V = package-version-internal
CLEANFILES    += $(A_V).h
BUILT_SOURCES += $(A_V).h.stamp
$(A_V).h.stamp:
	@current_ver=`$(SHELL) $(top_srcdir)/$(BUILD_SCRIPT_DIR)/package-version $(top_srcdir) version-stamp`; \
	{ echo '#ifndef PACKAGE_VERSION_INTERNAL_H'; \
	  echo "#define PACKAGE_VERSION_INTERNAL \"$${current_ver}\""; \
	  echo "#endif /* !PACKAGE_VERSION_INTERNAL */"; } > "$(A_V).h.new"
	@if test -f "$(A_V).h" \
	&& cmp "$(A_V).h.new" "$(A_V).h"; then :; \
	else cat "$(A_V).h.new" > "$(A_V).h"; fi; \
	rm -f "$(A_V).h.new"
