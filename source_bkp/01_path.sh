paths=(
  ~/.local/bin
  ~/.dotfiles/bin
  /usr/local/bin
  /usr/local/sbin
  /usr/bin
  /usr/sbin
  /sbin
  /bin
  /usr/games
  /usr/local/games
)

if [ -f "/mnt/c/WINDOWS/explorer.exe" ]; then
  paths+=('/mnt/c/ProgramData/DockerDesktop/version-bin')
  paths+=('/mnt/c/Program Files/Docker/Docker/Resources/bin')
  paths+=('/mnt/c/Program Files (x86)/Python37-32/Scripts/')
  paths+=('/mnt/c/Program Files (x86)/Python37-32/')
  paths+=('/mnt/c/WINDOWS/system32')
  paths+=('/mnt/c/WINDOWS')
  paths+=('/mnt/c/WINDOWS/System32/Wbem')
  paths+=('/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0/')
  paths+=('/mnt/c/WINDOWS/System32/OpenSSH/')
  paths+=('/snap/bin')  
fi

export PATH
for p in "${paths[@]}"; do
  echo "List path"
  echo $p
  [[ -d "$p" ]] && PATH="$p:$(path_remove "$p")"
done
unset p paths