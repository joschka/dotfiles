if status is-interactive
  fish_vi_key_bindings

  set -xg EDITOR nvim
  set -xg GPG_TTY (tty)
  set -xg XSECURELOCK_PASSWORD_PROMPT time

  abbr -ag vim nvim
  abbr -ag show 'wezterm imgcat'
  abbr -ag rain "mpv --fullscreen --mute=yes --loop-file=inf /home/j/Videos/rain.mp4"
  set --local la 'exa --long --all --group-directories-first --icons'
  abbr -ag la $la
  abbr -ag lat "$la --sort=newest"
  abbr -ag ... 'cd ..; and cd ..'
  abbr -ag start "git fetch && git checkout origin/main && git checkout -b"
  abbr -ag cleanup "git remote prune origin && git branch -vv | grep 'origin/.*: gone]' | awk '{print \$1}' | xargs git branch -D"
  abbr -ag standby "systemctl suspend"
  abbr -ag off "poweroff"
  abbr -ag ni "npm install"
  abbr -ag yi "yarn install"
  abbr -ag cal "date && cal -y -w -m"
  abbr -ag pick "colorpicker --short"
  abbr -ag desk "xrandr --output DP-2-2 --primary --mode 3840x2160 --auto && xrandr --output eDP-1 --mode 1920x1080 --left-of DP-2-2 --auto"
  abbr -ag mobile "xrandr --output eDP-1 --primary --mode 1920x1080 --output DP-2-2 --off"

  abbr -ag gg "lazygit"
  abbr -ag gai "git add --interactive"
  abbr -ag gap "git add --patch"
  abbr -ag gbr "git branch"
  abbr -ag gca "git commit --amend"
  abbr -ag gcan "git commit --amend --no-edit"
  abbr -ag gci "git commit --verbose"
  abbr -ag gcm "git commit -m"
  abbr -ag gco "git checkout"
  abbr -ag gcp "git cherry-pick"
  abbr -ag gds "git diff --staged"
  abbr -ag glgf "git log --patch --follow --"
  abbr -ag grb "git rebase"
  abbr -ag gs "git status --short --branch"
  abbr -ag gsta "git stash --include-untracked"
  abbr -ag guc "git reset --soft HEAD^1"
  abbr -ag guc2 "git reset --soft HEAD^2"
  abbr -ag guc3 "git reset --soft HEAD^3"
  abbr -ag guc4 "git reset --soft HEAD^4"
  abbr -ag guc5 "git reset --soft HEAD^5"
  abbr -ag gucm "git reset --soft main"

  function load_nvm --on-variable="PWD"
    if test -e $PWD/.nvmrc -o -e $PWD/.node-version
      nvm use
    end
  end

  load_nvm
end

if status is-login
  if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
    exec startx -- -keeptty
  end
end

starship init fish | source
