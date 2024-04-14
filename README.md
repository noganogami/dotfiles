## リポジトリのクローン

リポジトリのクローン

```
git clone git@github.com:noganogami/dotfiles.git
```

シンボリックリンクの作成

```
./setup.sh
```
## vim-lspのプラグインをインストール

py-lspのプラグインをインストール

```
cd ~/.local/share/vim-lsp-settings/servers/pylsp-all/
source ./venv/bin/activate
pip install pyls-isort python-lsp-black pylsp-mypy
```

