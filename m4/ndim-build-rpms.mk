# See ndim-build-rpms.README.md for usage instructions.

CLEAN_LOCAL_TARGETS += clean-local-ndim-build-rpms
clean-local-ndim-build-rpms:
	rm -rf rpm-build rpm-dist 'results_$(PACKAGE_TARNAME)'

CLEANFILES += $(PACKAGE_TARNAME).spec
EXTRA_DIST += $(PACKAGE_TARNAME).spec
EXTRA_DIST += package.spec.in
$(PACKAGE_TARNAME).spec: $(top_srcdir)/package.spec.in Makefile
	set -e; \
	$(SED) \
		-e 's,[@]distdir@,$(distdir),g' \
		-e 's,[@]PACKAGE_NAME@,$(PACKAGE_NAME),g' \
		-e 's,[@]PACKAGE_TARNAME@,$(PACKAGE_TARNAME),g' \
		-e 's,[@]PACKAGE_URL@,$(PACKAGE_URL),g' \
		-e "s,[@]RPM_VERSION@,$$(echo "$(PACKAGE_VERSION)" | $(SED) s/-.*//),g" \
		-e "s,[@]RPM_RELEASE@,$$(echo "$(PACKAGE_VERSION)" | $(SED) s/.*-/git/),g" \
		$(top_srcdir)/package.spec.in > $(PACKAGE_TARNAME).spec.tmp.$$$$; \
	if $(GREP) -n '@[A-Za-z0-9_]\{1,\}@' "$(PACKAGE_TARNAME).spec.tmp.$$$$"; then \
	  echo "Error: Unsubstituted strings in input file: $(top_srcdir)/package.spec.in"; \
	  rm -f "$(PACKAGE_TARNAME).spec.tmp.$$$$"; \
	  exit 1; \
	else \
	  mv -f "$(PACKAGE_TARNAME).spec.tmp.$$$$" "$(PACKAGE_TARNAME).spec"; \
	fi

if DO_RPMBUILD

RPMBUILD_OPTS =
RPMBUILD_OPTS += --define "_sourcedir $${PWD}"
RPMBUILD_OPTS += --define "_builddir $${PWD}/rpm-build"
RPMBUILD_OPTS += --define "_srcrpmdir $${PWD}/rpm-dist"
RPMBUILD_OPTS += --define "_rpmdir $${PWD}/rpm-dist"

rpm: dist-xz
	rm -rf rpm-dist rpm-build
	mkdir  rpm-dist rpm-build
	$(RPMBUILD) $(RPMBUILD_OPTS) -ta $(distdir).tar.xz

endif

if DO_FEDPKG

FEDPKG_OPTS =
FEDPKG_OPTS += --dist=f$(NDIM_FEDORA_VERSION)

sources: dist-xz
	$(SHA512SUM) --tag $(PACKAGE_TARNAME)-$(PACKAGE_VERSION).tar.xz > sources.new
	mv -f sources.new sources

mockbuild: dist-xz sources
	$(FEDPKG) $(FEDPKG_OPTS) mockbuild
if DO_EXTRA_i386_BUILD
	$(FEDPKG) $(FEDPKG_OPTS) mockbuild --root $(NDIM_i386_MOCK_ROOT)
endif

mockbuild-all: dist-xz sources
	@echo SHELL="$$SHELL"; fail=""; succ=""; \
	if test "x$(NDIM_RPM_ARCH)" = "xx86_64" && test "x$(NDIM_MAINPKG_NOARCH)" = "xno"; then \
	for mockroot in /etc/mock/fedora-*-x86_64.cfg /etc/mock/epel-*-x86_64.cfg /etc/mock/fedora-*-i386.cfg /etc/mock/epel-*-i386.cfg; do \
		if test -f "$$mockroot"; then :; else echo "No such mock config: $$mockroot"; exit 1; fi; \
		echo "$(FEDPKG) $(FEDPKG_OPTS) mockbuild --root $$mockroot"; \
		if $(FEDPKG) $(FEDPKG_OPTS) mockbuild --root "$$mockroot"; then \
			succ="$${succ} $$(basename "$${mockroot}")"; \
		else \
			fail="$${fail} $$(basename "$${mockroot}")"; \
		fi; \
	done; \
	else \
	for mockroot in /etc/mock/{fedora,epel}-*-$(NDIM_RPM_ARCH).cfg; do \
		if test -f "$$mockroot"; then :; else echo "No such mock config: $$mockroot"; exit 1; fi; \
		echo "$(FEDPKG) $(FEDPKG_OPTS) mockbuild --root $$mockroot"; \
		if $(FEDPKG) $(FEDPKG_OPTS) mockbuild --root "$$mockroot"; then \
			succ="$${succ} $$(basename "$${mockroot}")"; \
		else \
			fail="$${fail} $$(basename "$${mockroot}")"; \
		fi; \
	done; \
	fi; \
	for f in $${succ}; do \
		clean=false; \
		echo "SUCC build for $${f}"; \
	done; \
	dirty=false; \
	for f in $${fail}; do \
		dirty=true; \
		echo "FAIL build for $${f}"; \
	done; \
	if "$$dirty"; then \
		echo "Some builds failed."; \
		exit 2; \
	fi

endif
