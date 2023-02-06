## deinのインストール

ディレクトリの作成

```
mkdir -p  ~/.cache/dein
cd ~/.cache/dein
```

[ dein ](https://github.com/Shougo/dein.vim)のインストール

```
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein
```

## リポジトリのクローン

リポジトリのクローン

```
git clone git@github.com:noganogami/dotfiles.git
```

シンボリックリンクの作成

```
./make_link.sh
```
