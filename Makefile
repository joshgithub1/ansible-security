# vim: set ts=8 sw=8 ai noet:

.PHONY: all
all: runtime

.PHONY: clean
clean:
	script/clean

.PHONY: runtime
runtime:
	script/build

.PHONY: test
test:
	docker rm -f playbooks-data &> /dev/null || :
	docker rm -f hooktest &> /dev/null || :
	docker create --name playbooks-data playbooks-data true
	bats script/test_*.bats
