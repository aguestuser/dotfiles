# @aguestuser's .bashrc

* located in `~/dotfiles/bash`
* entry point is `~/dotfiles/bash/.index`
* assumes being included in `~/.bashrc` with:

```bash
source ~/-/dotfiles/bash/.index
```

* assumes being sources from `~/.bash_profile` as such:

```bash
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
```

* also assumes pre-existing installation of `keychain`
  * osx: `brew install keychain`
  * linux: `apt-get install keychain`
