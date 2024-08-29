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

# shellcheck disable=SC2016
ICO_QUERY='["",["div",{align:"center"},
    (["h3",.[0]]), (
      .[1]|map(
          ["img", {
            src:["${SICO}/"+.+"?",{viewbox:"auto"}],
            height:"$IH"
          }]
        ).[]
      )]]'

function icons {
  while [ "$1" ]; do
    jq "$ICO_QUERY" <"src/${1:?MISS}.json" | envsubst | markup >>README.md
    shift
  done
}

icons list_a list_b list_c list_d

parse footer

# vim: ft=bash
