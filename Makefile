HOMEFILES:= $(shell find config/home -type f -exec basename {} \;)
DOTFILES := $(addprefix $(HOME)/, $(HOMEFILES))

# checkparams:
# ifndef FILE
# 	$(error you have to define FILE)
# endif
#
# checkfile:
# ifeq ($(wildcard config/root/$(FILE)),)
# 	$(error directory $(FILE) needs to exist)
# endif

all: link_git link_zsh

link_git: $(foreach f, $(filter %gitconfig, $(DOTFILES)), $(f))
link_zsh: $(foreach f, $(filter %zshrc, $(DOTFILES)), $(f))

link_nvim: 
	ln -s $(CURDIR)/config/nvim ~/.config/

unlink_git:
	@for f in $(filter %gitconfig, $(DOTFILES)); do \
		if [ -h $$f ]; then \
			rm -i $$f; \
		fi; \
	done

unlink_zsh:
	@for f in $(filter %zshrc, $(DOTFILES)); do \
		if [ -h $$f ]; then \
			rm -i $$f; \
		fi; \
	done

brew: ## Installs commonly used Homebrew packages and casks
	-@$(CURDIR)/brew/brew.sh


${DOTFILES}:
	@ln -sv "$(PWD)/config/home/$(notdir $@)" $@
