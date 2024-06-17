### Added by Codeium. These lines cannot be automatically removed if modified
if command -v termium > /dev/null 2>&1; then
  eval "$(termium shell-hook show pre)"
fi
### End of Codeium integration


eval "$(/opt/homebrew/bin/brew shellenv)"


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

case `uname` in
  Darwin)
    export ZPLUG_HOME=$(brew --prefix)/opt/zplug
    export HOMEBREW_NO_INSTALL_CLEANUP=true
  ;;
  Linux)
    export ZPLUG_HOME=${HOME}/.zplug
  ;;
esac

export PATH="$HOME/.pyenv/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"

export EDITOR="nvim"

source $ZSH/oh-my-zsh.sh
source $ZPLUG_HOME/init.zsh

# Plugins list
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zdharma-continuum/fast-syntax-highlighting", defer:2
zplug "plugins/copydir", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/history", from:oh-my-zsh
zplug "plugins/jsontools", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "romkatv/powerlevel10k", as:theme, depth:1

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# pyenv config
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
export WORKON_HOME=$HOME/.virtualenvs
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
pyenv virtualenvwrapper_lazy

# alias
alias ws="cd ${HOME}/Workspace"
alias sojern="cd ${HOME}/Workspace/Sojern"

# nvm config (mac only)
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# place this after nvm initialization!
autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

# z config
. $(brew --prefix)/etc/profile.d/z.sh

# Gcloud config
# source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
# source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# export GOOGLE_APPLICATION_CREDENTIALS="${HOME}/Workspace/Sojern/sojern-portal-dev.json"

# fuck config
eval $(thefuck --alias)

export KUBE_EDITOR='code --wait'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="/opt/homebrew/opt/go@1.20/bin:$PATH"






### Added by Codeium. These lines cannot be automatically removed if modified
if command -v termium > /dev/null 2>&1; then
  eval "$(termium shell-hook show post)"
fi
### End of Codeium integration

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
eval "$(rbenv init - zsh)"
