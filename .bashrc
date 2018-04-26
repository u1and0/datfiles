# Export Pathes
export LANG=ja_JP.UTF-8
export SHELL=/usr/bin/zsh
export TERM="xterm-256color"
# LinuxBrew setting
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export MANPATH="/home/linuxbrew/.lilinuxbrew/nuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"
export XDG_DATA_DIRS="/home/linuxbrew/.lilinuxbrew/nuxbrew/share:$XDG_DATA_DIRS"


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
export PAGER='less'
# $PAGER を設定した状態で以下の環境変数を指定すると man ページに色が付きます。
export LESS_TERMCAP_mb=$'\E[01;31m'      # Begins blinking.
export LESS_TERMCAP_md=$'\E[01;31m'      # Begins bold.
export LESS_TERMCAP_me=$'\E[0m'          # Ends mode.
export LESS_TERMCAP_se=$'\E[0m'          # Ends standout-mode.
export LESS_TERMCAP_so=$'\E[00;47;30m'   # Begins standout-mode.
export LESS_TERMCAP_ue=$'\E[0m'          # Ends underline.
export LESS_TERMCAP_us=$'\E[01;32m'      # Begins underline.


# デフォルトのエディタ
if which nvim > /dev/null 2>&1 ; then
    export EDITOR='nvim'
    export VISUAL='nvim'
else
    export EDITOR='vim'
    export VISUAL='vim'
fi


# Load external files
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

if [ -f ~/.pyenvrc ] && [ -d ~/pyenv ]; then
    . ~/.pyenvrc
fi

if which thefuck >/dev/null 2>&1 ; then
    eval $(thefuck --alias)
fi

if which fasd >/dev/null 2>&1 ; then
    eval $(fasd --init auto)
fi

