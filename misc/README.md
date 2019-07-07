# miscelaneous configs for vendored apps

## tor

- install from tarball: https://www.torproject.org/download/alpha/

```shell
ln -s /opt/tor-browser_en-US/Browser/start-tor-browser /usr/local/bin/tor-browser
```

## firefox

- install from tarball: https://www.mozilla.org/en-US/firefox/channel/desktop/

```shell
ln -s /opt/firefox-nightly/firefox /usr/local/bin/firefox
```

## intellij

- tarball: https://www.jetbrains.com/idea/download/index.html#section=linux

```shell
ln -s /opt/idea-IU-<TAB COMPLETE>/bin/idea.sh /usr/local/bin/intellij
```

## riseup-vpn

```shell
sudo apt install snap
snap install --classic riseup-vpn
sudo ln -s ~/-/dotfiles/misc/start-riseup-vpn /usr/local/bin/riseup-vpn
```


## email (mu4e + msmtp)

- install mu4e from tarball: https://www.djcbsoftware.nl/code/mu/mu4e/Installation.html#Installation

then (note that .mpmtprc -- weirdly -- cannot be symlinked):

```shell
sudo apt install offlineimap msmtp
ln -s ~/-/dotfiles/misc/offlineimaprc ~/.offlineimaprc
cp ~/-/dotfiles/misc/msmtprc ~/.msmtprc
sudo chmod 600 ~/.msmtprc
```
