#!/usr/bin/bash

check_errors_sys () {
    systemctl --failed
}

check_errors_journal () {
    journalctl -p 3 -b
}

upgrade_system () {
    sudo pacman -Sy --needed archlinux-keyring && paru
}

upgrade_system_config () {
    sudo -H DIFFPROG="nvim -d" pacdiff
}

clean_package_cache () {
    sudo paccache -rk1
}

remove_orphan_packages () {
    pacman -Qtdq | sudo pacman -Rns -
}

find_lost_files() {
    sudo lostfiles | ${PAGER:=less}
}

find_broken_links () {
    sudo find / -xdev -xtype l -print | ${PAGER:=less}
    # find /home -xdev -xtype l -print
}

reboot_system () {
    read -p "Are you sure? (y/n) " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        sudo systemctl reboot
    fi
}

options=(
    "Check for system errors"
    "Check for errors in journal"
    "Upgrade system packages"
    "Upgrade system config (pacdiff)"
    "Remove orphaned packages"
    "Clean package cache"
    # TODO old config files, rmshit, rmlint
    "Find lost files"
    "Find broken links"
    "Reboot"
)

echo
PS3="> "
select opt in "${options[@]}" "Quit"; do 
    echo
    case "$REPLY" in
    1) check_errors_sys;;
    2) check_errors_journal;;
    3) upgrade_system;;
    4) upgrade_system_config;;
    5) remove_orphan_packages;;
    6) clean_package_cache;;
    7) find_lost_files;;
    8) find_broken_links;;
    9) reboot_system;;
    $((${#options[@]}+1))) echo ""; break;;
    *) echo "Invalid option. Try again.";;
    esac
    echo
    REPLY=
done
