#!/bin/bash

# 1. macOS PATH Setup
export PATH="/opt/homebrew/bin:/usr/local/bin:$HOME/go/bin:$PATH"

# 2. Variable Defaults: Use Transmission vars OR current directory if manual
: "${TR_TORRENT_DIR:=$(dirname "$PWD")}"
: "${TR_TORRENT_NAME:=$(basename "$PWD")}"
TARGET_PATH="$TR_TORRENT_DIR/$TR_TORRENT_NAME"

# 3. Safety Check: Exit if no .cue files exist
CUE_FILES=$(find "$TARGET_PATH" -type f -name "*.cue" 2>/dev/null)
if [ -z "$CUE_FILES" ]; then
    echo "Error: No .cue files found in $TARGET_PATH." >&2
    exit 1
fi

# 4. Processing and Flattening
echo "Processing: $TARGET_PATH"
echo "$CUE_FILES" | while read -r cue_file; do
    album_dir=$(dirname "$cue_file")
    cd "$album_dir" || continue
    
    # unflac splits the file and creates a new folder (e.g., Artist/Album)
    unflac "$(basename "$cue_file")"
    
    # To prevent artist-level collisions, we move the innermost folders
    # find -mindepth 2 finds the actual Album folders inside the Artist folders created by unflac
    find . -mindepth 2 -maxdepth 2 -type d | while read -r split_album_path; do
        # Move album folder to the root of the torrent download
        # Use -n to prevent overwriting existing folders
        mv -vn "$split_album_path" "$TARGET_PATH/"
    done
done

# 5. Safe Cleanup
# Delete only empty subdirectories; keeps originals if move failed
find "$TARGET_PATH" -mindepth 1 -type d -empty -delete
