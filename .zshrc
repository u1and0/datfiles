# 少し凝った zshrc
# License : MIT
# http://mollifier.mit-license.org/

########################################
# 環境変数
export LANG=ja_JP.UTF-8


# 色を使用出来るようにする
autoload -Uz colors
colors

# emacs 風キーバインドにする
# bindkey -e

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# LESS設定
 # -----------------------------
 # __LESS ENVPATH__
 # -g  検索したとき、ヒットした全ての文字列を反転するのではなく、現在カーソルがある行のみ反転する。
 # -i  検索時に全部小文字で入力したときだけ、大文字小文字を無視する。
 # -M  詳しいプロンプトを表示する。
 # -R  ANSI カラーエスケープシーケンスを解するようになる。
 # -S  一行が長く、ターミナルの幅が狭くて表示できない場合、途中までしか表示しない。
 # -W  一度に2行以上移動した場合、新たに表示した最初の行をハイライトする。
 # -z-4    ウィンドウのサイズをターミナルのサイズ - 4 に設定する。
 # -x4 タブを 4 つのスペースで表現する。
 # -L  $LESSOPEN 環境変数を無効にする。
 # -N  行数
 export LESS='-MigrWx4'
  # -z-4'

 # man などの様々なコマンドがページャーとして less を使うようになります
 export PAGER=less
 # $PAGER を設定した状態で以下の環境変数を指定すると man ページに色が付きます。
 export LESS_TERMCAP_mb=$'\E[01;31m'      # Begins blinking.
 export LESS_TERMCAP_md=$'\E[01;31m'      # Begins bold.
 export LESS_TERMCAP_me=$'\E[0m'          # Ends mode.
 export LESS_TERMCAP_se=$'\E[0m'          # Ends standout-mode.
 export LESS_TERMCAP_so=$'\E[00;47;30m'   # Begins standout-mode.
 export LESS_TERMCAP_ue=$'\E[0m'          # Ends underline.
 export LESS_TERMCAP_us=$'\E[01;32m'      # Begins underline.

# gitプロンプト
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
GITPROMPT='${vcs_info_msg_0_}'

# プロンプト
# 1行表示
# PROMPT="%~ %# "
# 2行表示
PROMPT="%{$fg[cyan]%}%n@%m%{$fg[green]%} %~ ${GITPROMPT}
${reset_color}$ "



# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# 何故かsite-functionsの場所が`/usr/local/share/zsh/site-functions`になっていたのでパスを追加
# `$ echo $fpath | sed s/\\s/\\n/g`で確認
fpath=(/usr/share/zsh/site-functions $fpath)


# 補完
# 補完機能を有効にする
autoload -Uz compinit
compinit


# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


# 補完メッセージを読みやすくする(https://gist.github.com/mitukiii/4954559)
zstyle ':completion:*' verbose yes
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''


########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

########################################
# キーバインド

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward

########################################
# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

if [ -f ~/.bash_completions ]; then
    . ~/.bash_completions
fi

# vim:set ft=zsh: