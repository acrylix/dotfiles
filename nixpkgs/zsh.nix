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

        ####path####
        export GOPATH="/home/michael/go"
        export PATH="$PATH:/home/michael/go/bin"

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
    '';
    plugins = [
        {
        name = "spaceship-prompt";
        src = pkgs.fetchFromGitHub {
            owner = "denysdovhan";
            repo = "spaceship-prompt";
            rev = "v3.10.0";
            sha256 = "03rjc3y24sz97x1fi6g66ky0pgw2q6z5r33vaprvnd2axay8pbdz";
        };
        file = "spaceship.zsh";
        }
        {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "2f3b98ff6f94ed1b205e8c47d4dc54e6097eacf4";
            sha256 = "1lyas0ql3v5yx6lmy8qz13zks6787imdffqnrgrpfx8h69ylkv71";
        };
        }
    ];
}