# .zshrc更新時にコンパイルして読み込み高速化
if [ ! -f $ZDOTDIR/.zshrc -o $ZDOTDIR/.zshrc -nt $ZDOTDIR/.zshrc.zwc ]; then
  zcompile $ZDOTDIR/.zshrc
fi

# Inport {{{

# }}}

# Plugin {{{

source "$HOME/.zsh/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# search history on Ctrl+r
zinit light zdharma/history-search-multi-word

# syntax-highlighting for command line
zinit light zdharma/fast-syntax-highlighting

# auto suggestions
zinit light zsh-users/zsh-autosuggestions

# pure theme with zsh-async library that's bundled with it
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

# using vim for zsh
zinit light vim/vim

# Setup for Prezto
zinit snippet PZT::modules/helper/init.zsh
zinit snippet PZT::modules/gnu-utility/init.zsh
zinit snippet PZT::modules/utility/init.zsh
zinit snippet PZT::modules/directory/init.zsh
zinit snippet PZT::modules/history/init.zsh
zinit snippet PZT::modules/completion/init.zsh
zinit snippet PZT::modules/osx/init.zsh
zinit snippet PZT::modules/gpg/init.zsh

zstyle ':prezto:module:editor' dot-expansion 'yes'
zstyle ':prezto:module:editor' key-bindings 'vi'
zstyle ':prezto:module:editor' pc-context 'yes'
zstyle ':prezto:module:editor' managed 'yes'
zinit snippet PZT::modules/editor/init.zsh





# }}}

# Options {{{
setopt bash_auto_list
setopt list_ambiguous
setopt autopushd
setopt auto_cd
setopt transient_rprompt
# }}}
