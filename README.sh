#!/bin/bash

: >README.md

command -v markup >/dev/null || npm i -g markup.json
command -v jq >/dev/null || exit 1

source .env

function parse {
  while [ "$1" ]; do
    envsubst <"src/${1:?MISS}.json" | markup >>README.md
    shift
  done
}

parse header stats streaks

for i in {1..4}; do
  jq '["",["div",{align:"center"},
    (["h3",.[0]]), (
      .[1]|map(
          ["img", {
            src:["${SICO}/"+.+"?",{viewbox:"auto"}],
            height:"$IH"
          }]
        ).[]
      )]]' <"src/list_${i}.json" | envsubst | markup >>README.md
done

parse footer

# vim: ft=bash
