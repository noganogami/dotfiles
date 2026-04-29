## 🚀 はじめに

開発環境を構築・管理するための dotfiles リポジトリです。

### ⌨️ 主な管理対象

- **Editor**: Neovim (Nightly) / Vim
- **Terminal**: WezTerm
- **Shell**: Zsh (Sheldon でプラグイン管理)
- **Multiplexer**: tmux
- **Package Manager**: Homebrew / proto
- **Others**: Karabiner-Elements, git, skk, ...

### 1. リポジトリのクローン

```bash
git clone git@github.com:noganogami/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. 初回インストール

`install.sh` を実行します。このスクリプトは以下の処理を行います。
- Homebrew のインストール（未インストールの場合）
- `just` コマンドのインストール
- **ツールのインストールと設定の反映** (`just sync` を実行し、Brewfile等のツールインストールとシンボリックリンク作成をまとめて行います)

```bash
./install.sh
```

## 🛠 日常の管理 (just)

セットアップ後は、`just` を使用して環境を最新の状態に保ちます。

| コマンド | 内容 |
| :--- | :--- |
| `just sync` | **推奨**: 設定ファイルのリンク(`link`)とツール一式のリフレッシュ(`update all`)を両方行います。 |
| `just update` | `Brewfile` のパッケージ、`proto` ツール、Neovim Nightly を更新します。(`just update all` と同等) |
| `just link` | 設定ファイル（`config/*`, `vimrc`, `tmux.conf` 等）を `~/.config` 等にリンクのみ行います。 |
| `just update <name>` | 指定したツールを更新（またはインストール）します。 |
| `just install-tools` | `Brewfile` と `proto` に記載されたツールをインストールします。 |

## 📁 構成

- **`config/`**: 各ツールの設定ディレクトリ。`~/.config/` 以下に動的にシンボリックリンクが張られます。
  - `nvim`, `wezterm`, `git`, `sheldon`, `alacritty`, `karabiner`, `efm-langserver`
- **`scripts/`**: 管理用の補助スクリプト。
  - `link_configs.sh`: 設定ファイルのリンク処理。
  - `install_nvim_nightly_macos.sh`: Neovim Nightly のインストール。
- **`justfile`**: コマンドランナー。日常的なタスクを定義。
- **`Brewfile`**: Homebrew で管理するパッケージ一覧。
- **`prototools`**: [proto](https://moonrepo.dev/proto) で管理するランタイム設定。
- **`skk/`**: SKK 辞書ファイル。
