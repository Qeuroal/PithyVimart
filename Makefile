.PHONY: i install \
	l local \
	c clean \
	gm gitmerge

i install:
	@rm -rf ~/.local/share/nvim
	@rm -rf ~/.config/nvim
	@ln -sf `realpath ./` ~/.config/nvim

l local:
	@rm -rf ~/.local/share/nvim/lazy/PithyVim
	@ln -sf `realpath ./PithyVim` ~/.local/share/nvim/lazy/PithyVim

c clean:
	@rm -rf ~/.local/share/nvim

gm gitmerge:
	@git switch master && git merge --no-ff -m "merge dev" dev && git push && git switch dev


