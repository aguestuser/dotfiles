# miscelaneous configs for vendored apps

## firefox

- install from tarball: https://www.mozilla.org/en-US/firefox/channel/desktop/

```shell
ln -s /opt/firefox-nightly/firefox /usr/local/bin/firefox
```

## tor

- install from tarball: https://www.torproject.org/download/alpha/

```shell
ln -s /opt/tor-browser_en-US/Browser/start-tor-browser /usr/local/bin/tor-browser
```

### intellij

- tarball: https://www.jetbrains.com/idea/download/index.html#section=linux

```shell
ln -s /opt/idea-IU-<TAB COMPLETE>/bin/idea.sh /usr/local/bin/intellij
```

### webstorm

```shell
ln -s /opt/WebStorm-<TAB COMPLETE>/bin/webstorm.sh /usr/local/bin/webstorm
```

### pycharm

``` shell
ln -s /opt/pycharm-<TAB COMPLETE>/bin/pycharm.sh* /usr/local/bin/pycharm
sudo ln -s /usr/bin/black /usr/local/bin/black
```

### mypy

``` shell
pip install --upgrade mypy
```

### android studio

- tarball: https://developer.android.com/studio

```shell
ln -s /opt/android-studio/bin/studio.sh /usr/local/bin/android-studio
```

### genymotion

https://docs.genymotion.com/latest/Content/01_Get_Started/Installation.htm

```shell
sudo ln -s /opt/genymobile/genymotion/genymotion /usr/local/bin/genymotion
sudo ln -s /opt/genymobile/genymotion/genymotion-shell /usr/local/bin/gmshell
sudo ln -s /opt/genymobile/genymotion/gmtool /usr/local/bin/gmtool
```

### default webcam

if you have problems with new thinkpads with 2 webcams:
https://askubuntu.com/questions/1119743/how-do-i-change-the-default-webcam/1119832

## riseup-vpn

```shell
sudo apt install snap
sudo snap install --classic riseup-vpn
sudo ln -s ~/-/dotfiles/misc/start-riseup-vpn /usr/local/bin/riseup-vpn
```

## gpg keyservers

as per: https://dkg.fifthhorseman.net/blog/openpgp-certificate-flooding.html#use-abuse-resistant-keystores-to-refresh-certificates

``` shell
ln -s ~/-/dotfiles/misc/gpgdirmgr.conf ~/.gnupg/dirmngr.conf
rm ~/.gnupg/gpg.conf
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

## bluetooth headset
- to pair (maybe): https://mastodon.ar.al/@aral/104196577501219997
- to enable mic: https://askubuntu.com/questions/831331/failed-to-change-profile-to-headset-head-unit
  - with repo stored in `/usr/src`
