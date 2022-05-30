SHELL := bash
ROOT := $(shell cd .. && pwd)
BASE := $(shell pwd)

NAME := $(shell basename $(BASE))

DOCKER_IMAGE := $(NAME)
DOCKER_CONTAINER := $(NAME)
EXEC_FILE := $(NAME)
AHIST := /tmp/ash-history
BHIST := /tmp/bash-history

.DELETE_ON_ERROR:

default:

test: start run pass

run: $(EXEC_FILE)
	docker run --rm \
	    -w /run \
	    -v $(BASE)/$<:/run/$< \
	    alpine ./$<

shell: $(EXEC_FILE)
	@touch $(AHIST) $(BHIST)
	docker run -it --rm \
	    -w /run \
	    -v $(BASE)/$<:/run/$< \
	    -v $(AHIST):/root/.ash_history \
	    -v $(BHIST):/root/.bash_history \
	    alpine sh

start:
	$(call yellow)
	$(call line)
	@echo -e 'Testing $(EXEC_FILE)'
	$(call line)
	$(call reset)

pass:
	$(call green)
	$(call line)
	@echo -e "TEST '$(EXEC_FILE)' OK!"
	$(call line)
	$(call reset)
	@echo

$(EXEC_FILE):
	docker build \
	    --build-arg EXEC_FILE=$@ \
	    --tag $(DOCKER_IMAGE) \
	    .
	docker create \
	    --name=$(DOCKER_CONTAINER) \
	    $(DOCKER_IMAGE)
	docker cp \
	    $(DOCKER_CONTAINER):/build/$@ \
	    $(ROOT)/$@
	docker rm \
	    $(DOCKER_CONTAINER)

clean:
	rm -f $(EXEC_FILE)

Y := \e[0;33m
G := \e[0;32m
Z := \e[0m

define yellow
@echo -ne '$Y'
endef

define green
@echo -ne '$G'
endef

define reset
@echo -ne '$Z'
endef

define line
@printf '%.0s=' {1..$(shell tput cols)}
endef
