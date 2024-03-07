#!/usr/bin/env sh

if [ $(yabai -m query --displays | jq -r '.[].spaces' | wc -l) -gt 1 ]; then
    current_space="$(yabai -m query --spaces --space | jq -r '.label')"

    # Move primary spaces to external/big screen.
    yabai -m space --focus shell
    yabai -m space --display 2
    yabai -m space --focus browser
    yabai -m space --display 2
    yabai -m space --focus notes
    yabai -m space --display 2

    # Move secondary spaces to internal/small screen.
    yabai -m space --focus misc
    yabai -m space --display 1
    yabai -m space --focus chat
    yabai -m space --display 1
    yabai -m space --focus mail
    yabai -m space --display 1
    yabai -m space --focus video
    yabai -m space --display 1

    # Focus previously focused space.
    yabai -m space --focus "${current_space}"
fi
