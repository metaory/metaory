#!/bin/bash

: >README.md

cat <<EOF >README.md
<!-- generated with
     ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
     ░░█▀▄▀█ ▄▀█ █▀█ █▄▀ █░█ █▀█ ░ ░░█ █▀ █▀█ █▄░█░░
     ░░█░▀░█ █▀█ █▀▄ █░█ █▄█ █▀▀ ▄ █▄█ ▄█ █▄█ █░▀█░░
     ░░ github.com/metaory/markup.json ░░░░░░░░░░░░░ -->
EOF

command -v markup >/dev/null || npm i -g markup.json || exit 1
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
  echo -e "\e[34m:: [${1}] \e[1;34m${filepath}\e[0m"
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

function repositories {
  gh repo list \
    --visibility=public \
    --limit 400 \
    --json "name,description,url,homepageUrl,primaryLanguage,createdAt,stargazerCount,repositoryTopics" \
    --jq '
      map(select(.homepageUrl != null and .homepageUrl != "")) |
      map({
        name,
        description,
        url,
        homepageUrl,
        language: (.primaryLanguage.name // "NA"),
        createdAt,
        stars: .stargazerCount,
        topics: (.repositoryTopics // [] | map(.name)),
        type: (
          if (.repositoryTopics // [] | map(.name) | index("npm")) then "npm"
          elif (.repositoryTopics // [] | map(.name) | index("cli")) then "cli"
          else "app"
          end
        )
      })
    ' | jq --argjson icons "$icons" '
      [.[] | select(.topics | index("pin"))] |
      sort_by(.createdAt) |
      reverse |
      [
        ["h4", {"align": "center"}, "Personal Projects"],
        map([
          "li",
          ["img", { valign: "middle", src: ($icons[.language] // $icons.NA), width: 26, height: 26 }],
          ["img", { valign: "middle", src: ("assets/icons/" + .type + ".svg"), width: 24, height: 24 }],
          ["a", {href: .url}, ["strong", .name]],
          ["a", {"href": .homepageUrl}, "[LIVE]" ],
          ["i", "─", .description],
          ["img", { valign: "middle", src: $icons.Star, width: 16, height: 16 }], ["b", .stars]
        ])[],
        ["hr"]
      ]
    ' | markup >>README.md
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

append header

repositories

for i in {1..4}; do
  fetch-list "$i"
  compose "$i"
  append "divider_$i"
done

now="$(date +%s)"
export NOW="${now::4}000000"

append footer

# vim: ft=bash
