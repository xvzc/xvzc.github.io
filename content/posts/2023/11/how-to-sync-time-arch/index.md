---
title: How to synchronize the system clock on Arch Linux
date: 2023-11-03T11:15:53+09:00
draft: false
tags:
  - linux
---
Sometimes we get our Linux system clock out of sync. Today, we are going to take a look how to synchronize the system clock on Arch Linux.
<!--more-->
## Install NTP
Firstly, we need to install and enable NTP in your operating system. By enabling NTP for your `timedatectl`, your system will be able to synchronize your local time about once every 10 minutes with remote NTP server.
```zsh
$ yay -Syu ntp
$ sudo systemctl start ntpd.service
$ sudo systemctl enable ntpd.service
```

## Enable NTP for timedatectl
```zsh
$ sudo timedatectl set-ntp true
```

If you had followed the instruction above, you would be able to see your system time was finely synchronized.