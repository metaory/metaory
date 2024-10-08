#!/bin/bash

: >README.md

cat << EOF > README.md
<!-- generated with
     ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
     ░░█▀▄▀█ ▄▀█ █▀█ █▄▀ █░█ █▀█ ░ ░░█ █▀ █▀█ █▄░█░░
     ░░█░▀░█ █▀█ █▀▄ █░█ █▄█ █▀▀ ▄ █▄█ ▄█ █▄█ █░▀█░░
     ░░ github.com/metaory/markup.json ░░░░░░░░░░░░░ -->
EOF

command -v markup >/dev/null || npm i -g markup.json
command -v jq >/dev/null || exit 1

source .env

function parse {
  while [ "$1" ]; do
    envsubst <"src/${1:?MISS}.json" | markup >>README.md
    shift
  done
}

parse header stats

function hr { echo '["div",{"align":"center"},["img",{"sr":"'"${ASSETS}/hr$((RANDOM % 4))"'.png"}]]'; }

for i in {1..4}; do
  jq '["",'"$(hr)"',["div",{align:"center"},
    (["h3",.[0]]), (
      .[1]|map(
          ["img", {
            alt:.,
            src:["${SICO}/"+.+"?",{viewbox:"auto"}],
            width:"$IH",
            height:"$IH"
          }]
        ).[]
      )]]' <"src/list_${i}.json" | envsubst | markup >>README.md
done

parse streaks footer

# vim: ft=bash
