# vim: set ts=8 sw=8 ai noet:

.PHONY: all
all: runtime

.PHONY: clean
clean:
	docker rmi -f sometheycallme/ansible-security || :

.PHONY: runtime
runtime:
	docker build --rm -t sometheycallme/ansible-security
	docker images | grep ansible-security

.PHONY: test
test:
	bats script/test_*.bats
