CLEANFILES =
BUILT_SOURCES =
EXTRA_DIST =

gitexec_SCRIPTS =
man1_MANS =
UPLOAD_FILES =
doc_DATA =
dist_doc_DATA =
bin_PROGRAMS =
check_PROGRAMS =
noinst_PROGRAMS =
bin_SCRIPTS =
check_SCRIPTS =
TESTS =
AM_INSTALLCHECK_STD_OPTIONS_EXEMPT =

# For the test cases
export top_srcdir

AM_CPPFLAGS = -I${top_builddir}/include

ACLOCAL_AMFLAGS = -I m4 --install

include build-helpers/package-version.mk

include Makefile-files
include doc/Makefile-files
include git-ndim-sh/Makefile-files
include git-amb/Makefile-files
include git-buildmsg/Makefile-files
include git-rebase-subtree/Makefile-files
include git-check-commit-msg/Makefile-files

if HAVE_NDIM_MAN2TXT
.man.txt:
	$(NDIM_MAN2TXT) "$<" > "$@.new"
	test -s "$@.new"
	mv -f "$@.new" "$@"
endif


all-local: INSTALL

CLEANFILES += INSTALL
EXTRA_DIST += INSTALL.in
INSTALL: $(top_srcdir)/INSTALL.in Makefile
	$(SED) \
		-e 's,[@]mandir@,$(mandir),g' \
		-e 's,[@]gitexecdir@,$(gitexecdir),g' \
		-e 's,[@]prefix@,$(prefix),g' \
		$(top_srcdir)/INSTALL.in > INSTALL


CLEANFILES += $(PACKAGE_TARNAME).spec
EXTRA_DIST += $(PACKAGE_TARNAME).spec
EXTRA_DIST += package.spec.in
$(PACKAGE_TARNAME).spec: $(top_srcdir)/package.spec.in Makefile
	$(SED) \
		-e 's,[@]distdir@,$(distdir),g' \
		-e 's,[@]PACKAGE_NAME@,$(PACKAGE_NAME),g' \
		-e 's,[@]PACKAGE_TARNAME@,$(PACKAGE_TARNAME),g' \
		-e 's,[@]PACKAGE_URL@,$(PACKAGE_URL),g' \
		-e "s,[@]RPM_VERSION@,$$(echo "$(PACKAGE_VERSION)" | $(SED) s/-.*//),g" \
		-e "s,[@]RPM_RELEASE@,$$(echo "$(PACKAGE_VERSION)" | $(SED) s/.*-/git/),g" \
		$(top_srcdir)/package.spec.in > $(PACKAGE_TARNAME).spec

if HAVE_RPMBUILD

RPMBUILD_OPTS =
RPMBUILD_OPTS += --define "_sourcedir $${PWD}"
RPMBUILD_OPTS += --define "_builddir $${PWD}/rpm-build"
RPMBUILD_OPTS += --define "_srcrpmdir $${PWD}/rpm-dist"
RPMBUILD_OPTS += --define "_rpmdir $${PWD}/rpm-dist"

.PHONY: rpm
rpm: dist-xz
	rm -rf rpm-dist rpm-build
	mkdir  rpm-dist rpm-build
	$(RPMBUILD) $(RPMBUILD_OPTS) -ta $(distdir).tar.xz

endif

if HAVE_FEDPKG

FEDPKG_OPTS =
FEDPKG_OPTS += --module-name=$(PACKAGE_TARNAME)
FEDPKG_OPTS += --dist=f$(NDIM_FEDORA_VERSION)

.PHONY: mockbuild
mockbuild: dist-xz
	$(FEDPKG) $(FEDPKG_OPTS) mockbuild
if RUN_EXTRA_i386_BUILD
	$(FEDPKG) $(FEDPKG_OPTS) mockbuild --root $(NDIM_i386_MOCK_ROOT)
endif

endif

dist-hook: dist-hook-rm-INSTALL-file
dist-hook-rm-INSTALL-file:
	rm -f "$(distdir)/INSTALL"

UPLOAD_DIR = upload-dir
ALL_UPLOAD_FILES = $(UPLOAD_FILES) $(distdir).tar.bz2
upload: $(UPLOAD_FILES) dist tag
	rm -rf "$(UPLOAD_DIR)"
	mkdir -p "$(UPLOAD_DIR)"
	for f in $(ALL_UPLOAD_FILES); do \
		ln "$$(test -e "$$f" || echo "$(top_srcdir)/")$$f" "$(UPLOAD_DIR)/"; \
	done
	rsync -avz --delete "$(UPLOAD_DIR)/" $(RSYNC_HOST):$(RSYNC_DIR)/$(PACKAGE_TARNAME)/
	rm -rf "$(UPLOAD_DIR)"
	if test -d "$(top_srcdir)/.git"; then cd "$(top_srcdir)" && git push public master; fi

clean-local:
	rm -rf "$(UPLOAD_DIR)"

# End of Makefile.am.
