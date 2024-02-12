#!/usr/bin/env sh
#
space_count="$(yabai -m query --displays | jq -r '.[].spaces.[]' | wc -l)"

if [ ${space_count} -lt 7 ]; then
    spaces_to_create=$((7 - space_count))
    for space in $(seq 1 ${spaces_to_create}); do
        yabai -m space --create
    done
fi
