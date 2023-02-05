set -q PATH; or set PATH ''

# Varialbe: General
set -gx DESKTOP $HOME/Desktop
set -gx DOWNLOADS $HOME/Downloads
set -gx EDITOR nvim

switch (uname -s)
    case Darwin
        set -gx OS Mac
    case Linux
        set -gx OS Linux
    case 'MSYS*'
        set -gx OS Windows
end

# Variable: HomeBrew
if test $OS != 'Windows'
    set -gx HOMEBREW_PREFIX /opt/homebrew
    set -gx HOMEBREW_REPOSITORY $HOMEBREW_PREFIX
    set -gx HOMEBREW_CELLAR $HOMEBREW_PREFIX/Cellar
    set -gx PATH $HOMEBREW_PREFIX/bin $HOMEBREW_PREFIX/sbin $PATH
end

#Variable: Fish
set -gx SHELL (which fish)
set -gx FISH_FUNCTIONS $HOME/.config/fish/functions
set -gx FISH_CONFIG $HOME/.config/fish/config.fish

# Variable: NodeBrew
set -gx NODEBREW_ROOT $HOMEBREW_PREFIX/var/nodebrew
set -gx PATH "$HOME/.nodebrew/current/bin" $PATH

# Variable: man
set -q MANPATH; or set MANPATH ''
set -gx MANPATH $HOMEBREW_PREFIX/share/man $MANPATH

# Variable: info
set -q INFOPATH; or set INFOPATH ''
set -gx INFOPATH $HOMEBREW_PREFIX/share/info $INFOPATH

# Varialbe: Tool: pkgconfig
set -gx PKG_CONFIG_PATH $HOMEBREW_PREFIX/opt/readline/lib/pkgconfig $HOMEBREW_PREFIX/lib/pkgconfig

# Variable: Tool: Pipenv
set -gx PIPENV_VENV_IN_PROJECT 1

# Variable: Tool: ghq
set -gx GHQ_SELECTOR peco

# Variable: Tool: FLUTTER
set -gx FLUTTER_ROOT /opt/flutter
set -gx PATH $FLUTTER_ROOT/bin $PATH

# Variabl: Language: C Cpp
set -gx LDFLAGS -L$HOMEBREW_PREFIX/opt/readline/lib
set -gx CPPFLAGS -I$HOMEBREW_PREFIX/opt/readline/include

# Variable: Language: Go
set -gx GOENV_GOPATH_PREFIX $HOME/.go
set -gx GOBIN $GOENV_GOPATH_PREFIX/tools/bin
set -gx GOENV $GOPATH/env
set -gx PATH $PATH $GOPATH/bin $GOBIN

# Variable: For me
set -gx ALGORITHM_LIBRARY $DESKTOP/CompetitiveProgramming/Library
set -gx SUBL_SNIPPETS $HOME/Library/Application\ Support/Sublime\ Text/Packages/User/Snippets
set -gx GCJ_ROOT $DESKTOP/CompetitiveProgramming/GCJ
set -gx ATCODER_ROOT $DESKTOP/CompetitiveProgramming/AtCoder
set -gx METADATA $DESKTOP/Metadata
set -gx LABORATORY $DESKTOP/Laboratory

if test $OS = 'Mac'
    # Setup: Anyenv
    if status is-interactive
        source (anyenv init -|psub)
        # Commands to run in interactive sessions can go here
    end

    # Setup: iTerm2
    functions iterm2_shell_integration

    # Setup: gh
    if status is-interactive
        eval (gh completion -s fish| source)
    end
end

# Setup: wezterm
set -gx WEZTERM_CONFIG $HOME/.config/wezterm

# Setup: nvim
set -gx NVIM_CONFIG $HOME/.config/nvim

# Setup: dotfiles
set -gx DOTFILES $HOME/.dotfiles


