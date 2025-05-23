# Modules
# =======
if [[ $COLORTERM != (24bit|truecolor) && ${terminfo[colors]} -ne 16777216 ]]; then
  zmodload zsh/nearcolor
fi

# Zcompile plugins into wordblocks.
# =================================
function zcompile-many() {
  local f
  for f; do zcompile -R -- "$f".zwc "$f"; done
}

# Clone and compile to wordcode missing plugins.
# ==============================================
if [[ ! -e $ZDOTDIR/plugins/fzf-tab ]]; then
  git clone --depth=1 https://github.com/Aloxaf/fzf-tab.git $ZDOTDIR/plugins/fzf-tab
  zcompile-many $ZDOTDIR/plugins/fzf-tab/{fzf-tab.plugin.zsh,fzf-tab.zsh}
fi
if [[ ! -e $ZDOTDIR/plugins/fast-syntax-highlighting ]]; then
  git clone --depth=1 https://github.com/zdharma-continuum/fast-syntax-highlighting.git $ZDOTDIR/plugins/fast-syntax-highlighting
  mv -- $ZDOTDIR/plugins/fast-syntax-highlighting/{'→chroma','tmp'}
  zcompile-many $ZDOTDIR/plugins/fast-syntax-highlighting/{fast*,.fast*,**/*.ch,**/*.zsh}
  mv -- $ZDOTDIR/plugins/fast-syntax-highlighting/{'tmp','→chroma'}
fi
if [[ ! -e $ZDOTDIR/plugins/zsh-autosuggestions ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git $ZDOTDIR/plugins/zsh-autosuggestions
  zcompile-many $ZDOTDIR/plugins/zsh-autosuggestions/{zsh-autosuggestions.zsh,src/**/*.zsh}
fi
if [[ ! -e $ZDOTDIR/plugins/powerlevel10k ]]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZDOTDIR/plugins/powerlevel10k
  make -C $ZDOTDIR/plugins/powerlevel10k pkg
fi
if [[ ! -e $ZDOTDIR/plugins/zsh-completions ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-completions.git $ZDOTDIR/plugins/zsh-completions
fi
if [[ ! -e $ZDOTDIR/plugins/zsh-gentoo-completions ]]; then
  git clone --depth=1 https://anongit.gentoo.org/git/proj/zsh-completion.git $ZDOTDIR/plugins/zsh-gentoo-completions
fi

# Activate Powerlevel10k Instant Prompt.
# ======================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# General parameters and options.
# ===============================
setopt EXTENDED_GLOB
setopt GLOB_STAR_SHORT
setopt HASH_EXECUTABLES_ONLY
setopt INTERACTIVE_COMMENTS
setopt NO_CLOBBER
setopt NUMERIC_GLOB_SORT

# History.
# ========
HISTFILE=${XDG_DATA_HOME:=~/.local/share}/zsh/history
[[ -d $HISTFILE:h ]] || mkdir -p $HISTFILE:h
SAVEHIST=$(( 100 * 1000 ))
HISTSIZE=$(( 1.2 * SAVEHIST ))
setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

# Aliases.
# ========
#alias eix='eix -Rc'
#alias nvidia-settings="nvidia-settings --config='$XDG_CONFIG_HOME'/nvidia/settings"
alias %= \$=
alias colorscheme='for x in 0 1 4 5 7 8; do for i in {30..37}; do for a in {40..47}; do echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "; done; echo; done; done; echo "";'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias df='df -h' du='du -h'
alias diff='diff --color=yes'
alias dir='dir --color=yes'
alias doase='sudoedit'
alias ff4dinit='source ~/.local/share/ffmpeg4discord/env/bin/activate'
alias ff4dnotify="notify-send -u critical FF4D 'video compressed'"
alias ffmpeg='ffmpeg -hide_banner'
alias ffprobe='ffprobe -hide_banner'
alias lf='eza -ab -lhmT -Gg --git --group-directories-first -h --icons -L1 --octal-permissions --time-style=long-iso'
alias ls='ls -la --color=yes --group-directories-first'
alias webcaminit='scrcpy --video-source=camera --camera-{id=0,size=3840x2160,fps=60} --no-audio --v4l2-sink=/dev/video0 --no-playback'
alias webcampreview='mpv av://v4l2:/dev/pixel6a --profile=low-latency --untimed'
alias portagenotify="notify-send -u critical EMERGE 'job done'"
alias py='python'
alias rm='rm -rdI'
alias startx='startx "$XINITRC" -- "$XSERVERRC" vt1'
alias su='su -l'
alias vdir='vdir --color=yes'
alias vpndown='doas wg-quick down protonvpn'
alias vpnup='doas wg-quick up protonvpn'

# Misc?
MANPAGER="sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist nonu' -c 'nnoremap i <nop>' -\""

# Key bindings.
# =============
bindkey -v
unsetopt FLOW_CONTROL

# Completions.
# ============
# +---------+
# | Startup |
# +---------+
fpath=($ZDOTDIR/plugins/zsh-completions/src $fpath)
fpath=($ZDOTDIR/plugins/zsh-gentoo-completions/src $fpath)
fpath=(/usr/share/zsh/site-functions/* $fpath)
# Should be called before compinit.
zmodload zsh/complist
# Enable the "new" completion system (compsys).
autoload -Uz compinit && compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
[[ $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION.zwc -nt $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION ]] || zcompile-many $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
unfunction zcompile-many
_comp_options+=(globdots)
# +---------+
# | Options |
# +---------+
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.
# +---------+
# | Zstyles |
# +---------+
# Privileged autocomplete.
zstyle ':completion::complete:*' gain-privileges 1
# Define completers.
zstyle ':completion:*' completer _extensions _complete _approximate
# Use cache for commands using cache.
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/
# Complete the alias whem _expand_alias is used as a function.
zstyle ':completion:*' complete true
zle -C alias-expension complete-word _generic
#bindkey '^Xa' alias-expension
zstyle ':completion:alias-expension:*' completer _expand_alias

# +--------------+
# | FZF settings |
# +--------------+
# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

# Zsh Plugin Settings.
# +----------------+
# | Autosuggestion |
# +----------------+
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#808080,underline"
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_STRATEGY=(completion history)
# +---------+
# | Fzf-tab |
# +---------+
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# zle.
# ====
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Plugin loading.
# ===============
source $ZDOTDIR/plugins/fzf-tab/fzf-tab.plugin.zsh
source $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh && bindkey '^ ' autosuggest-accept
source $ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme
source $ZDOTDIR/.p10k.zsh

# fzf
# ===
source /usr/share/fzf/key-bindings.zsh
