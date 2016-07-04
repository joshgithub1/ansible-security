# vim: set ts=8 sw=8 ai noet:

.PHONY: all
all: runtime

.PHONY: check
check:
	# Run python checks
	./check.py

.PHONY: clean
clean:
	script/clean

.PHONY: runtime
runtime:
	script/build

.PHONY: test
test: check
	bats script/test_*.bats
