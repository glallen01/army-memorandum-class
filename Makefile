SRC=$(wildcard examples/*.tex)

.PHONY: check clean proper

all: armymemo.cls $(SRC)
	cd examples && $(MAKE) all

check: armymemo.cls
	chktex armymemo.cls

clean:
	cd examples && $(MAKE) clean

proper: clean
	cd examples && $(MAKE) proper

