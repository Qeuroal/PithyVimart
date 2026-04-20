NVIM_CORE_PATH = "../pithyvim"
# 指定 SHELL 为 /usr/bash
SHELL := /bin/bash

.PHONY: i install \
	l local \
	ul unlocal \
	build \
	sa set_all \
	sd set_dotfiles \
	st set_templates \
	fr fresh \
	clean \
	call cleanall \
	ccache cleancache \
	clean_outdated_link \
	gcf gitconfig \
	gm gitmerge \
	gs gitsubmodule \
	gsu gitsubmoduleupdate \
	gsr gitsubmoduleremote

i install:
	@rm -rf ~/.config/nvim
	@rm -rf ./nvim/lazy-lock.json
	@rm -rf ./nvim/lua/pithyvim
	@ln -sf `realpath ./nvim` ~/.config/nvim

l local: install
	@ln -sf `realpath ${NVIM_CORE_PATH}/lua/pithyvim` ./nvim/lua/pithyvim

ul unlocal:
	@[ -L "./nvim/lua/pithyvim" ] && unlink "./nvim/lua/pithyvim" || true
	@git restore ./nvim/lua/config/lazy.lua

build: set_all
	@bash scripts/install.sh

sa set_all: set_dotfiles set_templates

sd set_dotfiles:
	@bash scripts/set_dotfiles.sh

st set_templates:
	@rm -rf ~/.editorconfig
	@ln -sf `realpath ./assets/templates/.editorconfig` ~/.editorconfig

fr fresh:
	@rm -rf ~/.local/share/nvim/
	@rm -rf ./nvim/lazy-lock.json

clean:
	@rm -rf ~/.config/nvim
	@rm -rf ~/.cache/nvim
	@rm -rf ~/.local/share/nvim
	@rm -rf ~/.local/state/nvim
	@rm -rf ./nvim/lazy-lock.json
	@rm -rf ./nvim/lua/pithyvim

call cleanall: clean
	@git restore . && git clean -fd
	@rm -rf ./nvim/pithyvim.json

ccache cleancache:
	@rm -v ~/.local/state/nvim/shada/main.shada

clean_outdated_link:
	@bash -c '([[ -L ~/.aliases ]] && echo "unlinking ~/.aliases..." && unlink ~/.aliases) || echo "no ~/.aliases symlink to remove."'
	@bash -c '([[ -L ~/.tmux.conf ]] && echo "unlinking ~/.tmux.conf" && unlink ~/.tmux.conf) || echo "no ~/.tmux.conf symlink to remove."'
	@bash -c '([[ -L ~/.custom_gitconfig ]] && echo "unlinking ~/.custom_gitconfig" && unlink ~/.custom_gitconfig) || echo "no ~/.custom_gitconfig symlink to remove."'
	@bash -c '([[ -L ~/.ssh/.custom_sshconfig ]] && echo "unlinking ~/.ssh/.custom_sshconfig" && unlinking ~/.ssh/.custom_sshconfig) || echo "no ~/.ssh/.custom_sshconfig symlink to remove."'

GITMERGE_INFO ?=
gm gitmerge:
ifdef GITMERGE_INFO
	@echo "\033[32m>>> GITMERGE_INFO: ${GITMERGE_INFO}\033[0m"
	@git switch master && git merge --no-ff -m "merge dev (${GITMERGE_INFO})" dev && git push && git switch dev
else
	@git switch master && git merge --no-ff -m "merge dev" dev && git push && git switch dev
endif

gcf gitconfig:
	git config --global diff.tool nvimdiff
	git config --global difftool.prompt false
	git config --global alias.vd difftool
	git config --global difftool.trustExitCode true
	git config --global mergetool.trustExitCode true

gsu gitsubmoduleupdate:
	git submodule init
	git submodule update

gsr gitsubmoduleremote:
	# `git submodule update` restores the submodule version in the remote repository
	git submodule update --remote


