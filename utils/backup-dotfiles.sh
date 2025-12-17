#!/usr/bin/env bash

# Name of the output zip file (default: dotfiles.zip)
OUTPUT="${1:-dotfiles.zip}"

# Find all dotfiles (exclude directories and . and ..)
dotfiles=()
while IFS= read -r -d '' file; do
    dotfiles+=("$file")
done < <(find . -maxdepth 1 -type f -name ".*" ! -name "." ! -name ".." -print0)

# If none found, exit
if [ ${#dotfiles[@]} -eq 0 ]; then
    echo "No dotfiles found in current directory."
    exit 1
fi

# Create the zip archive
zip "$OUTPUT" "${dotfiles[@]}"

echo "Created $OUTPUT containing:"
printf '  %s\n' "${dotfiles[@]}"
