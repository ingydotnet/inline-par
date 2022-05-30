SHELL := bash

DIRS := \
    docker-alpine-par-oneliner \
    docker-alpine-par-inline-oneliner \

TESTS := $(DIRS:%=test-%)

CLEAN := $(DIRS:%=clean-%)

default:

test: $(TESTS)

clean: $(CLEAN)

$(TESTS):
	$(MAKE) -C $(@:test-%=%) test

$(CLEAN):
	$(MAKE) -C $(@:clean-%=%) clean
