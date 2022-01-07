#neofetch	#takes time to load try peafetch or shell-color-scripts instead #neofetch --ascii "$(fortune | cowsay -f bspa
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

#export PATH=$PATH:/path/to/dir1		  #or
#export PATH=$PATH:/path/to/dir1:/path/to/dir2


export PATH=$PATH:~/.local/bin/
export PATH=$PATH:~/.local/bin/sys/
export PATH=$PATH:~/.local/bin/sys/buttons/
export PATH=$PATH:~/.local/bin/perc/
export PATH=$PATH:~/.local/bin/myscripts/
export PATH=$PATH:
export PATH=$PATH:
export PATH=$PATH:~/.cargo/bin/
export PATH=$PATH:~/.deno/bin/
export PATH=$PATH:
export PATH=$PATH:
export PATH=$PATH:
export PATH=$PATH:

# shell completions
source <(vr completions bash)   # velociraptor (deno)
source /usr/share/bash-completion/completions/git   # git



#aliases
alias alias_name="actual_alias"

alias bbash="source ~/.bashrc"

alias h="tac ~/.bash_history | dmenu | tr -d '\n' | xclip -selection c"
alias c=cat
alias cp="cp -ir"                         # confirm before overwriting something
alias cpy="cp -r"
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias more=less
alias sv="sudo vim"
alias nv=nvim
#alias v=nvim
alias m=mpv
alias z="zathura"
#alias rm="rm -rfi"
alias ll='lsd -lah --group-dirs first --color=auto'
alias jj="ll"
alias kk="ll"
alias cdd="cd .."
alias cdc="cd -"
alias diff="diff --color=auto"
alias mkdir="mkdir -p"
#alias chbr="sudo changeBrightness"
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
alias pSi="paru -Si"
alias pSyy="paru -Syy"
alias pSyyu="paru -Syyu"
alias mci="make clean install"
alias smci="sudo make clean install"
alias wcl="wc -l"
alias lff="lfcd"
alias ccal='python3 /usr/bin/calcurse-caldav; calcurse; python3 /usr/bin/calcurse-caldav'

# pgms
alias quick="cat ~/myfiles/quick"
alias qq="cat ~/static/quick"
alias bb="cat ~/static/bindings"           # bring bindings
alias adg="cat ~/myfiles/agenda"
alias eadg="$EDITOR ~/myfiles/agenda"
alias eqq="$EDITOR ~/static/quick"
#alias scrc="scrcpy -S"
alias shtn="uptime -p;sleep 1s;shutdown now"
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
alias ss="mkdir -p ~/myfiles/screenshots/$(date +%Y)/$(date +%B-%Y)/$(date +%F)/;maim ~/myfiles/screenshots/$(date +%Y)/$(date +%B-%Y)/$(date +%F)/hp15-screenshot-$(date +%Y-%m-%d_%H-%M-%S).png"
alias ssc="mkdir -p ~/myfiles/screenshots/$(date +%Y)/$(date +%B-%Y)/$(date +%F)/;maim -s ~/myfiles/screenshots/$(date +%Y)/$(date +%B-%Y)/$(date +%F)/hp15-screenshot-$(date +%Y-%m-%d_%H-%M-%S).png"
#alias ss=takeScreenshot
#alias ssc=takeCustomScreenshot
alias sr="ffmpeg -f x11grab -i :0.0"
alias sra="ffmpeg -f x11grab -i :0.0 -f alsa -ac 2 -i default"

imgpath="/media/win/f/linux/root/myfiles/repos/wallpapers"
alias chwal="img=$(ls $imgpath | shuf -n 1);wal -i $imgpath/$img"
alias chwaln="img=$(ls $imgpath | shuf -n 1);wal -ni $imgpath/$img"
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

# fzf stuff

fcd() {
  cd "$(find -L -type d ! -path './cargo/*','./cache/','./config/' | fzf -e)"
}

op() {
  xdg-open "$(find -type f ! -path './cargo/*','./cache/','./config/' | fzf)"
}

alias gp="find -type f ! -path './cargo/*','./cache/','./config/' | fzf | sed 's/^..//' | tr -d '\n' | xclip -selection c"

sxq(){
  sx $@ | gqr;vqr
}

csx() {
  curl "http://0x0.st/$1.txt";
}

csxx() {
  curl "http://0x0.st/$1";
}

psx(){
  curl -F"file=@$1" "http://0x0.st"
}


# get ip addr
alias getip="ip addr | grep 'scope global dynamic noprefixroute' | cut -d' ' -f6 | gqr;vqr"


cliplink="http://localhost:4321"
#cliplink="https://28ddd4611d0a.ngrok.io"
alias clip="curl $cliplink"
alias clog="curl $cliplink/log"
sclip(){
  sclip='{"url": "'$@'"}'
  curl -H "Content-Type: application/json" -d "$sclip" $cliplink
}

cdbb(){
  echo "$@"
  tmpchk=$(echo "$@" | grep " -l ");
  if [ -z "$tmpchk" ]; then
    tmpdir=$(~/.local/noexec/cdb "$@")
    echo "$tmpdir"
    cd "$tmpdir"
  else
    ~/.local/noexec/cdb "$@"
  fi;
}





# /pgms

# flutter
alias f="flutter"
alias flutter="fvm flutter"
alias fbaspa='name=$(pwd | rev | cut -d '/' -f 1 | rev);echo grr \"${name}\";flutter build apk --split-per-abi;mv ./build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk ./build/app/outputs/flutter-apk/${name}.apk;echo ${name}.apk built;'
#alias fbaspa="name=${PWD##*/};echo grr ${name};flutter build apk --split-per-abi;mv ./build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk ./build/app/outputs/flutter-apk/${name}.apk;echo ${name}.apk built;"
alias fbundle="flutter build appbundle"
alias fpg="fvm flutter clean;fvm flutter pub get"

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
alias gd="git diff"
alias gr="git remote"
alias grv="git remote -v"
alias grso="git remote show origin"
alias gpush="git push origin main"
alias gpull="git pull origin main"
alias gss="git add -A;git commit -m \"automated commit\";git pull origin;git push origin;git status"
alias gsn="git add -A;git commit -m \"automated commit\";"
alias gsm="git add -A;git commit -m ;"

# git completions fix
__git_complete gs _git_status
__git_complete ga _git_add
__git_complete gm _git_commit
__git_complete gb _git_branch
__git_complete gc _git_checkout
__git_complete gd _git_diff
__git_complete gr _git_remote


# docker commands
alias docker="sudo docker"

# node js
alias nrd="npm run dev"
alias nrs="npm run start"

# WSl drives
alias c:="cd /media/win/c"
alias d:="cd /media/win/d"
alias e:="cd /media/win/e"
alias f:="cd /media/win/f"
alias g:="cd /media/win/g"

# tmux
alias tks="tmux kill-server"

# work spaces
alias wp="cd ~/wp/"
alias wd="cd /mnt/c/Users/alanj/Desktop/"
alias my="cd ~/myfiles/"
alias myg="cd ~/myfiles/pgms/"
#alias msc="cd ~/.local/bin/myscripts/"
alias msc="cd ~/.sysman"
alias gdb="cd ~/work/backend"
alias gdc="cd ~/work/almas/customer_app2/"
alias gdd="cd ~/work/almas/delivery_app2/"
alias gdi="cd ~/work/indic_law/"
alias gdm="cd ~/work/milibus/"
alias gds="cd ~/work/almas/sales_app2/"
alias gdt="cd ~/myfiles/repos/.dotfiles/"
alias gdwsalba="cd ~/work/backend/;tmux new-session \; split-window -h \;"

gdbd(){
  initialDir=$(pwd);
  gdb;
  code ./app-admin-api;
  code ./app-admin-ui;
  gdb;
  ./deltra-backend-tmux-setup.sh

  cd $initialDir;
}

gdp(){
  initialDir=$(pwd);
  gdd;
  pwd;
  git add -A;
  git commit -m "automated commit";
  git push origin main;
  if [ "$1" == "-b" ]; then fbaspa fi;

  gds;
  pwd;
  git add -A;
  git commit -m "automated commit";
  git push origin main;
  if [ "$1" == "-b" ]; then fbaspa fi;

  gdc;
  pwd;
  git add -A;
  git commit -m "automated commit";
  git push origin main;
  if [ "$1" == "-b" ]; then fbaspa fi;

  cd $initialDir;
}

#alias gss="cd ~/pgms/side/"


alias gdr="cd ~/pgms/springboot/rocket-science/"

#alias logout="killall xinit"
alias kl="ps -a | grep xinit"           # kill list

# rm -rf safety

tm() {
  echo "all -> $@"
  if [ "$1" = "-rf" ];then
    if [ "$2" = "/" ];then
      echo pottan
    elif [ "$2" = "~" ];then
      echo pottan
    elif [ "$2" = "j" ];then
      echo pottan rm safety j is locked consult the alias
    elif [ "$2" = "~/" ];then
      echo pottan
    elif [ "$2" = "/home/alanj" ];then
      echo pottan
    elif [ "$2" = "/home/alanj/" ];then
      echo pottan
    else
      rm $@
    fi
  else
    rm $@
  fi
}

mkcdir(){
		mkdir -p -- "$1" &&
		cd -P -- "$1"
}
mkcdird(){
  mkdir "$(date +%F)" &&
		cd "$(date +%F)"
}

umm() {
  LC_TEXT="\n\n$(date +%Y-%B-%d\ [%H:%M]..)\n$@"
  echo -en "$LC_TEXT" >> ~/static/umms
}

alias umms="less ~/static/umms"

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


timer () {
  while :
  do
    date
    notify-send "timer for $1";
    sleep $1
    #sleep $((1))m
  done
}



_alarm() {
        ( \speaker-test --frequency $1 --test sine )&
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
lfcd () {
tmp="$(mktemp)"
lf -last-dir-path="$tmp" "$@"
cd $(cat $tmp)
#if [ -f "$tmp" ]; then
# dir="$(cat "$tmp")"
# rm -f "$tmp"
#  if [ -d "$dir" ]; then
#       if [ "$dir" != "$(pwd)" ]; then
#            cd "$dir"
#         fi
#      fi
#   fi
}

# cdb wrapper
cdb () {
  cd $(cdb $@)
}



# deploy blog
deployMyBlog(){
    rm -rf ~/vimwiki_html/*;
    rm -rf ~/www/myblog/public/*;
    vim -c :VimwikiAll2HTML -c :q -c :q ~/blog/itzjustalan.wiki;
    cp ~/vimwiki_html/* ~/www/myblog/public/;
    cp ~/www/myblog/symlinks/actualLinks/* ~/www/myblog/public/;
    cd ~/www/myblog/;
    # manual deploying is no longer needed as it
    # will be taken care of by the github workflow
    #firebase deploy;
    git add -A;
    git commit -m "$(date +%F) automated commit";
    git push origin main;
    cd -;
    #firefox https://itzjustalan-blog.web.app
    notify-send "MyBlog deployed!"
}


# deploy itzjustalan blog
deployITZblog(){
  LC_DEF_HTM_DIR="~/vimwiki_html"
  LC_BLG_DIR="~/pgms/itzjustalan.in/blog"
  LC_EXP_DIR="~/pgms/itzjustalan.in/blog2html"
    rm -rf "$LC_DEF_HTM_DIR/*";
    vim -c :VimwikiAll2HTML -c :q -c :q $LC_BLG_DIR/itzjustalan.wiki;
    cp -fr "$LC_DEF_HTM_DIR/*" "$LC_EXP_DIR/";
    #firefox https://itzjustalan-blog.web.app
    notify-send "MyBlog deployed!"
}











# screenshots with scrot
takeScreenshot(){
    screenshotDIR="~/myfiles/screenshots/$(date +%Y)/$(date +%B-%Y)/$(date +%F)";
    mkdir -p $screenshotDIR;
    scrot -e 'mv $f ~/myfiles/screenshots/scrotTEMP;echo $f';
    #/bin/ls ~/myfiles/screenshots/scrotTEMP/
    #screenshotFILE=$(/bin/ls ~/myfiles/screenshots/scrotTEMP/)
    #mv ~/myfiles/screenshots/scrotTEMP/$screenshotFILE $screenshotDIR/$(date +%Y-%m-%d-%T).png
    ####mv ~/myfiles/screenshots/scrotTEMP/* $screenshotDIR/;
    #st scrot -sf ~/myfiles/screenshots/$(date +%Y)/$(date +%B-%Y)/$(date +%F)/$(date +%Y-%m-%d-%T).png"
}

takeCustomScreenshot(){
    screenshotDIR="~/myfiles/screenshots/$(date +%Y)/$(date +%B-%Y)/$(date +%F)";
    mkdir -p $screenshotDIR;
    scrot -sfe 'mv $f ~/myfiles/screenshots/scrotTEMP;echo $f';
    #/bin/ls ~/myfiles/screenshots/scrotTEMP/
    #screenshotFILE=$(/bin/ls ~/myfiles/screenshots/scrotTEMP/)
    #mv ~/myfiles/screenshots/scrotTEMP/$screenshotFILE $screenshotDIR/$(date +%Y-%m-%d-%T).png
    ####mv ~/myfiles/screenshots/scrotTEMP/* $screenshotDIR/;
    #st scrot -sf ~/myfiles/screenshots/$(date +%Y)/$(date +%B-%Y)/$(date +%F)/$(date +%Y-%m-%d-%T).png"
}


# export $PATH(s)
#export PATH=$PATH:~/development/flutter/bin/
#export PATH=$PATH:~/development/gradle/gradle-6.7.1/bin/
#export ANDROID_SDK_ROOT=~/development/android-sdk
#export ANDROID_HOME=$ANDROID_SDK_ROOT
#export PATH=$PATH:$ANDROID_HOME/cmdline-tools/tools

# export $PATH(s)
export PATH=$PATH:~/development/flutter/bin/
export PATH=$PATH:~/development/gradle/gradle-6.7.1/bin/
export ANDROID_SDK_ROOT=~/development/gui-studio
export ANDROID_HOME=$ANDROID_SDK_ROOT
export PATH=$PATH:$ANDROID_HOME
export CHROME_EXECUTABLE="/usr/bin/google-chrome-stable"

export PATH="$PATH":"~/development/flutter/.pub-cache/bin"


export PATH=$PATH:~/myfiles/pgms/android-studio/bin





# springboot
export PATH=$PATH:~/development/springboot/bin/



# other work specific envs
[[ -f ~/.bashenvs ]] && . ~/.bashenvs






# Other XDG paths
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}

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
eval "$(starship init bash)"

#source ~/.config/bash/.bash-powerline.sh

# dracula FZF
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'



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

#the end tadaaa
