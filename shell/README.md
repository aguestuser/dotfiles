# @aguestuser's shell configs

## for zsh
* entry point is `~/-/dotfiles/bash/.zshrc`
* assumes being linked (or sourced) from ~/.zshrce

for example:

```shell
ln -s ~/-/dotfiles/shell/.zshrc ~/.zshrc
```

### installation guide:
#### 1. setup

follow this install guide: https://www.howtogeek.com/362409/what-is-zsh-and-why-should-you-use-it-instead-of-bash/
install this theme: https://github.com/romkatv/powerlevel10k

```shell
# install zsh
sudo apt install zsh

# get oh-my-zsh + powerlevel10k
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# set zsh as default shell
chsh -s $(which zsh)
```
in ~/.zshrc: `ZSH_THEME="powerlevel10k/powerlevel10k"`

#### 2. mcfly:

follow: https://lib.rs/crates/mcfly

``` shell
cargo install mcfly # ensure >= 0.6.0
```
in ~/.zshrc: `eval "$(mcfly init zsh)"`

#### 3. zsh-z:

follow: https://github.com/agkozak/zsh-z

``` shell
git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z
```
in ~/.zshrc: `plugins=(git zsh-z)`


## for bash

* entry point is `~/-/dotfiles/bash/.bashrc`
* assumes being included in `~/.bashrc` with:

```shell
source ~/-/dotfiles/shell/.bashrc
```

or alternately:

```shell
ln -s ~/-/dotfiles/shell/.bashrc ~/.bashrc
```


* assumes being sourced from `~/.bash_profile` as such:

```bash
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
```

## for both:

* assumes pre-existing installation of `keychain`
  * osx: `brew install keychain`
  * linux: `apt-get install keychain`
