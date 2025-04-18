NVIM_CORE_PATH = "../pithyvim"

.PHONY: i install \
	build \
	l local \
	c clean \
	ca cleanall \
	gm gitmerge

i install:
	@rm -rf ~/.aliases
	@rm -rf ~/.tmux.conf
	@eval "ln -sf `realpath ./assets/dotfiles/.aliases` ~/.aliases"
	@eval "ln -sf `realpath ./assets/dotfiles/.tmux.conf` ~/.tmux.conf"
	@rm -rf ~/.config/nvim
	@rm -rf ./nvim/lazy-lock.json
	@rm -rf ./nvim/lua/pithyvim
	@ln -sf `realpath ./nvim` ~/.config/nvim

l local:
	@rm -rf ~/.config/nvim
	@cp ./local/lazy.lua ./nvim/lua/config/lazy.lua
	@rm -rf ./nvim/lua/pithyvim
	@eval "ln -sf `realpath ${NVIM_CORE_PATH}/lua/pithyvim` ./nvim/lua/pithyvim"
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

update:
	@cp -r ./assets/dotfiles/.aliases ~
	@cp -r ./assets/dotfiles/.tmux.conf ~


