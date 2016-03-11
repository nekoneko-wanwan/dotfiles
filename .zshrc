# -------------------------------------
# 環境変数
# -------------------------------------

# SSHで接続した先で日本語が使えるようにする
export LANG=ja_JP.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# エディタ
export EDITOR=/usr/local/bin/vim


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


## 履歴機能
export HISTFILE=${HOME}/.zsh_history # 履歴ファイルの保存先
export HISTSIZE=1000 # メモリに保存される履歴の件数
export SAVEHIST=10000 # 履歴ファイルに保存される履歴の件数
setopt hist_ignore_dups # 直前と同じコマンドを記録しない
setopt hist_ignore_all_dups # すでに履歴に含まれる場合古いほうを削除
setopt hist_ignore_space # 行頭がスペースのコマンドは記録しない
setopt hist_find_no_dups # 履歴検索中、(連続してなくとも)重複を飛ばす
setopt hist_reduce_blanks # 余分な空白は詰めて記録
setopt hist_no_store # histroyコマンドは記録しない
setopt pushd_ignore_dups # すでにスタックに含まれていればスタックに追加しない
# setopt extended_history # 開始と終了を記録


## 移動機能
setopt auto_pushd # cd -[tab]で過去のディレクトリに
setopt auto_cd # ディレクトリ名の入力だけでcd


## その他
setopt correct # 入力しているコマンド名が間違っている場合にもしかして：を出す。
setopt nobeep # ビープを鳴らさない
setopt prompt_subst # 色を使う
setopt ignoreeof # ^Dでログアウトしない。
setopt no_tify # バックグラウンドジョブが終了したらすぐに知らせる。
setopt noautoremoveslash # パスの最後に付くスラッシュ(/)を自動的に削除させない
setopt complete_aliases # 補完される前にオリジナルのコマンドまで展開してチェックされる



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
OK=":^ω^"
NG="#^ω^"

PROMPT=""
# 見やすくなるように改行をインサートする
PROMPT+="



"
PROMPT+="%(?.%F{green}$OK%f.%F{red}$NG%f) "
PROMPT+="[%n% @%m% ]"
PROMPT+="\$(vcs_prompt_info)"
PROMPT+="
"
PROMPT+="%F{blue}%~%f"
PROMPT+="
"
PROMPT+="%% "

RPROMPT="[%*]"



# -------------------------------------
# エイリアス
# -------------------------------------

# -n 行数表示, -I バイナリファイル無視, svn関係のファイルを無視
alias grep="grep --color -n -I --exclude='*.svn-*' --exclude='entries' --exclude='*/cache/*'"

# ls
alias ls="ls -G" # color for darwin
alias l="ls -G -la"
alias la="ls -la"
alias l1="ls -1"

# history
alias h="history"

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
alias gchm="git checkout master"
alias gad="git add"
alias gada="git add --all"
alias gco="git commit"
alias gam="git commit --amend"
alias gdi="git diff"
alias gdic="git diff --cached"
alias gdih="git diff HEAD"
alias ggr="git grep"
alias ggrh="git grep HEAD"
alias ggrc="git grep --cached"
alias gre="git remote"
alias grev="git remote -v"

# tig
alias t="tig"
alias tst="tig status"



# -------------------------------------
# その他
# -------------------------------------

# cdしたあとで、自動的に ls する
function chpwd() { ls -G -la }

