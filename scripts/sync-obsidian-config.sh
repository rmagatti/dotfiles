#!/bin/bash
#
# Symlinks .obsidian config from the personal vault into .obsidian-magatti
# in all other vaults. workspace.json is kept per-vault.
#
# Requires configDir: ".obsidian-magatti" to be set for each target vault
# in ~/Library/Application Support/obsidian/obsidian.json
#

OBSIDIAN_DIR="$HOME/Obsidian"
SOURCE_VAULT="vault"
SOURCE_CONFIG="$OBSIDIAN_DIR/$SOURCE_VAULT/.obsidian"
CONFIG_DIR_NAME=".obsidian-magatti"

if [[ ! -d "$SOURCE_CONFIG" ]]; then
    echo "Source config not found: $SOURCE_CONFIG"
    exit 1
fi

for vault_dir in "$OBSIDIAN_DIR"/*/; do
    vault_name=$(basename "$vault_dir")
    [[ "$vault_name" == "$SOURCE_VAULT" ]] && continue

    target="$vault_dir$CONFIG_DIR_NAME"
    mkdir -p "$target"

    echo "==> $vault_name"

    for item in "$SOURCE_CONFIG"/*; do
        name=$(basename "$item")
        [[ "$name" == "workspace.json" ]] && continue

        if [[ -L "$target/$name" && "$(readlink "$target/$name")" == "$item" ]]; then
            echo "  [ok] $name"
        else
            ln -sf "$item" "$target/$name"
            echo "  [link] $name"
        fi
    done
done

echo "Done."
