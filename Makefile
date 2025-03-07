nvimCorePath = "../pithyvim"

.PHONY: i install \
	build \
	l local \
	c clean \
	ca cleanall \
	gm gitmerge

i install:
	@rm -rf ~/.local/share/nvim
	@rm -rf ~/.local/state/nvim
	@rm -rf ~/.config/nvim
	@rm -rf ./nvim/lazy-lock.json
	@rm -rf ./nvim/lua/pithyvim
	@ln -sf `realpath ./nvim` ~/.config/nvim

l local:
	@rm -rf ~/.local/share/nvim/
	@rm -rf ~/.local/state/nvim
	@cp ./local/lazy.lua ./nvim/lua/config/lazy.lua
	@rm -rf ~/.config/nvim
	@rm -rf ./nvim/lua/pithyvim
	@eval "ln -sf `realpath ${nvimCorePath}/lua/pithyvim` ./nvim/lua/pithyvim"
	@ln -sf `realpath ./nvim` ~/.config/nvim

c clean:
	@rm -rf ~/.config/nvim
	@rm -rf ~/.cache/nvim
	@rm -rf ~/.local/share/nvim
	@rm -rf ~/.local/state/nvim
	@rm -rf ./nvim/lazy-lock.json
	@rm -rf ./nvim/lua/pithyvim

ca cleanall: clean
	@git restore . && git clean -fd
	@rm -rf ./nvim/pithyvim.json

gm gitmerge:
	@git switch master && git merge --no-ff -m "merge dev" dev && git push && git switch dev

build:
	@bash scripts/install.sh

