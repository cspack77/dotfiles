#!/bin/bash

# Check for pacman and AUR updates
cup () {
  clear
  checkupdates
  #AURUPDATES=$(aur vercmp -d custom)
  AURUPDATES=$(aur repo -u)
  [[ -n "$AURUPDATES" ]] && printf "\nAUR\n%s${AURUPDATES}\n"
  # LTS kernel
  #CURR_KERNEL=$(pacman -Ss --dbpath /tmp/checkup-db-ted/ linux-lts |grep "core\/linux-lts " | cut -d " " -f 2)
  #printf "\nLatest LTS kernel: $CURR_KERNEL\n"
  # Mainline kernel
  #CURR_KERNEL=$(pacman -Ss --dbpath /tmp/checkup-db-ted/ linux |grep "core\/linux " | cut -d " " -f 2)
  CURR_KERNEL=$(pacman -Ss --dbpath /tmp/checkup-db-1000/ linux |grep "core\/linux " | cut -d " " -f 2)
  printf "\nLatest kernel : $CURR_KERNEL\n"

  printf "Running kernel: $(uname -r)\n"
}

# Search for packages in repo and AUR
allsearch () {
  pacman -Ss "$@"
  aur search "$@"
}

# Build package in chroot
aurmake () {
    aur build -c -d custom
    sudo pacsync custom
}

# Install a package from AUR
aurdown () {
  if [ ! -n "$1" ]; then
    printf "\nUsage: aurdown <AUR package>\n\n"
    return 1
  else
    cd ~/.cache/aurutils/sync
    #auracle download "$@"
    #aur fetch "$@"
    repoctl down "$@"
    cd "$@"
  fi
}

# Remove package from AUR custom repo
aurremove () {
  if [ ! -n "$1" ]; then
    printf "\nUsage: aurremove <AUR package>\n\n"
    return 1
  else
    #repo-remove /var/cache/pacman/custom/custom.db.tar "$@"
    #sudo pacsync custom
    repoctl remove "$@"
  fi
}

# Sync AUR
aurup () {
  aur sync -c -u --no-view --ignore $(pacconf --null=, IgnorePkg |head -c -1)
  sudo pacsync custom
}
