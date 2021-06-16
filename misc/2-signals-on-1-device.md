# How to run 2 signal installations on one device

Below is a guide for how to run a second installation of Signal on devices that already have an installation of signal running on them. This is useful if you would like to test signalboost using an throw-away account, or if you would like to interact with people over signal with a "YOLO account" that is not tied to your own identity and PII for work purposes.

Below, we provide instructions for running 2 instances of Signal on both your phone and desktop. Currently, the guide assumes that you use an Android phone and run some debian-based distribution of Linux on your computer. Happy to extend it to work for Apple devices if folks have suggestions!

## Phone

- on your android phone, set up a second User profile: Settings -> System -> Advanced -> Multiple Users -> Add user
- switch to the new User's account
- download signal to that User
- set up with phone number from twilio

## Computer

In all of the below, we will assume that you have an alias for your backup account named "alice." Please substitute your actual alias username anywhere in the instructions below where you see "alice" or "Alice".

### Create Data Directory and Link Device
- create a new signal data directory: mkdir ~/.config/Signal-Alice
- run signal desktop from command line: signal-desktop --user-data-dir=$HOME/.config/Signal-Alice
- link this signal desktop to the new signal user you just set up on your phone (via "linked devices" flow in Signal mobile app's settings pane)

### Create Desktop Entry

If you want to startup your alternate signal client without using the command line, you can create a desktop entry. [1]
- create a file called `/usr/share/applications/signal-desktop-alice`
- give it the following contents:
```
[Desktop Entry]
Name=Signal-Alice
Exec=/opt/Signal/signal-desktop --no-sandbox --user-data-dir=$HOME/.config/Signal-Alice %U
Terminal=false
Type=Application
Icon=signal-desktop
StartupWMClass=Signal-Alice
Comment=Private messaging from your desktop
MimeType=x-scheme-handler/sgnl;x-scheme-handler/signalcaptcha;
Categories=Network;InstantMessaging;Chat;
```
- now, you should be able to start your alias instance of signal desktop by typing `Signal-Alice` into the launcher

[1] see here for a generic guide on desktop entries: https://commithub.com/how-to-create-gnome-desktop-entry
