# Prerequiremnts

## Windows
###powershell
```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

cinst git msys2
```

環境変数`MSYS2_PATH_TYPE`に`inherit`を登録する。

### msys2
```
pacman -S --noconfirm make
git clone https://github.com/s0ran/dotfiles.git ~/.dotfiles
```

## Mac & Linux
```
git clone https://github.com/s0ran/dotfiles.git ~/.dotfiles
```

# Install
```
make all
```

# Description
## Mac
1. Install brew to `/opt/homebrew/bin/brew`
1. Install brew package
1. Install fish
1. Install fish package
1. change shell & set alias for fish config
1. Install wezterm & set alias for wezterm config
1. Install fish & set alias for nvim config

# Available feature
- update fish config
- add fish function with update of `.gitignore`
- update nvim config
- update wezterm config

# Future feature
- update brew packages
- update fish packages
