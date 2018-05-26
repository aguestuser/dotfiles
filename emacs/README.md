# @aguestuser's emacs config

# setup

* install prelude:

``` shell
$ curl -L https://github.com/bbatsov/prelude/raw/master/utils/installer.sh | sh
```

* assuming this file is located in the directory `~/-/dotfiles/emacs`, create a symlink pointing to the directory:

``` shell
$ cd ~/.emacs.d
$ ln -s ~/-/dotfiles/emacs personal
```

* load the `personal` directory by inserting the following line at the bottom of `~/.emacs.d/init.el`:

``` shell
$ echo ";;;;;;;;;;;;;;;;;;;;;;;;;;;" >> ~/.emacs.d/init.el && \
  echo ";;;load dotfiles configs ;;" >> ~/.emacs.d/init.el && \
  echo ";;;;;;;;;;;;;;;;;;;;;;;;;;;" >> ~/.emacs.d/init.el && \
  echo "(load "~/.emacs.d/personal/config.el")" >> ~/.emacs.d/init.el
```
