DESTDIR ?= dest
PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
MOZILLADIR ?= /usr/lib/mozilla/native-messaging-hosts

all: ime-mode-we-host.tar.gz ime-mode-we.xpi

ime-mode-we.xpi: add-on/*.js add-on/*.json
	cd add-on && zip -r -0 ../ime-mode-we.xpi *.json *.js

ibus-utils/ibus-set-input-mode:
	git submodule update -i

ime-mode-we-host.tar.gz: app/ime-mode-we app/com.clear_code.ime_mode_we_host.json ibus-utils/ibus-set-input-mode
	rm -rf $(DESTDIR)
	install -d $(DESTDIR)$(MOZILLADIR)
	install -m 644 app/com.clear_code.ime_mode_we_host.json $(DESTDIR)$(MOZILLADIR)
	install -d $(DESTDIR)$(BINDIR)
	install -m 755 app/ime-mode-we $(DESTDIR)$(BINDIR)
	install -m 755 ibus-utils/ibus-set-input-mode $(DESTDIR)$(BINDIR)
	sed -i -e "s#/usr/local#$(PREFIX)#g" $(DESTDIR)$(MOZILLADIR)/com.clear_code.ime_mode_we_host.json
	sed -i -e "s#/usr/local#$(PREFIX)#g" $(DESTDIR)$(BINDIR)/ime-mode-we
	tar cvfz $@ -C $(DESTDIR)/ --owner=root --group=root .
	rm -rf $(DESTDIR)

install-host: ime-mode-we-host.tar.gz
	tar xvf $< -C /

install: install-host

clean:
	rm -f ime-mode-we-host.tar.gz ime-mode-we.xpi
