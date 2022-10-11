#!/bin/bash

##
# Pure BASH interactive CLI script to clone multiple git repositories
#
# Author: Mohammed El-kabli <melkabli05@gmail.com>
#



############# variables #############
declare -A repositories
#this is an associative array that contains the repositories to clone
# repositories[<repo_name>]="<repo_url>"
repositories=(
    ["repository1"]="http://link1"
    ["repository2"]="http://link2"
    ["repository3"]="http://link3"
    ["repository4"]="http://link4"
    ["repository5"]="http://link5"
    ["repository6"]="http://link6"
    ["repository7"]="http://link7"
    ["repository8"]="http://link8"
    ["repository9"]="http://link9"
    ["repository10"]="http://link10"
    )
     # this is the name of the directory where the repositories will be cloned
folder_name=""
      # this is the branch name that will be cloned
branch_name=""

repositories_to_clone=()


############# functions #############

check_folder_name() {

    echo "Enter the name of the folder where the repositories will be cloned in:"
    read folder_name

    if [ -d "/home/mohammed/${folder_name}" ]; then
        echo "The folder name already exists, please enter another name"
        check_folder_name
    else
        mkdir "/home/mohammed/${folder_name}"
        # shellcheck disable=SC2164
        cd "/home/mohammed/$folder_name"
        path=$(pwd)
        echo "The folder path is: $path"
    fi
}


menu() {
  cmd=(dialog --separate-output --title "Repositories" --checklist "Choose the repositories you want to clone:" 22 76 16)
  for i in "${!repositories[@]}"; do
    options+=("$i" "" off)
  done
  repositories_to_clone=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
  clear
}


clone_repositories() {
    for i in $repositories_to_clone; do
        git clone -b "$branch_name" "${repositories[$i]}"
        if [ $? -eq 0 ]; then
            echo "The repository $i is cloned successfully"
            repositories_to_clone_successfully+=("$i")
        else
            echo "The repository $i is not cloned successfully"
            repositories_to_clone_unsuccessfully+=("$i")
        fi
    done
}


############# main #############

check_folder_name
menu
sleep 5
clone_repositories












