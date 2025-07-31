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
    --jq 'map({
     name,
     description,
     url,
     homepageUrl,
     language: (.primaryLanguage.name // "NA"),
     createdAt,
     stars: .stargazerCount,
     topics: (.repositoryTopics // [] | map(.name)),
   })' | tee /tmp/repos.json |
    jq ' [.[] | select(.topics | index("pin"))] | sort_by(.createdAt) | reverse | [
    ["h4", {"align": "center"}, "F꠵atured Projects"],
    ["table", {"align": "center"}, (
      to_entries |
      group_by(.key / 2 | floor) |
      map(["tr", (
        map(.value) |
        map(["td",
          {"width": "50%", "align": "center"},
          ["h3", ["a", {"href": .url}, .name]],
          ["strong", .description], (
            select(.homepageUrl and .homepageUrl != "") | ["div",
              ["a",
                {"href": .homepageUrl},
                (.homepageUrl | sub("^https?://"; "") | sub("^www\\."; ""))
              ]
            ]),
          ["div",
            ["em", (.createdAt | fromdateiso8601 | strftime("%b %Y"))],
            "·",
            ["strong", "⭐" + (.stars | tostring)],
            "·",
            ["kbd", .language]
          ]
        ]))[]
      ])
    )[]],
    ["hr"]
  ]' | tee /tmp/markup-output.json | markup >>README.md
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

append header

repositories

for i in {1..4}; do
  fetch-list "$i"
  compose "$i"
  append divider
done

now="$(date +%s)"
export NOW="${now::4}000000"

append footer

# vim: ft=bash
