#!/usr/bin/env bash
#
# The MIT License (MIT)
#
# Copyright (c) 2018 Mathias Leppich <mleppich@muhqu.de>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#

SELF="$(basename "$0")"

usage() {
    cat <<USAGE
$SELF { play | pause | next | prev | is_playing }
USAGE
}

main() {
    if [[ $# -eq 0 ]]; then
        usage
        exit 1
    fi
    local ACTION=(usage)
    while [[ $# -gt 0 ]]; do
        case "$1" in
            play)
                shift
                ACTION=(doAmazonMusicPlayback "Play")
                ;;
            pause)
                shift
                ACTION=(doAmazonMusicPlayback "Pause")
                ;;
            next)
                shift
                ACTION=(doAmazonMusicPlayback "Next")
                ;;
            prev)
                shift
                ACTION=(doAmazonMusicPlayback "Prev")
                ;;
            is_playing)
                shift
                ACTION=(isAmazonMusicPlaying)
                ;;
            *)
                fatal "unknown parameter: $1"
                ;;
        esac
    done

    "${ACTION[@]}"
}

isAmazonMusicPlaying() {
    local VALUE="$(
    /usr/bin/osascript 2>/dev/null <<'APPLESCRIPT'
set isplaying to false
tell application "System Events"
    -- set frontmostProcess to first process where it is frontmost
    tell process "Amazon Music"
  set pauseMenuItem to null
  try
      set pauseMenuItem to (menu item 1 where its name starts with "Pause") of menu 1 of menu bar item "Playback" of menu bar 1
  on error errorMsg
  end try
  set playMenuItem to null
  try
      set playMenuItem to (menu item 1 where its name starts with "Play") of menu 1 of menu bar item "Playback" of menu bar 1
  on error errorMsg
  end try
  set isplaying to (pauseMenuItem is not null and playMenuItem is null)
    end tell
    -- set frontmost of frontmostProcess to true
end tell
isplaying
APPLESCRIPT
  )"
    if [[ $VALUE == "true" ]]; then
        log "Amazon Music is playing."
        exit 0
    else
        log "Amazon Music is not playing."
        exit 1
    fi
}

doAmazonMusicPlayback() {
    PREFIX="$1" /usr/bin/osascript 2>/dev/null >&2 -so <<'APPLESCRIPT'
    set PREFIX to system attribute "PREFIX"
    tell application "System Events"
  -- set frontmostProcess to first process where it is frontmost
  tell process "Amazon Music"
      -- set frontmost to true
      click (menu item 1 where its name starts with PREFIX) of menu 1 of menu bar item "Playback" of menu bar 1
  end tell
  -- set frontmost of frontmostProcess to true
    end tell
APPLESCRIPT
}

fatal() {
    error "$@"
    exit 1
}
error() {
    log "Error:" "$@"
}
log() {
    echo >&2 "$@"
}

main "$@"
