#!/bin/bash
# set -Eeuo pipefail

:>README.md

declare -a SIMPLEICONS=(alacritty alpinelinux amazon amazonapigateway amazoncloudwatch amazoncognito amazondocumentdb amazondynamodb amazonec2 amazonecs amazoneks amazonelasticache amazoniam amazonroute53 amazons3 amazonsimpleemailservice amazonsqs amazonwebservices archlinux asciinema astro awslambda awsorganizations awssecretsmanager backbonedotjs biome bun c clerk cloudflare cmake codesandbox creality creativecommons crunchyroll css3 cssmodules deno discord docker docusaurus elasticsearch elixir envoyproxy erlang excalidraw ffmpeg genius git github gitkraken gnu gnubash go google googlechrome grafana graphite graphql gtk hcl hoppscotch hotjar houdini html5 htmx hyper hyperland i3 icomoon icon iconify inkscape javascript jsonwebtokens jsr knowledgebase less libreoffice libuv linux linuxcontainers linuxfoundation linuxserver llvm local logspec logstash loom lua make man mapbox meta microstrategy miro monorepo mpv neovim nixos notion npm obsidian ocaml opel opencollective openfaas opengl openid openjsfoundation openssl openvpn owasp postgresql prettier prometheus puppeteer pwa qmk react readme redis runkit rust semver sentry shell snowflake snyk spacex spotify steam steamdb stencil stripe suckless supabase svelte svg tails terraform tmux travisci trivy trpc tui turso twilio twitch typescript unicode unlicense upstash v8 valve vercel vue webassembly wezterm xo yaml zig zsh)
declare -a SKILLICONS=()
# declare -a SKILLICONS=(deno docker github haskell md mysql nextjs nuxtjs planetsc postgres rabbitmq react redis regex replit rust sentry sqlite supabase tauri ts vercel vim zig)

declare -a SHADES=('000000,110022,110033' '110033,110022,110022,110033' '110033,110022,000000')

declare STAT_HOST="https://streak-stats.demolab.com"

declare -A STAT_ATTRIBUTES=(
    [border_radius]=30
    [currStreakLabel]=1177DD
    [currStreakNum]=FF0044
    [card_width]=200
    [dates]=8866EE
    [excludeDaysLabel]=EB5454
    [fire]=1177DD
    [hide_border]=true
    [mode]=weekly
    [ring]=5522CC
    [sideLabels]=1177DD
    [sideNums]=44BBFF
    [stroke]=5522CC94
    [theme]=dark-minimalist
    [user]=metaory
)
declare -A IMG_ATTRIBUTES=(
    [height]='110'
)

declare -a STAT_TYPES=(current_streak longest_streak total_contributions)
declare ASSETS=https://github.com/metaory/metaory/blob/master/.github/assets

declare STAT_TMP='<img height="150" src="https://github-readme-stats.vercel.app/api?username=metaory&ring_color=5522CC&bg_color=45,110022,110022,110022,110011,100010,000000&text_color=44BBFF&border_radius=30&hide_title=true&hide_rank=false&show_icons=true&include_all_commits=true&count_private=true&disable_animations=false&locale=en&hide_border=true"  alt="stats graph" />'
declare ACTV_TMP='<img height="280" alt="activity-graph graph" src="https://github-readme-activity-graph.vercel.app/graph?username=metaory&bg_color=00000000&color=4411FF&title_color=000000&line=4411FF&point=5522CC&area_color=5522CC&hide_border=true&hide_title=true&area=true&radius=20" />'

cat << EOF >> README.md

<div align="center">
  <img width="400" src="${ASSETS}/mxc.png?raw=true"  />
</div>
<div align="center">
  <img width="30%" src="${ASSETS}/hr1.png?raw=true"  />
</div>

<div align="center">
  ${STAT_TMP}

EOF

C=0
for ST in "${STAT_TYPES[@]}"; do
    printf '<img\talt="%s"\n' "$ST" >> README.md


    for IA in "${!IMG_ATTRIBUTES[@]}"; do
        printf '\t\t%s="%s"\n' "$IA" "${IMG_ATTRIBUTES[${IA}]}" >> README.md
    done

    printf '\t\tsrc="%s?background=10,%s&' "$STAT_HOST" "${SHADES[${C}]}" >> README.md

    for SA in "${!STAT_ATTRIBUTES[@]}"; do
        printf '%s=%s&' "$SA" "${STAT_ATTRIBUTES[${SA}]}" >> README.md
    done

    for STT in "${STAT_TYPES[@]}"; do
        [ "$ST" != "$STT" ] && \
            printf 'hide_%s=true&' "$STT" >> README.md
    done
    echo

    printf '"\n\t/>\n' >> README.md

    (( C++ ))
done

cat << EOF >> README.md
</div>

<div align="center">
  <img width="40%" src="${ASSETS}/hr2.png?raw=true"  />
</div>

<div align="center">
<h4>stuff I still can tolerate</h4>
EOF

for IC in "${SKILLICONS[@]}"; do
    printf '<img src="https://skillicons.dev/icons?i=%s" height="30" />\n' "$IC" >> README.md
done

cat << EOF >> README.md
</div>

<div align="center">
EOF

for IC in "${SIMPLEICONS[@]}"; do
    printf '<img src="https://cdn.simpleicons.org/%s" height="30" />\n' "$IC" >> README.md
done

cat << EOF >> README.md
</div>

EOF

cat << EOF >> README.md
<div align="center">
  ${ACTV_TMP}
</div>

<div align="center">
  <img src="${ASSETS}/home.webp?raw=true" />
  <img src="${ASSETS}/hr2.png?raw=true" />
</div>
EOF

# vim: ft=bash
