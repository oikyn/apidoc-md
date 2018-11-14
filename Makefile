.DEFAULT_GOAL := help

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: clean
clean: ## Clean vendor directory
	@rm -rf vendor

.PHONY: dep
dep: ## Install dep
	@which dep > /dev/null || curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

.PHONY: bundle
bundle: ## Install vendor library
	@dep ensure

.PHONY: fmt
fmt: ## Format source code
	@which goimports > /dev/null || go get -u golang.org/x/tools/cmd/goimports
	@goimports -d -w $(shell go list -f "{{.Dir}}" ./...)
