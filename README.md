# deinのインストール

ディレクトリの作成

```
        mkdir -p  ~/.cache/dein
        cd ~/.cache/dein
```

deinのインストール

```
        curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
        sh ./installer.sh ~/.cache/dein
```

# リポジトリのクローン

リポジトリのクローン

```
        git clone git@github.com:noganogami/dotfiles.git
```

.vimrcのシンボリックリンクの作成

```
        ln -s ~/dotfiles/.vimrc ~/.vimrc
```

# プラグインの設定

previmの設定

```
        let g:previm_open_cmd= 'ブラウザを開くコマンド'
```
