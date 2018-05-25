# @aguestuser's emacs config

**Notes:**

* this config assumes Prelude installed and configured in `~/.emacs.d/init.el`
* it will work on OSX or Linux

# setup

* assuming this file is located in the directory `~/dotfiles/emacs`, create a symlink pointing to the directory:

``` shell
$ cd ~/.emacs.d
$ ln -s ~/dotfiles/emacs personal
```

* load the `personal` directory by inserting the following line at the bottom of `~/.emacs.d/init.el`:

``` elisp
(load "~/.emacs.d/personal/config.el")
```
