abspath_to_makefile := $(abspath $(lastword $(MAKEFILE_LIST)))
makefile_dir := $(patsubst %/,%,$(dir $(abspath_to_makefile)))

.PHONY: all
all: build

.PHONY: build
build:
	docker build --pull --tag eightycolumns/openjdk:8 $(makefile_dir)

executables := java javac

install_executables := $(executables:%=install_%)

.PHONY: install
install: $(install_executables)

bin_dir := $(HOME)/bin

.PHONY: $(install_executables)
$(install_executables): | $(bin_dir)
	$(eval executable := $(@:install_%=%))
	cp -f $(makefile_dir)/$(executable) $(bin_dir)/$(executable)

$(bin_dir):
	mkdir -p $@

uninstall_executables := $(executables:%=uninstall_%)

.PHONY: uninstall
uninstall: $(uninstall_executables)

.PHONY: $(uninstall_executables)
$(uninstall_executables):
	$(eval executable := $(@:uninstall_%=%))
	rm -f $(bin_dir)/$(executable)
