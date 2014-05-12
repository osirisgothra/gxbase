set -- `getopt -l message:,farinite,beh:,feh: -o d:sr:f -- "$@"; exit $?`
echo $?
set -- -m "message" -d ke
RESULTS=`getopt -l message:,farinite,beh:,feh: -o d:sr:f -- "$@"; exit $?`
echo $?
echo $RESULTS
set -- -m=message
getopt -l message:,farinite,beh:,feh: -o d:sr:f -- "$@"
set -- -m msg -h giv
getopt -l message:,farinite,beh:,feh: -o d:sr:f -- "$@"
getopt -l message:,farinite,beh:,feh: -o d:sr:fm:h: -- "$@"
alias g='getopt -l message:,farinite,beh:,feh: -o d:sr:fm:h: -- "$@"'
alias gg='set -- '
gg --message farmerjoesmessage --beh beggermessage -r 12 -h 1540 -d 20
g
%
man builtins
man bash
case d in d) echo yes ;& n) echo no;; esac
case d in d) echo yes ;& n) echo no ;; d) echo again;; esac
case d in d) echo yes ;& n) echo no ;; X) echo not-even-related;; d) echo again;; esac
case d in d) echo yes ;& n) echo no ;;& X) echo not-even-related;; d) echo again;; esac
case d in d) echo yes ;& n) echo no ;& X) echo not-even-related;; d) echo again;; esac
case d in d) echo yes ;& n) echo no ;& X) echo not-even-related;; X) echo another-not-related-one;& d) echo again;; esac
case d in d) echo yes ;& n) echo no ;& X) echo not-even-related;;& X) echo another-not-related-one;& d) echo again;; esac
case d in d) echo yes ;& n) echo no ;;& X) echo not-even-related;;& X) echo another-not-related-one;& d) echo again;; esac
case d in d) echo yes ;& n) echo no ;; X) echo not-even-related;;& X) echo another-not-related-one;& d) echo again;; esac
case d in z) echo yes ;& n) echo no ;; X) echo not-even-related;;& X) echo another-not-related-one;& d) echo again;; esac
case d in d) echo yes ;& n) echo no ;; X) echo not-even-related;;& X) echo another-not-related-one;& d) echo again;; esac
%
clear
source test
source temp
vim temp
source temp
vim bash
man bash
%
vim temp
./temp
source temp
vim temp
source temp
mkdir delete-me
cd delete-me
makebusyboxlinkshere
ls
cd..
cd ..
vim temp; source temp; cd delete-me
set -- YNC Y
echo ${#1}
echo ${#2}
%
set key
echo ${1^^}SET
%
echo ${1^^}SET
${1^^}SET+=1
eval ${1^^}SET+=1
echo $KEYSET
eval ${1^^}SET+=1
echo $KEYSET
%
case 4 in 1) echo one;; 2) echo two;; 3) echo three;; 4) echo four;; esac
case 4 in 1|4) echo one;; 2) echo two;; 3) echo three;; 4) echo four;; esac
case 4 in 1|4) echo one;;& 2) echo two;; 3) echo three;; 4) echo four;; esac
%
set 1223
echo ${1: 0:64}
echo ${1: 0:64}ab;e
echo ${1: 0:64}ab
echo ${1: -1:64}ab
echo ${1: -1:1}ab
echo ${1: -1:2}ab
echo ${1: -2:2}ab
echo ${1: -2:-2}ab
echo ${1: -2: -2}ab
echo ${1: -2: -3}ab
echo ${1: 0: -3}ab
echo ${1: 0: -4}ab
echo ${1: 1: -4}ab
echo ${1: -1: -4}ab
echo ${1: -1: 3}ab
echo ${1: -3: 3}ab
echo ${1: -4: 4}ab
echo ${1: -64: 64}ab
echo ${1: 0:64}ab
set -- ""
echo K=${1: 0:64}ab
echo K="${1: 0:64}"
K="${1: 0:64}"
if [[ -z $K ]]; then echo yes; fi
%
ls
exit
dmenu
clear
ls
chromium-browser --private-window
bg %
clear
alias s='stop %1'
alias g='bg %1'
s
jobs
stop %1
stop %
stop 1
stop &
jobs
stop %1
stop %2
clear
jobs
stop --help
help stop
help
help fg
fg %
alias stop='fg % '
stop
alias s=stop
s
bind '"s": "stop "'
bind '"g": "g"'
clear
jobs
bind '"s": "self-insert"'
bind -r '"s"'
ind -r s
bind -r s
bind -r g
bind "'s': 'self-insert'"
bind "s: self-insert"
bind "': self-insert"
bind "g: self-insert"
bind
bind -f
bind -p
bind -l
clear
ls
jobs
disown %
clear
exit
q
ls
exit
baudline
/ntfs/apps/baudline/baudline
/ntfs/apps/baudline/baudlinec
clear
cp /ntfs/apps/baudline/baudline/*.so* /usr/lib
cp /ntfs/apps/baudline/baudline/*so* /usr/lib
clear
cp /ntfs/apps/baudline/*so* /usr/lib
sudo cp /ntfs/apps/baudline/*so* /usr/lib
clear
sudo cp /ntfs/apps/baudline/*.so /usr/lib
ls /ntfs/apps/baudline
rekonq
killall chromium-browser
killall appor
killall apport
netsurf --help
ps
ps a
echo "[0;0H
"
kill -SIGCONT 28670
kill -SIGCONT 28666
kill -l
echo "[0;0H
"
kill -SIGCONT 28670
kill -SIGCONT 28671
kill -SIGCONT 28672
kill -SIGCONT 28673
kill -SIGCONT 28674
kill -SIGCONT 28675
kill -SIGCONT 28676
kill -SIGCONT 28706
kill -SIGCONT 28711
kill -SIGCONT 28735
kill -SIGCONT 28749
kill -SIGCONT 28856
kill -SIGCONT 28858
kill -SIGCONT 29006
kill -SIGCONT 29040
kill -SIGCONT 29006
~~
clear
PS1='[0;47;30m'$PS1'[0;47;30m:'
clear
PS1='[0;47;30m'$PS1'[0;247;30m:'
clear
PS1='[0;47;30m'$PS1'[0;247;30m:'
clear
PS1='[0;47;30m'$PS1'[0;247;30m:'
c
ls
clear
PS1='[0;47;30m'$PS1'[0;47;30m:'
clear
PS1='[0;49;128;30m'$PS1'[0;47;30m:'
PS1='[0;49;128;30m\u@\h \w\$ [0;47;30m:'
PS1='[0;49;228;30m\u@\h \w\$ [0;47;30m:'
echo $TERM
PS1='[0;48;228;30m\u@\h \w\$ [0;47;30m:'
PS1='[0;1;49;228;30m\u@\h \w\$ [0;47;30m:'
PS1='[0;1;49;128;30m\u@\h \w\$ [0;47;30m:'
PS1='[49;128m[1;30m\u@\h \w\$ [0;47;30m:'
locate ansicolor
cd /gxbase/
ls
cd /src/gxbase
cd previous
ls
clear
cd doc
ls
cd docs
clear
ls
cd text
clear
ls
cd ..
ls
clear
ls
cd compatk/
ls
cd ..
ls
clear
ls
cat f.dialog-full.txt 
clear
ls
f.dialog.txt
cat f.dialog.txt
clear
ls
cat f.gxbase.txt 
clear
ls
cat README
cat xmlstarlet.hlp 
clear
ls
cd ..
ls
clear
ls -C
cd alias.d
ls
cd dynamic/
ls
clear
ls
clear
ls -C
cat ansicodes.data
clear
cat colortable256.data 
clear
PS1='[0;49;128;30m'$PS1'[0;48;5;250m:'
clear
PS1='[0;49;128;30m'$PS1'[0;48;5;251m:'
clear
PS1='[0;49;128;30m'$PS1'[0;48;5;249m:'
clear
PS1='[0;49;128;30m'$PS1'[0;48;5;250m:'
clear
PS1='\u \h \w \# \$[0;48;5;250m'
clear
ls
clear
unalias ls
ls
clear
alias ls='ls -l | column'
ls
cd /
ls
cd /usr
ls
cd /usr/bin
ls
ls -C
ls -c1
ls -c2
ls -s-
ls -s,
ls -s.
ls -s3
ls -sr
ls -s r
ls -s J
ls -s -
ls -s-
ls -sx
ls
mc
alsamixer
c
mc
firefox --private-window
man firefox
%
firefox -private& disown%
disown %
clear
bash
killall netsurf
killall rekonq
killall konqueror
killall chromium-browser
ps -e avfx
killall chromium-browser
sudo killall chromium-browser
htop
for ((u=28666;u<28899;u++)); do sudo kill -SIGKILL $u; done
htop
killall xterm
killall krunner
killall konsole
killall st
./411toppm
[20~[21~
konqueror
ls
ftp
links2
ls
gzip -xvjf firefox-25.0.1_x64.tar.bz2 
gzip -xvjf firefox-25.0.1_x64.tar.bz2
tar -xvjf firefox-25.0.1_x64.tar.bz2
vim `locate *.cpp -l1`
st --help
set -o interactive-comments                   set +o keyword
set -o monitor                                set +o noclobber
set +o noexec                                 set +o noglob
set +o nolog                                  set +o notify
set +o nounset                                set +o onecmd
set +o physical                               set +o pipefail
set +o posix                                  set +o privileged
set +o verbose                                set +o vi
set +o xtrace
xset s off
xset s noblank
xset -dpms
xset -acpi
clear
kcmshell4 power
kcmshell4 kpower
kcmshell4 kpowerd
kcmshell4 powersettings
kcmshell4 --list
kcmshell4 powerdevilglobalconfig
dwm
startdwm
vlc
startx vlc
startx "/usr/bin/vlc"
startx "/usr/bin/vlc-wrapper"
xinit -- vlc
xinit -- /usr/bin/vlc
xinit /usr/bin/vlc -- :4
ls
vlc
unalias vlc
vlc
unset -f vlc
vlc
vlcst
vlc
locate /vlc
locate *vlc
/usr/bin/cvlc
cat /usr/bin/cvlc
cat /usr/bin/nvlc
cat /usr/bin/qvlc
cat /usr/bin/svlc
cat /usr/lib/vlc
cat /usr/lib/mime/packages/vlc
nvlc
ps 
ps -e
ps a
whereis vlc
ls ~/bin/v*
cat ~/bin/v*
cat ~/bin/v* |more
clear
ls
%
locate *.avi
locate *.flv
locate *.tmp
locate watch*.*
locate Watch*.*
locate Watch*
locate Watch
locate *.fla
locate *.mp4
locate *.mp4 |less
locate *.mpg |less
cd ~/Documents/
ls
clear
cd /
ls
date +"%f"
date +"%g"
date +"%e"
date +"%d"
date +"%G"
date +"%h"
date +"%i"
date +"%c"
eb
date
clear
ls
cd Videos
ls
cd ~
cd Videos
ls
shopt
shopt; shopt -o
shopt; shopt -o |columns
{ shopt; shopt -o ; }|columns
{ shopt -s ; shopt -so ; }|columns
{ shopt -i ; shopt -so ; }|columns
{ shopt -c ; shopt -so ; }|columns
{ shopt -p ; shopt -so ; }|columns
{ shopt -p ; shopt -po ; }|columns
{ shopt -p ; shopt -po ; }|columns  >> ~/.bashrc
alias
alias rb
alias r*
alias rgx
rb
killall Xorg
jobs
clear
exit
set -o interactive-comments                   set +o keyword
set -o monitor                                set +o noclobber
set +o noexec                                 set +o noglob
set +o nolog                                  set +o notify
set +o nounset                                set +o onecmd
set +o physical                               set +o pipefail
set +o posix                                  set +o privileged
set +o verbose                                set +o vi
set +o xtrace
startlxde
killall Xorg
startx
startx chromium-browser
clear
ls
ls -l
clear
ls
rm *b2z
rm *bz2
unset IFS
ckear
clear
ls
startkde
jobs
exit
set -o interactive-comments                   set +o keyword
set -o monitor                                set +o noclobber
set +o noexec                                 set +o noglob
set +o nolog                                  set +o notify
set +o nounset                                set +o onecmd
set +o physical                               set +o pipefail
set +o posix                                  set +o privileged
set +o verbose                                set +o vi
set +o xtrace
jobs
exit
complete
source /etc/bash_completion
complete
clear
ls
shopt
exit
source /etc/bash_completion
( shopt -p; shopt -po ) >> opts2
exit
