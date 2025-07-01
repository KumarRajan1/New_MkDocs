#!/bin/bash

set -e

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

REPOS_FILE="/var/www/html/docusaurus/new1/my-docs/repos.txt"
DEST_DIR="/var/www/html/docusaurus/new1/my-docs/fetched-repos"
MKDOCS_DOCS_DIR="/var/www/html/docusaurus/new1/my-docs/docs"

# Use absolute paths for commands
MKDIR_BIN="/bin/mkdir"
CD_BIN="/usr/bin/cd"
GIT_BIN="/usr/bin/git"
RSYNC_BIN="/usr/bin/rsync"

$MKDIR_BIN -p "$DEST_DIR"
cd "$DEST_DIR" || exit 1

changes_detected=false

while read -r line; do
    [[ -z "$line" || "$line" == \#* ]] && continue

    if [[ "$line" == *"|"* ]]; then
        folder="${line%%|*}"
        repo="${line##*|}"
    else
        repo="$line"
        folder=$(/usr/bin/basename "$repo" .git)
    fi

    echo "🔄 Processing $folder"

    if [ -d "$folder/.git" ]; then
        cd "$folder"
        echo "   🔍 Checking for updates..."
        $GIT_BIN remote update > /dev/null

        LOCAL=$($GIT_BIN rev-parse @)
        REMOTE=$($GIT_BIN rev-parse @{u})
        BASE=$($GIT_BIN merge-base @ @{u})

        if [ "$LOCAL" = "$REMOTE" ]; then
            echo "   ✅ Up to date"
        elif [ "$LOCAL" = "$BASE" ]; then
            echo "   📥 Pulling changes..."
            $GIT_BIN pull
            changes_detected=true
        else
            echo "   ⚠️ Diverged — skipping"
        fi

        cd ..
    else
        echo "📦 Cloning $repo into $folder"
        $GIT_BIN clone "$repo" "$folder"
        changes_detected=true
    fi
done < "$REPOS_FILE"

# Sync Markdown if changes
if $changes_detected; then
    echo "📄 Syncing .md files to MkDocs..."

    # /bin/rm -rf "$MKDOCS_DOCS_DIR"/*

    for repo_dir in */; do
        [ -d "$repo_dir/.git" ] || continue

        echo "   📁 Copying from $repo_dir"
        target_dir="$MKDOCS_DOCS_DIR/$(/usr/bin/basename "$repo_dir")"
        $MKDIR_BIN -p "$target_dir"

        $RSYNC_BIN -av --include="*/" --include="*.md" --exclude="*" "$repo_dir/" "$target_dir/"
    done
else
    echo "🔕 No changes — skipping doc sync"
fi

cd ..
echo "✅ Done"
