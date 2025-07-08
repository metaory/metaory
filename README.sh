#!/bin/bash

: >README.md

cat <<EOF >README.md
<!-- generated with
     ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
     ░░█▀▄▀█ ▄▀█ █▀█ █▄▀ █░█ █▀█ ░ ░░█ █▀ █▀█ █▄░█░░
     ░░█░▀░█ █▀█ █▀▄ █░█ █▄█ █▀▀ ▄ █▄█ ▄█ █▄█ █░▀█░░
     ░░ github.com/metaory/markup.json ░░░░░░░░░░░░░ -->
EOF

command -v markup >/dev/null || npm i -g markup.json
command -v jq >/dev/null || exit 1

source .env

normalize='s/[a-z]{2}://;
s/(-wordmark|-icon|-dark|-light|file-type-|-alt|brand-)//'

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

function append {
  while [ "$1" ]; do
    envsubst <"src/${1:?MISS}.json" | markup >>README.md
    shift
  done
}

function fetch-icon {
  filepath="assets/icons/$(sed -E "$normalize" <<<"$1").svg"
  read -r slug < <(envsubst <<<"\$${1}")
  URL="${ICONIFY}/${slug}.svg?color=%23${ICON_COLOR:1}&width=128&height=128"
  echo -e "\e[34m:: [${1}] \e[1;34m${filepath} \n\e[37m:> $URL \e[0m"
  [ -f "$filepath" ] || curl -so "$filepath" "$URL"
}

function fetch-list {
  while read -r row; do
    fetch-icon "$row"
  done < <(jq -rc '.[1][]' "src/list_${1}.json")
}

function compose {
  jq '[["div",{align:"center"},
    (["h3",.[0]]), (
      .[1]|map(
          ["img", {
            alt:.,
            title:.,
            src:["assets/icons/"+.+".svg", {}],
            width:"24",
            height:"24"
          }]
        ).[]
      )]]' < <(sed -E "$normalize" "src/list_${1}.json") |
    markup >>README.md
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

append header

for i in {1..4}; do
  fetch-list "$i"
  compose "$i"
  append divider
done

now="$(date +%s)"
export NOW="${now::5}00000"

append footer

# vim: ft=bash
