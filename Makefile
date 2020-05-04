FIND ?= find
R ?= R --vanilla -q
ECHO ?= echo -e

default: install

check: clean prepare
	_R_CHECK_CRAN_INCOMING_REMOTE_=false $(R) CMD check . --as-cran --ignore-vignettes --no-stop-on-test-error

prepare:
	autoreconf
	$(R) -e "Rcpp::compileAttributes()"

build: clean prepare
	$(R) CMD build . --no-build-vignettes

install: clean prepare
	$(R) CMD INSTALL --no-multiarch --strip .

uninstall:
	$(R) CMD REMOVE zstdR || true

release: clean prepare

install_remote:
	$(R) -e "devtools::install_github('eduardobull/zstdR', force = TRUE)"

clean:
	$(FIND) . -regex '.*\.s?o$$' -exec rm -v {} \;
	$(FIND) . -regex '.*\.a$$' -exec rm -v {} \;
	$(RM) -rv build/* && $(ECHO) "*\n!.gitignore" > build/.gitignore
	$(RM) -rv autom4te.cache configure config.log config.status src/Makevars ..Rcheck

.PHONY: default build clean install uninstall install_remote release
