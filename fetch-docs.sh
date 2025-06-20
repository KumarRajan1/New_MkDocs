#!/bin/bash

set -e

REPOS_FILE="repos.txt"
DEST_DIR="fetched-repos"
MKDOCS_DOCS_DIR="../docs"

mkdir -p "$DEST_DIR"
cd "$DEST_DIR" || exit 1

changes_detected=false

while read -r line; do
    [[ -z "$line" || "$line" == \#* ]] && continue

    if [[ "$line" == *"|"* ]]; then
        folder="${line%%|*}"
        repo="${line##*|}"
    else
        repo="$line"
        folder=$(basename "$repo" .git)
    fi

    echo "🔄 Processing $folder"

    if [ -d "$folder/.git" ]; then
        cd "$folder"
        echo "   🔍 Checking for updates..."
        git remote update > /dev/null

        LOCAL=$(git rev-parse @)
        REMOTE=$(git rev-parse @{u})
        BASE=$(git merge-base @ @{u})

        if [ "$LOCAL" = "$REMOTE" ]; then
            echo "   ✅ Up to date"
        elif [ "$LOCAL" = "$BASE" ]; then
            echo "   📥 Pulling changes..."
            git pull
            changes_detected=true
        else
            echo "   ⚠️ Diverged — skipping"
        fi

        cd ..
    else
        echo "📦 Cloning $repo into $folder"
        git clone "$repo" "$folder"
        changes_detected=true
    fi
done < "../$REPOS_FILE"

# Sync Markdown if changes
if $changes_detected; then
    echo "📄 Syncing .md files to MkDocs..."

    #rm -rf "$MKDOCS_DOCS_DIR"/*

    for repo_dir in */; do
        [ -d "$repo_dir/.git" ] || continue

        echo "   📁 Copying from $repo_dir"
        target_dir="$MKDOCS_DOCS_DIR/$(basename "$repo_dir")"
        mkdir -p "$target_dir"

        rsync -av --include="*/" --include="*.md" --exclude="*" "$repo_dir/" "$target_dir/"
    done
else
    echo "🔕 No changes — skipping doc sync"
fi

cd ..
echo "✅ Done"
