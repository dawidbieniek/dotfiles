#!/bin/bash

# Enable dotglob to include files starting with a dot
shopt -s dotglob

# Define the source directory (where your .dotfiles are)
DOTFILES_DIR="$HOME/.dotfiles"

# Define the target directory (your home directory)
TARGET_DIR="$HOME"

# Function to display help text
display_help() {
    echo "Usage: $0 [options]"
    echo
    echo "Options:"
    echo " -h    Display this help text."
    echo " -d    Delete symbolic links instead of creating them."
    echo
    echo "Without any arguments, this script creates symbolic links for dotfiles."
    echo "Use -d to delete the symbolic links instead."
}

# Function to create symbolic links
create_links() {
    local src="$1"
    local dst="$2"

    # Check if the source is a directory
    if [ -d "$src" ]; then
        # If the destination directory does not exist, create it
        if [ ! -d "$dst" ]; then
            mkdir -p "$dst"
        fi

        # Iterate over each item in the source directory
        for item in "$src"/*; do
            # Skip the script itself
            if [ "$(realpath "$item")" == $(realpath "$0") ]; then
                continue
            fi

            # Skip the .git directory and .gitignore file
            if [ "$(basename "$item")" == ".git" ] || [ "$(basename "$item")" == ".gitignore" ]; then
                continue
            fi

            # Get the base name of the item
            local base_name=$(basename "$item")
            # Create the destination path
            local dest_path="$dst/$base_name"
            # Check if the link already exists
            if [ -L "$dest_path" ]; then
                echo "Link already exists for $base_name, skipping."
                continue
            fi
            # Recursively call this function for directories
            create_links "$item" "$dest_path"
        done
    else
        # If the source is a file, create a symbolic link
        ln -s "$src" "$dst"
        echo "Created link for $(basename "$src")."
    fi
}

# Function to delete symbolic links
delete_links() {
    local src="$1"
    local dst="$2"

    # Check if the source is a directory
    if [ -d "$src" ]; then
        # Iterate over each item in the source directory
        for item in "$src"/*; do
            # Skip the script itself
            if [ "$(realpath "$item")" == $(realpath "$0") ]; then
                continue
            fi

            # Skip the .git directory and .gitignore file
            if [ "$(basename "$item")" == ".git" ] || [ "$(basename "$item")" == ".gitignore" ]; then
                continue
            fi

            # Get the base name of the item
            local base_name=$(basename "$item")
            # Create the destination path
            local dest_path="$dst/$base_name"
            # Check if the destination is a symbolic link
            if [ -L "$dest_path" ]; then
                # Remove the symbolic link
                rm "$dest_path"
                echo "Removed link for $base_name."
            fi
            # Recursively call this function for directories
            delete_links "$item" "$dest_path"
        done
    fi
}

# Check for command-line arguments
if [ "$1" == "-h" ]; then
    # If -h is provided, display help text and exit
    display_help
    exit 0
elif [ "$1" == "-d" ]; then
    # If -d is provided, delete the links
    delete_links "$DOTFILES_DIR" "$TARGET_DIR"
else
    # Otherwise, create the links
    create_links "$DOTFILES_DIR" "$TARGET_DIR"
fi

