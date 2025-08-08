EDITOR ?= vim
PAGES := docs/*.md

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

.PHONY: e
e:
	@$(EDITOR) $(PAGES)
