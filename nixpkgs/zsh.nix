{ pkgs, ... }:

{
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    oh-my-zsh = {
        enable = true;
        plugins = ["git" "ssh-agent" "z"];
    };
    shellAliases={
        open = "xdg-open";
        chrome = "google-chrome-stable";
        google-chrome = "chrome";
        conf = "code ~/.config/nixpkgs/";
        d = "ddgr -n 5";
        define = "d -n 1 define";
        sw = "/home/michael/Documents/Projects/horizon-games/server-debug.sh";
    };
    initExtra = ''
        (cat ~/.cache/wal/sequences &)

        xset r rate 230 30

        ####path####
        export GOPATH="/home/michael/go"
        export SCRIPTPATH="/home/michael/.config/scripts"
        
        export PATH="$PATH:$SCRIPTPATH:/home/michael/go/bin"

        ####prompt####
        SPACESHIP_DIR_TRUNC=2
        SPACESHIP_DIR_COLOR="blue"
        SPACESHIP_GIT_BRANCH_COLOR="yellow"
        SPACESHIP_BATTERY_SHOW="always"
        SPACESHIP_DIR_TRUNC_PREFIX="../"
        SPACESHIP_PROMPT_ADD_NEWLINE="false"
        SPACESHIP_CHAR_SYMBOL="\uE0B0 "

        SPACESHIP_PROMPT_ORDER=(
                dir           # Current directory section
                git           # Git section (git_branch + git_status)
                battery       # Battery level and status
                line_sep      # Line break
                char          # Prompt character
        )

        ####alias####
        eval $(thefuck --alias)

        alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME/.config'

        format="%C(green)%h%Creset %C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset%s"

        alias glg='git log --date-order --all --graph --format=$format';

        alias glg2='git log --date-order --all --graph --stat --format=$format';


        ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

        typeset -A ZSH_HIGHLIGHT_STYLES
        ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'
        ZSH_HIGHLIGHT_STYLES[command]='fg=magenta,bold'
        ZSH_HIGHLIGHT_STYLES[builtin]='fg=magenta,bold'
        ZSH_HIGHLIGHT_STYLES[unknown-token]='bg=red,fg=white,bold'
        ZSH_HIGHLIGHT_STYLES[path]='fg=green,underline'

        typeset -A ZSH_HIGHLIGHT_PATTERNS
        ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red') # To have commands starting with `rm -rf` in red

        . ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    '';
}