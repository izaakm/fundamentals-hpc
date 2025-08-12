EDITOR ?= vim
PAGES := $(wildcard docs/*.md)

# Git
.PHONY: push
push: .pulled
	git push

.PHONY: pull
pull: .pulled
.pulled: .committed
	git pull --rebase
	touch $@

.PHONY: commit
commit: .committed
.committed: $(PAGES)
	git add $(PAGES)
	git commit -m "Update pages"
	touch $@

# WWW
HTML := $(foreach page,$(PAGES),build/$(notdir $(page:.md=.html)))

# $(info $(HTML))

.PHONY: www
www: $(HTML)
build/%.html: docs/%.md | build
	pandoc $< --standalone --to html \
		| sed -e 's/\.md/.html/' \
		> $@

build:
	mkdir -p build

.PHONY: e
e:
	@$(EDITOR) $(PAGES)
