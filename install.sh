#!/bin/zsh

GITHUB_URL=https://github.com/ishota/dotfiles
DOTPATH=~/dotfiles

# git が使えるなら git
if type "git"; then
    git clone --recursive "$GITHUB_URL" "$DOTPATH"

# 使えない場合は curl か wget を使用する
elif type "curl" || has "wget"; then
    tarball="$GITHUB_URL""/archive/master.tar.gz"

    # どっちかでダウンロードして，tar に流す
    if type "curl"; then
        curl -L "$tarball"

    elif type "wget"; then
        wget -O - "$tarball"

    fi | tar zxv

    # 解凍したら，DOTPATH に置く
    mv -f dotfiles-master "$DOTPATH"

else
    die "curl or wget required"
fi

cd ~/dotfiles
if [ $? -ne 0 ]; then
    die "not found: $DOTPATH"
fi

# 移動できたらリンクを実行する
for f in .??*
do
    [ "$f" = ".git" ] && continue

    ln -snfv "$DOTPATH/$f" "$HOME/$f"
done
