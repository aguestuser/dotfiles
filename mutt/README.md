mutt
============

# dependencies
- mutt
- msmptp

# docs
- [mutt wiki](https://gitlab.com/muttmua/mutt/-/wikis/home)
- [mutt conceptual overview](https://gitlab.com/muttmua/mutt/-/wikis/MailConcept)
- [mutt sendmail agent list](https://gitlab.com/muttmua/mutt/-/wikis/SendmailAgents)
- [learning mutt]()
- [mutt tutorial](https://www.ucolick.org/~lharden/learnmutt.html
)
- [mutt cheatsheet](https://www.ucolick.org/~lharden/muttchart.html)

- [smptp manapge](https://manpages.debian.org/bullseye/msmtp/msmtp.1.en.html)
- [smptp debian package page](https://wiki.debian.org/msmtp) -- basic configs / gpg pass setup
- [smptp quickie](https://hostpresto.com/community/tutorials/how-to-send-email-from-the-command-line-with-msmtp-and-mutt/)

- [fetchmail docs](https://www.fetchmail.info/fetchmail-man.html#5)
- [fetchmairc example](https://www.linode.com/docs/guides/using-fetchmail-to-retrieve-email/)

++++++++++++++++++++++++++
- [FULL MANUAL](https://muttmua.gitlab.io/mutt/manual-dev.html#autocrypt)
++++++++++++++++++++++++++

# mbsync (receive)
- [full mbsync + msmtp config w/ onions](https://kushaldas.in/posts/access-riseup-email-over-onion-service.html)
- [mbsync example](https://people.kernel.org/mcgrof/replacing-offlineimap-with-mbsync)
++++++++++++++++++++
- [very good mbsync + mutt example](https://gist.github.com/chandraratnam/f00ab7d4a5298830f692021964fdb99f)
+++++++++++++++++++++++

``` shell
crontab -e
```
then:

```crontab
# check mail for aguestuser@riseup.net
*/5 * * * * torify mbsync -a aguestuser
```


# gpg
- https://gitlab.com/muttmua/mutt/-/wikis/MuttGuide/UseGPG

``` shell
cp /usr/share/doc/mutt/examples/gpg.rc ~/.gpg.rc
echo "source ~/.gpg.rc" >> ~/.muttrc
```

- see autocrypt section:

# notmuch
- basics: https://wiki.archlinux.org/title/Notmuch#Integrating_with_mutt
- post-sync index hook: https://wiki.archlinux.org/title/isync#Calling_mbsync_automatically

install notmuch
``` shell
sudo apt install notmuch
notmuch setup
notmuch new
```

install notmuch-mutt:

``` shell
sudo apt install notmuch-mutt
```

add configs:

``` shell

```

systemd sync job:

``` shell
# ~/.config/systemd/user/mbsync.service

[Unit]
Description=Mailbox synchronization service

[Service]
Type=oneshot
ExecStart=/usr/bin/mbsync -Va
ExecStartPost=/usr/bin/notmuch new
```
timer for sync job (runs every 5 min, starting 2 min after boot):

``` shell
# ~/.config/systemd/user/mbsync.timer

[Unit]
Description=Mailbox synchronization timer

[Timer]
OnBootSec=2m
OnUnitActiveSec=5m
Unit=mbsync.service

[Install]
WantedBy=timers.target
```

load changes

``` shell
sudo systemctl daemon-reload
systemctl --user enable mbsync.timer
systemctl --user start mbsync.timer
```

## config files
- ~/.muttrc
- ~/.msmtprc
- ~/.msmtp-austing.gpg

## notes

- to get riseup cert (make this a cron job):
torify openssl s_client -connect 5gdvpfoh6kb2iqbizb37lzk2ddzrwa47m6rpdueg2m656fovmbhoptqd.onion:993 -showcerts 2>&1 < /dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' | sed -ne '1,/-END CERTIFICATE-/p' > ~/.cert/riseuponion.pem

- search body:
https://unix.stackexchange.com/questions/91046/search-for-mail-content-with-mutt#91048
