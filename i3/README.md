# i3 configs

## system dependencies

``` shell
sudo apt install i3 slock dunst compton xfonts-terminus arandr xss-lock lxterminal
```

i3 (i3, i3-status, dmenu)
slock (screen locking)
dunst (notifications)
compton (video)
xfonts-terminus (great font!)
arandr (displays)
xss-lock
lxterminal (terminal emulator)

##  symlinks

``` shell
ln -s ~/-/dotfiles/i3/i3config ~/.config/i3/config
ln -s ~/-/dotfiles/i3/i3statusconfig ~/.config/i3status/config
```

## volume controls

- install from repo: https://github.com/graysky2/pulseaudio-ctl

``` shell
sudo apt install pnmixer pulsemixer
cd ~/Downloads
git clone https://github.com/graysky2/pulseaudio-ctl
cd pulseaudio-ctl
make
sudo make install
which pulseaudio-ctl
ln -s ~/-/dotfiles/i3/pulseaudio-ctl.conf ~/.config/pulseaudio-ctl/config
rm -rf pulseaudio-ctl
```

- run `pnmixer` in systray from `S-D` (TODO: systemd job for this on launch)
- preferences settings (accessed by right-clicking systray):
  - behavior tab: set "Volume Control Command" to pavumixer
  - hotkeys: double click mute and volume control hotkeys, set to corresponding function keys
  - notifications: enable them all!

## brightness controls

- cf: https://askubuntu.com/questions/715306/xbacklight-no-outputs-have-backlight-property-no-sys-class-backlight-folder

``` shell
brightness_path=$(sudo find /sys/ -type f -iname '*brightness*' | grep intel_backlight/brightness)
sudo ln -s $brightness_path /sys/class/backlight
sudo ln -s ~/-/dotfiles/i3/xorg.conf /etc/X11/xorg.conf
```

# notifications

- currently we use
