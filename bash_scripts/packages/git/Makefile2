.PHONY: test-linux test-osx

test-osx: download-osx test

download-linux:
	@echo "downloading linux"
	curl -L https://github.com/tar.gz > x.tar.gz

download-osx:
	@echo "downloading osx"
	curl -L https://github.com/.tar.gz > x.tar.gz

test:
	./test.sh

INSTALL_MANPATH	= /usr/local/man/man1
INSTALL_SCRIPTS_PATH = /usr/local/bin

MANFILES = git_helper.sh.1 \
			  
SHELL_SCRIPTS = git_helper.sh \

install: install_shells install_manpages

install_manpages: $(MANFILES)
	mkdir -p $(INSTALL_MANPATH)
	cp $(MANFILES) $(INSTALL_MANPATH)/.

install_shells: $(SHELL_SCRIPTS)
	cp $(SHELL_SCRIPTS) $(INSTALL_SCRIPTS_PATH)/.
	chmod u+x /usr/local/bin/git_helper.sh

purge:
	rm -rf *~

