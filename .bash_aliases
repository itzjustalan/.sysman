#neofetch	#takes time to load try peafetch or shell-color-scripts instead #neofetch --ascii "$(fortune | cowsay -f bsp0
#lowfish -W 30)"
#neofetch --ascii "$(fortune | cowsay -f $(/usr/bin/ls /usr/share/cows/ | shuf -n 1) -W 30 )"

#wal -q -n -i ~/downloads/almas_banner.png

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# Not supported in the "fish" shell.
#(cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
#cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
#source ~/.cache/wal/colors-tty.sh

# WELCOME
#if [ "$(date +%F)" != "$(cat ~/dateFile)" ];then
#    welcome.sh
#    date +%F > ~/dateFile
#else
#    ~/myfiles/repos/shell-color-scripts/colorscript.sh random
#fi

# ~/myfiles/pgms/shell-color-scripts/colorscript.sh random
#~/myfiles/repos/shell-color-scripts/colorscript.sh random
#~/myfiles/repos/shell-color-scripts/colorscript.sh -e 36

#cmus ~/Music/rplay.m3u

# shell completions
#source <(vr completions bash)   # velociraptor (deno)
# source /usr/share/bash-completion/completions/git # git
[[ -f /usr/share/bash-completion/completions/git ]] && . /usr/share/bash-completion/completions/git

export EDITOR=nvim
#aliases
alias alias_name="actual_alias"

alias bbash="source ~/.bashrc"

alias h="tac ~/.bash_history | dmenu | tr -d '\n' | xclip -selection c"
alias c=cat
alias cp="cp -ir" # confirm before overwriting something
alias cpy="cp -r"
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB
alias more=less
alias sv="sudoedit"
alias nv=nvim
alias "nv."="nvim ."
#alias v=nvim
alias m=mpv
#alias z="zathura"
#alias rm="rm -rfi"
# alias ll='lsd -lah --group-dirs first --color=auto'
alias ll='lsd -lA --group-dirs=first --color=always --icon=always --icon-theme=fancy --permission=rwx --blocks=permission,user,size,name'
alias lll='lsd -lA --group-dirs=first --color=always --icon=always --icon-theme=fancy --permission=rwx --blocks=permission,user,size,date,name'
alias jj="ll"
alias kk="ll"
alias cdd="cd .."
alias cdc="cd -"
alias diff="diff --color=auto"
alias mkdir="mkdir -p"
# alias chbr="sudo /home/alan/.sysman/sys/change-brightness"
alias bts="/home/alan/.sysman/sys/get-bat-stats.sh;date"
alias curdir="pwd | rev | cut -d '/' -f 1 | rev"
alias sortsize="/bin/ls -lSah --color=auto"
#alias cowsayy="cowsay -f $(ls ~/myfiles/mycows | shuf -n 1)"
#alias clear="[ $[$RANDOM % 8] = 0 ] && timeout 2 cmatrix || clear"
alias vavs="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash"

alias car="cd ~/static/vt100 ; ./slowcat.pl"
alias cartoons="cartoon $(/bin/ls | grep .vt | shuf -n 1)"
alias basha="$EDITOR ~/.bash_aliases"
alias c.="code ."
alias pS="paru -S"
alias pR="paru -R"
alias pQ="paru -Q"
alias pQi="paru -Qi"
alias pSi="paru -Si"
alias pSyy="paru -Syy"
alias pSyyu="paru -Syyu"
alias mci="make clean install"
alias smci="sudo make clean install"
alias wcl="wc -l"
alias lf="yazi"
alias lff="cd_with_terminal_filemanager"
alias ccal='python3 /usr/bin/calcurse-caldav; calcurse; python3 /usr/bin/calcurse-caldav'
# alias cppa="echo cd $(pwd) |xsc"
cppa() {
  if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
	  echo cd $(pwd) | wl-copy
  else
	  echo cd $(pwd) | xclip -selection clipboard
  fi
}
cppf() {
  filepath="$HOME/screenshots/$(date +%Y)/$(date +%m)"
  if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    # mkdir "$filepath"
    mkdir -p "$filepath"
    wl-paste -t image/png > "$filepath/$(date +%Y-%m-%d_%T_%s).png"
  else
    echo "not wayland!"
  fi
}

# pgms
# alias quick="cat ~/myfiles/quick"
alias qq="cat ~/static/quick"
alias bb="cat ~/static/bindings" # bring bindings
alias adg="cat ~/myfiles/agenda"
alias eadg="$EDITOR ~/myfiles/agenda"
alias eqq="$EDITOR ~/static/quick"
# alias wkk="$EDITOR /mnt/win/d/docs/pnotes/pages/index.md"
# alias vkk="$EDITOR /mnt/win/d/docs/pnotes/pages/index.md"
#alias scrc="scrcpy -S"
alias shtn="bts;uptime -p;sleep 1s;shutdown now"
alias start-rdp="sudo /etc/init.d/xrdp start"
alias stop-rdp="sudo /etc/init.d/xrdp stop"
alias setx="xrandr --output HDMI-1-1 --auto --rotate right --left-of eDP-1"
alias gqr="qrencode -s10 -o ~/outputqrcode.png"
alias vqr="sxiv ~/outputqrcode.png;rqr"
alias rqr="qrencode -o ~/outputqrcode.png \" \";clear"
alias rescan="sudo /sys/class/net/wlo1/device/rescan"
alias pmi="patch --merge -i"
alias ws="wiki-search"
alias vvk="$EDITOR ~/vimwiki/index.md;cd ~/vimwiki;git add -A;git commit -m 'automated sync from termux n9p';git pull origin main;git push origin main;echo 'wiki synced!':"
alias ttl="cat ~/vimwiki/personal/timeslots\ .;date"
alias xc="xclip -selection clipboard"
# alias ss="mkdir -p ~/myfiles/screenshots/$(date +%Y)/$(date +%B-%Y)/$(date +%F)/;maim ~/myfiles/screenshots/$(date +%Y)/$(date +%B-%Y)/$(date +%F)/hp15-screenshot-$(date +%Y-%m-%d_%H-%M-%S-%s).png"
# alias ssc="mkdir -p ~/myfiles/screenshots/$(date +%Y)/$(date +%B-%Y)/$(date +%F)/;maim -s ~/myfiles/screenshots/$(date +%Y)/$(date +%B-%Y)/$(date +%F)/hp15-screenshot-$(date +%Y-%m-%d_%H-%M-%S-%s).png"
alias ss="takeScreenshot"
alias ssc="takeCustomScreenshot"

alias sr="ffmpeg -f x11grab -i :0.0"                           # screen record without audio
alias sra="ffmpeg -f x11grab -i :0.0 -f alsa -ac 2 -i default" # screen record with audio

#imgpath="/media/win/f/linux/root/myfiles/repos/wallpapers"
# imgpath="/media/win/g/walls"
# alias chwal="img=$(ls $imgpath | shuf -n 1);wal -i $imgpath/$img"
# alias chwaln="img=$(ls $imgpath | shuf -n 1);wal -ni $imgpath/$img"
alias eemb="$EDITOR ~/blog/itzjustalan.wiki"
alias ddmb="deployMyBlog"
alias ydl="youtube-dl"
alias ydlF="youtube-dl -F"
alias ydlf="youtube-dl --external-downloader /usr/bin/axel -f"
alias ydld="youtube-dl --external-downloader /usr/bin/axel -f best"
alias ydldd="youtube-dl --write-description --skip-download --youtube-skip-dash-manifest"
alias ydla="youtube-dl --external-downloader /usr/bin/axel -f 'bestaudio[ext=m4a]'"
alias xsc="tr -d '\n' | xclip -selection clipboard"
alias avd="~/development/android-sdk/emulator/emulator -avd Pixel_4_API_30"

alias lofi="mpv https://www.youtube.com/watch?v=5qap5aO4i9A --no-video --force-seekable=yes"

alias manpup="$EDITOR ~/myfiles/repos/pup/README.md"
#alias pacman=paru

alias bashrc="$EDITOR ~/.bash_thispc"
#alias npm="pnpm"
alias runemulator="emulator -avd Pixel_4_API_30"
alias flrun="flutter run -d emulator-5554"
# alias chbr="sudo changeBrightness"
alias zf="fzf --preview \"bat --color=always --style=numbers --line-range=:500 {}\""

# fzf stuff

fcd() {
	cd "$(find -L -type d ! -path './cargo/*','./cache/','./config/' | fzf -e)"
}

op() {
	xdg-open "$(find -type f ! -path './cargo/*','./cache/','./config/' | fzf)"
}

# alias gp="find -type f ! -path './cargo/*','./cache/','./config/' | fzf | sed 's/^..//' | tr -d '\n' | xclip -selection c"

# fzf git stuff
fgc() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

sxq() {
	sx $@ | gqr
	vqr
}

csx() {
	curl "http://0x0.st/$1.txt"
}

csxx() {
	curl "http://0x0.st/$1"
}

psx() {
	curl -F"file=@$1" "http://0x0.st"
}

# get ip addr
alias getip="ip addr | grep 'scope global dynamic noprefixroute' | cut -d' ' -f6 | gqr;vqr"

cliplink="http://localhost:4321"
#cliplink="https://28ddd4611d0a.ngrok.io"
alias clip="curl $cliplink"
alias clog="curl $cliplink/log"
sclip() {
	sclip='{"url": "'$@'"}'
	curl -H "Content-Type: application/json" -d "$sclip" $cliplink
}

# /pgms

# flutter
alias f="flutter"
alias flutter="fvm flutter"
alias fbaspa='name=$(pwd | rev | cut -d '/' -f 1 | rev);echo grr \"${name}\";flutter build apk --split-per-abi;mv ./build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk ./build/app/outputs/flutter-apk/${name}.apk;echo ${name}.apk built;'
#alias fbaspa="name=${PWD##*/};echo grr ${name};flutter build apk --split-per-abi;mv ./build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk ./build/app/outputs/flutter-apk/${name}.apk;echo ${name}.apk built;"
alias fbundle="flutter build appbundle"
alias fpg="flutter clean;flutter pub get"

#alias cc="cmus ~/Music/rplay.m3u"
alias pp="cd ~/myfiles/pgms/shell-color-scripts/ && ./colorscript.sh -e 31"

# git commands
alias gs="git status"
alias ga="git add -A"
alias gm="git commit"
alias cm="git commit -m "
alias gl="git log --all --graph --decorate"
alias gb="git branch"
alias gc="git checkout"
alias gd="git diff -- ':!package-lock.json' ':!src/routeTree.gen.ts'"
alias gr="git remote"
alias grv="git remote -v"
alias gll="git log --oneline"
alias gpusha="git push --all"
alias grso="git remote show origin"
alias gpush="git push origin main"
alias gpull="git pull origin main"
alias gss="git add -A;git commit -m \"automated commit\";git pull origin;git push origin;git status"
alias gsl="git add -A;git commit -m \"automated commit\";"
alias gsm="git add -A;git commit -m "
alias gcb="git branch --color --sort=committerdate | sk --ansi -p \"branch: \" --preview \"git diff --color {-1}\" --preview-window right | xargs git checkout"

# git completions fix
__git_complete gs _git_status &>/dev/null;
__git_complete ga _git_add &>/dev/null;
__git_complete gm _git_commit &>/dev/null;
__git_complete gb _git_branch &>/dev/null;
__git_complete gc _git_checkout &>/dev/null;
__git_complete gd _git_diff &>/dev/null;
__git_complete gr _git_remote &>/dev/null;

# docker commands
# alias docker="sudo docker"

# node js
# alias nrd="npm run dev"
alias nrs="npm run start"

# WSl drives
alias c:="cd /mnt/win/c"
alias d:="cd /mnt/win/d"
alias e:="cd /mnt/win/e"
alias f:="cd /mnt/win/f"
alias g:="cd /mnt/win/g"

# tmux
# tmux ls
# tmux kill-server
# alias tks="tmux kill-session -t"
alias tmuxResizeP="tmux resizep -t 0 -x 70%"

# work spaces
alias wp="cd ~/wp/"
alias wd="cd /mnt/c/Users/alanj/Desktop/"
alias my="cd ~/myfiles/"
alias myg="cd ~/myfiles/pgms/"
# alias msc="cd ~/.local/bin/myscripts/"
alias msc="cd ~/.sysman"
alias gdb="cd ~/work/rkd/"
# alias gdc="cd ~/work/deltra/flutter/customer_app2/"
# alias gdd="cd ~/work/deltra/flutter/delivery_app2/"
#alias gdi="cd ~/work/indic_law/"
#alias gdm="cd ~/work/milibus/"
# alias gds="cd ~/work/deltra/sales_app2/"
# alias gdt="cd ~/myfiles/repos/.dotfiles/"
# alias gdwsalba="cd ~/work/backend/;tmux new-session \; split-window -h \;"

alias dpsa="docker ps -a"
alias dspa-SURE-KILL-ALL-="echo try dspa-SURE-KILL-ALL-y"
alias dspa-SURE-KILL-ALL-y="docker system prune -af"
alias postgresContainerStart="docker start postgresdb"
alias postgresContainerCreate="docker run --name postgresdb -p 5432:5432 -e POSTGRES_PASSWORD=test -d postgres"
alias nrt="npm run test"
alias nrb="npm run build"
alias nrs="npm run start"
alias nrl="npm run local"
alias nrf="npm run format"
nrd() { # shim lol
	if [ -f "package.json" ]; then
		npm run dev
	elif [[ -f "Makefile" ]]; then
		make
	elif [[ -f "nodemon.json" ]]; then
    nodemon
	fi
}
npmScripts() {
  jq '.scripts' package.json
}

# gdbd(){
#   initialDir=$(pwd);
#   gdb;
#   code ./app-admin-api;
#   code ./app-admin-ui;
#   gdb;
#   ./deltra-backend-tmux-setup.sh
#
#   cd $initialDir;
# }

# gdp() {
#
#   initialDir=$(pwd);
#   gdd;
#   pwd;
#   git add -A;
#   git commit -m "automated commit";
#   git push origin main;
#   if [ "$1" == "-b" ]; then fbaspa fi;
#
#   gds;
#   pwd;
#   git add -A;
#   git commit -m "automated commit";
#   git push origin main;
#   if [ "$1" == "-b" ]; then fbaspa fi;
#
#   gdc;
#   pwd;
#   git add -A;
#   git commit -m "automated commit";
#   git push origin main;
#   if [ "$1" == "-b" ]; then fbaspa fi;
#
#   cd "$initialDir";
# }

#alias gss="cd ~/pgms/side/"

alias gdr="cd ~/pgms/springboot/rocket-science/"

#alias logout="killall xinit"
alias kl="ps -a | grep xinit" # kill list

# rm -rf safety

tm() {
	echo "all -> $@"
	if [ "$1" = "-rf" ]; then
		if [ "$2" = "/" ]; then
			echo pottan
		elif [ "$2" = "~" ]; then
			echo pottan
		elif [ "$2" = "j" ]; then
			echo pottan rm safety j is locked consult the alias
		elif [ "$2" = "~/" ]; then
			echo pottan
		elif [ "$2" = "/home/alanj" ]; then
			echo pottan
		elif [ "$2" = "/home/alanj/" ]; then
			echo pottan
		else
			rm $@
		fi
	else
		rm $@
	fi
}

mkcd() {
	mkdir -p -- "$1" &&
		cd -P -- "$1"
}
mkcp() {
	mkdir -p -- "$2" &&
		cp "$1" "$2"
}
mkcdird() {
	mkdir "$(date +%F)" &&
		cd "$(date +%F)"
}

umm() {
	LC_TEXT="\n\n$(date +%Y-%B-%d\ [%H:%M]..)\n$@"
	echo -en "$LC_TEXT" >>~/static/umms
}

alias umms="less ~/static/umms"

gg() {
  flags="--new-tab"
  browser="firefox"
  engine="https://www.google.com/search?q="
  if [[ "$1" == "-p" ]]; then
    flags="$flags --private-window"
    shift 1
  fi
  q=$(echo "$@" | tr " " "+")
  # echo "$browser $flags $engine$q";
  eval "$browser $flags $engine$q";
}

gp() {
  gg -p $@
}

# sys functions
[[ -f ~/.local/bin/sys/systemsettings ]] && . ~/.local/bin/sys/systemsettings

open() {
	sxiv $@
}

#./slowcat.pl $(/usr/bin/ls | grep .vt | shuf -n 1)

#colorscript random
#cd

#  timer () {
#    while :; do notify-send "its time";date;echo huh; sleep $(($_))s; done
#  }

timer() {
	while :; do
		date
		notify-send "timer for $1"
		sleep $1
		#sleep $((1))m
	done
}

_alarm() {
	(\speaker-test --frequency $1 --test sine) &
	pid=$!
	\sleep 0.${2}s
	\kill -9 $pid
}

# usable DEL KEY in st
# use tput rmkx to quit application mode
# as this might have isssues with some
# new cli applications
#tput smkx

# lf icons
if [ -f ~/.config/lf/icons ]; then
	. ~/.config/lf/icons
fi

# cd to last dir on lf exit
cd_with_terminal_filemanager() {
	# tmp="$(mktemp)"
	# lf -last-dir-path="$tmp" "$@"
	# cd $(cat $tmp)
  local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# cdb wrapper
# cdb () {
#   cd $(pgm-name $@)
# }

# deploy blog
deployMyBlog() {
	rm -rf ~/vimwiki_html/*
	rm -rf ~/www/myblog/public/*
	vim -c :VimwikiAll2HTML -c :q -c :q ~/blog/itzjustalan.wiki
	cp ~/vimwiki_html/* ~/www/myblog/public/
	cp ~/www/myblog/symlinks/actualLinks/* ~/www/myblog/public/
	cd ~/www/myblog/
	# manual deploying is no longer needed as it
	# will be taken care of by the github workflow
	#firebase deploy;
	git add -A
	git commit -m "$(date +%F) automated commit"
	git push origin main
	cd -
	#firefox https://itzjustalan-blog.web.app
	notify-send "MyBlog deployed!"
}

# deploy itzjustalan blog
deployITZblog() {
	LC_DEF_HTM_DIR="~/vimwiki_html"
	LC_BLG_DIR="~/pgms/itzjustalan.in/blog"
	LC_EXP_DIR="~/pgms/itzjustalan.in/blog2html"
	rm -rf "$LC_DEF_HTM_DIR/*"
	vim -c :VimwikiAll2HTML -c :q -c :q $LC_BLG_DIR/itzjustalan.wiki
	cp -fr "$LC_DEF_HTM_DIR/*" "$LC_EXP_DIR/"
	#firefox https://itzjustalan-blog.web.app
	notify-send "MyBlog deployed!"
}

# screenshots with scrot
takeScreenshot() {
	screenshotDIR="$HOME/myfiles/screenshots/$(date +%Y)/$(date +%B-%Y)/$(date +%F)"
	mkdir -p "$screenshotDIR"
	maim "$screenshotDIR/hp15-screenshot-$(date +%Y-%m-%d_%H-%M-%S-%s).png"

	# screenshotDIR="~/myfiles/screenshots/$(date +%Y)/$(date +%B-%Y)/$(date +%F)";
	# mkdir -p $screenshotDIR;
	# scrot -e 'mv $f ~/myfiles/screenshots/scrotTEMP;echo $f';

	#/bin/ls ~/myfiles/screenshots/scrotTEMP/
	#screenshotFILE=$(/bin/ls ~/myfiles/screenshots/scrotTEMP/)
	#mv ~/myfiles/screenshots/scrotTEMP/$screenshotFILE $screenshotDIR/$(date +%Y-%m-%d-%T).png
	####mv ~/myfiles/screenshots/scrotTEMP/* $screenshotDIR/;
	#st scrot -sf ~/myfiles/screenshots/$(date +%Y)/$(date +%B-%Y)/$(date +%F)/$(date +%Y-%m-%d-%T).png"
}

takeCustomScreenshot() {
	screenshotDIR="$HOME/myfiles/screenshots/$(date +%Y)/$(date +%B-%Y)/$(date +%F)"
	mkdir -p "$screenshotDIR"
	maim -s "$screenshotDIR/hp15-screenshot-$(date +%Y-%m-%d_%H-%M-%S-%s).png"

	# screenshotDIR="~/myfiles/screenshots/$(date +%Y)/$(date +%B-%Y)/$(date +%F)";
	# mkdir -p $screenshotDIR;
	# scrot -sfe 'mv $f ~/myfiles/screenshots/scrotTEMP;echo $f';

	#/bin/ls ~/myfiles/screenshots/scrotTEMP/
	#screenshotFILE=$(/bin/ls ~/myfiles/screenshots/scrotTEMP/)
	#mv ~/myfiles/screenshots/scrotTEMP/$screenshotFILE $screenshotDIR/$(date +%Y-%m-%d-%T).png
	####mv ~/myfiles/screenshots/scrotTEMP/* $screenshotDIR/;
	#st scrot -sf ~/myfiles/screenshots/$(date +%Y)/$(date +%B-%Y)/$(date +%F)/$(date +%Y-%m-%d-%T).png"
}

watchCurl() {
   # watch -n 2 "curl -g -w '\n%{http_code}\n' '"$url"' -H 'Authorization: Bearer $pa'"
    watch -n "$1" "curl -g -w '\n%{http_code}\n' '$2' -H '$3'"
}

# Didable less histry file
export LESSHISTORYFILE=-

#fortune
#xrandr --outputHDMI-1-1 --auto --rotate right --left-of eDP-1

#PS1="\u@\H \n"

# powerline
#powerline-daemon -q
#POWERLINE_BASH_CONTINUATION=1
#POWERLINE_BASH_SELECT=1
#. /usr/share/powerline/bindings/bash/powerline.sh

# starship
#eval "$(starship init bash)"

#source ~/.config/bash/.bash-powerline.sh

# TO RUN A FILE IF IT EXISTS LIKE THIS
# -
#if [ -f /path/to/file ]; then
#  . /path/to/file
#fi
# -
# JUST DO -
# -
#test -f /path/to/file && . $_
# -
# THANKYOU

[[ -f ~/.bashenvs ]] && . ~/.bashenvs
[[ -f ~/.bash_completions ]] && . ~/.bash_completions

# source configs specific to this pc
if [ -f ~/.bash_thispc ]; then
    . ~/.bash_thispc
fi

#the end tadaaa
