#!/bin/bash

function delete_backend() {
    echo "⚠️ Warning: Deleting the backend folder will also delete the database."
    read -p "Are you sure you want to continue? (y/n) " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo "🧹 Cleaning up backend folder..."
        rm -rf ../backend/*
    fi
    ;;
}

function  delete_frontend() {
    rm -rf ../frontend/*
}

function delete_folders() {
    folder_path=$1
    rm -rf $folder_path
}





echo "What would you like to clean up?:"
options=("Reset repository" "Delete both folders", "Delete backend folder" "Delete frontend folder"  "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Reset repository")
            echo "🧹 Cleaning up repository..."
            delete_backend
            delete_frontend
            delete_folders docker-compose.yml
            ;;
        "Delete codebase folders")
            echo "🧹 Cleaning up codebase folders..."
            delete_backend
            delete_frontend
            ;;
        "Delete frontend folder")
            echo "🧹 Cleaning up frontend folder..."
            delete_frontend
            ;;
       
        "Quit")
            echo "Exiting cleanup script"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done