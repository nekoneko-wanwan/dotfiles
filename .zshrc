# -------------------------------------
# 環境変数
# -------------------------------------

# 複数環境対応するため末尾用pathを指定
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# Apple Silico用
export PATH="/opt/homebrew/bin:$PATH"
# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

# SSHで接続した先で日本語が使えるようにする
export LANG=ja_JP.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# エディタ
export EDITOR=vim

# Path to your oh-my-zsh installation.
# export ZSH=$HOME/.oh-my-zsh
# source $ZSH/oh-my-zsh.sh

export PATH="/usr/local/opt/sqlite/bin:$PATH"

# -------------------------------------
# zshのオプション
# -------------------------------------
## 補完機能の強化
autoload -U compinit
compinit
# 補完機能を使用する
zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*:default' menu select=1
# 大文字、小文字を区別せず補完する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 補完でカラーを使用する
autoload colors
zstyle ':completion:*' list-colors "${LS_COLORS}"
# 補完関数の表示を強化する
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT
# マッチ種別を別々に表示
zstyle ':completion:*' group-name ''

## Ctrl+rとかを使えるように
bindkey -e


## 履歴機能
export HISTFILE=${HOME}/.zsh_history # 履歴ファイルの保存先
export HISTSIZE=500 # メモリに保存される履歴の件数
export SAVEHIST=5000 # 履歴ファイルに保存される履歴の件数
setopt hist_ignore_dups # 直前と同じコマンドを記録しない
setopt hist_ignore_all_dups # すでに履歴に含まれる場合古いほうを削除
setopt hist_ignore_space # 行頭がスペースのコマンドは記録しない
setopt hist_find_no_dups # 履歴検索中、(連続してなくとも)重複を飛ばす
setopt hist_reduce_blanks # 余分な空白は詰めて記録
setopt hist_no_store # histroyコマンドは記録しない
setopt pushd_ignore_dups # すでにスタックに含まれていればスタックに追加しない
# setopt extended_history # 開始と終了を記録
function history-all { history -E 1 } # 全履歴表示


## 移動機能
setopt auto_pushd # cd -[tab]で過去のディレクトリに
setopt auto_cd # ディレクトリ名の入力だけでcd


## その他
unsetopt correct_all # correct機能を無効
setopt correct # 入力しているコマンド名が間違っている場合にもしかして：を出す。
setopt nobeep # ビープを鳴らさない
setopt prompt_subst # 色を使う
setopt ignoreeof # ^Dでログアウトしない。
setopt no_tify # バックグラウンドジョブが終了したらすぐに知らせる。
setopt noautoremoveslash # パスの最後に付くスラッシュ(/)を自動的に削除させない
setopt complete_aliases # 補完される前にオリジナルのコマンドまで展開してチェックされる

# home, end, delキーを有効に
bindkey "^[[3~" delete-char
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line



# -------------------------------------
# プロンプト
# -------------------------------------

autoload -U promptinit; promptinit
autoload -Uz colors; colors
autoload -Uz vcs_info
autoload -Uz is-at-least

# begin VCS
zstyle ":vcs_info:*" enable git svn hg bzr
zstyle ":vcs_info:*" formats "(%s)-[%b]"
zstyle ":vcs_info:*" actionformats "(%s)-[%b|%a]"
zstyle ":vcs_info:(svn|bzr):*" branchformat "%b:r%r"
zstyle ":vcs_info:bzr:*" use-simple true

zstyle ":vcs_info:*" max-exports 6

if is-at-least 4.3.10; then
  zstyle ":vcs_info:git:*" check-for-changes true # commitしていないのをチェック
  zstyle ":vcs_info:git:*" stagedstr "<S>"
  zstyle ":vcs_info:git:*" unstagedstr "<U>"
  zstyle ":vcs_info:git:*" formats "(%b) %c%u"
  zstyle ":vcs_info:git:*" actionformats "(%s)-[%b|%a] %c%u"
fi

function vcs_prompt_info() {
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && echo -n " %{$fg[yellow]%}$vcs_info_msg_0_%f"
}
# end VCS

## Prompt
OK=":^o^"
NG="#^o^"

PROMPT=""
# 見やすくなるように改行をインサートする
PROMPT+="


"
PROMPT+="%(?.%F{green}$OK%f.%F{red}$NG%f) "
PROMPT+="[%{$fg[magenta]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%}]"
PROMPT+="\$(vcs_prompt_info)"
PROMPT+="
"
PROMPT+="%F{blue}%~%f"
PROMPT+="
"
# PROMPT+="%% "
PROMPT+="$ " # $表示に

# RPROMPT="[%*]" #右側に時刻を表示



# -------------------------------------
# エイリアス
# -------------------------------------

# -n 行数表示, -I バイナリファイル無視, svn関係のファイルを無視
# alias grep="grep --color -n -I --exclude='*.svn-*' --exclude='entries' --exclude='*/cache/*'"

# ls
alias ls="ls -G" # color for darwin
alias l="ls -G -la"
alias la="ls -la"
alias l1="ls -1"

# history
alias h="history"
alias ha="history-all"

# tree
alias tree="tree -NC" # N: 文字化け対策, C:色をつける

# git
alias g="git"

alias gst="git status && git stash list"
alias gsts="git status -s && git stash list"
alias glo="git log --stat"
alias glop="git log --stat -p"
alias gloo="git log --stat --oneline"
alias gsh="git show"
alias gsho="git show --oneline"
alias gbr="git branch"
alias gch="git checkout"
alias gchb="git checkout -b"
alias gchm="git checkout main"
alias gad="git add"
alias gada="git add --all"
alias gco="git commit"
alias gcoa="git commit --amend"
alias gdi="git diff"
alias gdic="git diff --cached"
alias gdih="git diff HEAD"
alias ggr="git grep"
alias ggrh="git grep HEAD"
alias ggrc="git grep --cached"
alias gre="git remote"
alias grev="git remote -v"
alias gsw="git switch"
alias gswc="git switch -c"

# alias gpl="git pull"
alias gopr="git browse-remote --pr" # PRを開く use: gem git-browse-remote

# tig
alias t="tig"
alias tst="tig status"
alias tr="tig refs"
alias tfp="tig --first-parent"

# docker
alias dc="docker-compose"
alias dcr='docker-compose run --rm'


# -------------------------------------
# その他
# -------------------------------------

# cdしたあとで、自動的に ls する
function chpwd() { ls -G -la }

# pecoの設定
## 履歴選択 ctrl+r で実行
function peco-history-selection() {
  BUFFER="$(\history -nr 1 | awk '!a[$0]++' | peco --query "$LBUFFER" | sed 's/\\n/\n/')"
  CURSOR=$#BUFFER
  zle -R -c
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

## ディレクトリ移動 ctrl+u で実行
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
    zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi

function peco-cdr () {
  local selected_dir="$(cdr -l | sed 's/^[0-9]\+ \+//' | peco --prompt="cdr >" --query "$LBUFFER")"
  if [ -n "$selected_dir" ]; then
    BUFFER="cd `echo $selected_dir | awk '{print$2}'`"
    CURSOR=$#BUFFER
    zle reset-prompt
  fi
}
zle -N peco-cdr
bindkey '^U' peco-cdr


# bookmark
# ref: https://threkk.medium.com/how-to-use-bookmarks-in-bash-zsh-6b8074e40774
# use: ln -s path/to/certain/directory/with/my/project @important-project
if [ -d "$HOME/.bookmarks" ]; then
    export CDPATH=".:$HOME/.bookmarks:/"
    alias goto="cd -P"
fi

# direnv direnvを有効化
eval "$(direnv hook zsh)"

# mysql
export PATH="/opt/homebrew/opt/mysql@5.7/bin:$PATH"
