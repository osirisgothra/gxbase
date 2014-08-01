echo -ne "$(abscol 33)Updating logs..."

#record permanant history file and track logout time+date
cat ~/.bash_history >> ~/.gxbase_history
echo -ne "$USER $(id -u):$(id -g) Logout on $HOSTNAME in $(tty)" >> ~/.gxbase_logouts
date >> ~/.gxbase_logouts

echo -ne 'done'



