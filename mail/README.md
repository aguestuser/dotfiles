# dependencies
- mu
- msmptp
- isync
- tor
- mu4e (is special...)

```shell
sudo apt install mu msmtp isync tor
systemctl start tor
```

mu4e is special! (https://www.djcbsoftware.nl/code/mu/mu4e/Installation.html)

```shell
sudo apt install libgmime-3.0-dev libxapian-dev guile-2.0-dev html2text xdg-utils libwebkitgtk-3.0-dev python3-html2text meson
cd ~/
git clone git://github.com/djcb/mu.git
cd mu
meson build && ninja -C build
sudo ninja -C install
```

# configs

```shell
# fetch riseup TLS cert every morning
ln -s ~/-/dotfiles/mail/fetch-riseup-cert /usr/local/bin/fetch-riseup-cert
cat ~/-/dotfiles/mail/fetch-riseup-cert-cronjob | sudo tee -a /etc/crontab

# msmtp (send) configs
ln -s ~/-/dotfiles/mail/.msmtprc ~/.msmtprc
ln -s ~/-/dotfiles/mail/.msmtp-aguestuser.gpg ~/.msmtp-aguestuser.gpg
ln -s ~/-/dotfiles/mail/.msmtp-austing.gpg ~/.msmtp-austing.gpg

# mbsync (fetch) job
ln -s ~/-/dotfiles/mail/.mbsyncrc ~/.mbsyncrc
cp ~/-/dotfiles/mail/mbsync.service ~/.config/systemd/user/mbsync.service
cp ~/-/dotfiles/mail/mbsync.timer ~/.config/systemd/user/mbsync.timer
```

# other configs:
- see: `~/-/dotfiles/emacs/program/mu4e.el`

# docs

## msmtp
- [msptp manapge](https://manpages.debian.org/bullseye/msmtp/msmtp.1.en.html)
- [msptp debian package page](https://wiki.debian.org/msmtp) -- basic configs / gpg pass setup
- [msptp quickie](https://hostpresto.com/community/tutorials/how-to-send-email-from-the-command-line-with-msmtp-and-mutt/)

## riseup + tor
- https://kushaldas.in/posts/access-riseup-email-over-onion-service.html

## mu4e
- https://www.djcbsoftware.nl/code/mu/mu4e/

## gpg conf file
- is at: ``
