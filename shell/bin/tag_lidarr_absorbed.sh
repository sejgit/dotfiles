#!/bin/bash

# Configuration: Set the tag you want to apply
MY_TAG="lidarr-absorbed"
# TAG_BINARY="/opt/homebrew/bin/tag" # M1
TAG_BINARY="/usr/local/bin/tag" # Intel

# Lidarr passes variables as environment variables
# For "On Release Import" and "On Upgrade", the path is lidarr_import_path
TARGET_PATH="$lidarr_import_path"

# Verify path exists and apply tag
if [ -n "$TARGET_PATH" ] && [ -e "$TARGET_PATH" ]; then
    # --add ensures we don't overwrite existing tags
    "$TAG_BINARY" --add "$MY_TAG" "$TARGET_PATH"
    echo "Successfully tagged: $TARGET_PATH with $MY_TAG"
else
    echo "Error: No valid path found from Lidarr."
fi
