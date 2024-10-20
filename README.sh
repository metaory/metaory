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

function divider {
  shuf < src/dots | fmt -w 120 | tr -d ' ' | head -n 1
}

function write {
  while [ "$1" ]; do
    envsubst <"src/${1:?MISS}.json" | markup >>README.md
    shift
  done
}

write header divider

for i in {1..4}; do
  jq '[["div",{align:"center"},
    (["h3",.[0]]), (
      .[1]|map(
          ["img", {
            alt:.,
            title:.,
            src:["${SICO}/"+.+"?",{viewbox:"auto"}],
            width:"$IH",
            height:"$IH"
          }]
        ).[]
      )]]' <"src/list_${i}.json" | envsubst | markup >>README.md
  write divider
done

write streaks divider footer

# vim: ft=bash
