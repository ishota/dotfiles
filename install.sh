#!/bin/zsh

GITHUB_URL=https://github.com/ishota/dotfiles
DOT_PATH=~/dotfiles
DOT_FILES=(.vimrc)

# git が使えるなら git
if type "git"; then
    git clone --recursive "$GITHUB_URL" "$DOT_PATH"

# 使えない場合は curl か wget を使用する
elif type "curl" || has "wget"; then
    tarball="$GITHUB_URL""/archive/master.tar.gz"

    # どっちかでダウンロードして，tar に流す
    if type "curl"; then
        curl -L "$tarball"

    elif type "wget"; then
        wget -O - "$tarball"

    fi | tar zxv

    # 解凍したら，DOT_PATH に置く
    mv -f dotfiles-master "$DOT_PATH"

else
    die "git, curl or wget required"
fi

cd ~/dotfiles

# 移動できなかったら終了
if [ $? -ne 0 ]; then
    die "not found: $DOT_PATH"
fi

# 移動できたらシンボリックリンクを作成する
for file in ${DOT_FILES[@]}
do
    ln -snfv $DOT_PATH/$file $HOME/$file
done
