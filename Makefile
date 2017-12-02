PKGFILE = pkgfile
DLDIR = /tmp/aurchpack
INSTALL = true
ifneq ("$(wildcard downloaded)","")
DOWNLOAD = false
else
DOWNLOAD = true
endif
DEPS = true
MAKEPKG = -si

.PHONY: install
install: download deps
ifeq ($(INSTALL),true)
	@echo "install downloaded packages (makepkg)"
	for D in $(DLDIR)/*/*/; do \
		cd $$D && makepkg $(MAKEPKG) ; \
	done
else
	@echo "NOT installing any packages"
endif

.PHONY: download
download: $(PKGFILE)
ifeq ($(DOWNLOAD),true)
	@while read PKG; do \
		echo "Downloading and extracting $$PKG ..."; \
		mkdir -p $(DLDIR)/$$PKG; \
		curl -s -L -o $(DLDIR)/$$PKG/$$PKG.tar.gz https://aur.archlinux.org/cgit/aur.git/snapshot/$$PKG.tar.gz && \
		tar -xvf $(DLDIR)/$$PKG/$$PKG.tar.gz -C $(DLDIR)/$$PKG/ 2>/dev/null &>/dev/null && echo "... $$PKG Extracted"; \
	done < $(PKGFILE)
	touch downloaded
else
	@echo "NOT downloading any packages"
endif

.PHONY: clean
clean:
	@echo "Cleaning up"
	@- rm -Rf $(DLDIR) 2>/dev/null &>/dev/null || echo "Error! Try removing /tmp/aurchpack manually (sudo rm -Rf /tmp/aurchpack)"
	@- rm downloaded

.PHONY: deps
deps:
ifeq ($(DEPS),true)
	@echo "Install dependencies (base-devel)"
	@sudo pacman -S base-devel
else
	@echo "NO dependency check"
endif
