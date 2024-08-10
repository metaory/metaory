#!/bin/bash
# set -Eeuo pipefail

:>README.md

# declare ASSETS=https://github.com/metaory/metaory/blob/master/.github/assets
declare ASSETS=https://raw.githubusercontent.com/metaory/metaory/master/.github/assets

declare -a ASPIRED_TECH=(
    adventofcode
    c
    cmake
    cplusplus
    creativecommons
    crunchbase
    elixir
    erlang
    framework7
    gnu
    houdini
    htmx
    hyperland
    k3s
    kubernetes
    leptos
    libuv
    linuxfoundation
    llvm
    mapbox
    nasa
    nim
    ocaml
    opel
    opencollective
    opencollective
    openfaas
    opengl
    openid
    openjsfoundation
    openlayers
    openssl
    opentofu
    pocketbase
    prometheus
    rabbitmq
    redis
    remix
    rust
    sennheiser
    snowflake
    spacex
    spacex
    stackshare
    steam
    steamdb
    temporal
    trivy
    turso
    v8
    valve
    webassembly
    webgl
    zedindustries
    zig
)
declare -a PERSONAL_TECH=(
    alacritty
    alpinelinux
    archlinux
    asciidoctor
    asciinema
    astro
    authy
    awesomewm
    biome
    brave
    bun
    caldotcom
    cloudflarepages
    commitlint
    css3
    cssmodules
    curl
    darkreader
    deno
    devrant
    docker
    docusaurus
    dota2
    dotenv
    drizzle
    duckduckgo
    elastic
    elasticsearch
    envoyproxy
    excalidraw
    excalidraw
    fastapi
    ffmpeg
    fontbase
    gimp
    giphy
    git
    github
    githubactions
    githubpages
    gitkraken
    gitter
    gitter
    gnubash
    go
    graphite
    gravatar
    gtk
    headlessui
    hono
    hoppscotch
    hotjar
    iconify
    ifttt
    inkscape
    javascript
    jsonwebtokens
    jsr
    knowledgebase
    koa
    less
    letsencrypt
    libreoffice
    lightning
    linear
    linux
    linuxcontainers
    linuxserver
    lit
    logseq
    loom
    lua
    lucia
    make
    man
    markdown
    microstrategy
    miro
    mpv
    n8n
    neovim
    nginx
    nginxproxymanager
    ngrok
    nixos
    nodedotjs
    nomad
    notion
    npm
    observable
    obsidian
    outline
    p5dotjs
    pagerduty
    planetscale
    postgresql
    precommit
    prettier
    proton
    puppeteer
    qmk
    radixui
    replit
    runkit
    semanticrelease
    semver
    sentry
    shadcnui
    shell
    signal
    sqlite
    sst
    stackbit
    stackedit
    standardjs
    stencil
    suckless
    svelte
    svg
    tampermonkey
    tmux
    toml
    travisci
    tui
    unicode
    wakatime
    wezterm
    wikidata
    yaml
    yaml
    zapier
    zsh
)

declare -a TOLERATE_TECH=(
    amazon amazonapigateway amazoncloudwatch amazoncognito amazondocumentdb amazondynamodb amazonec2 amazonecs amazoneks amazonelasticache amazoniam amazonroute53 amazons3 amazonsimpleemailservice amazonsqs amazonwebservices awslambda awsorganizations awssecretsmanager
    auth0
    awsamplify
    axios
    backbonedotjs
    buildkite
    circleci
    clerk
    clickup
    cloudflare
    codesandbox
    creality
    crowdin
    datadog
    debian
    discord
    esbuild
    express
    genius
    google
    googlechrome
    googlecloud
    grafana
    graphql
    hcl
    html5
    hubspot
    icon
    jetbrains
    less
    logstash
    mailchimp
    mozilla
    nestjs
    nextdotjs
    nuxtdotjs
    openvpn
    owasp
    perl
    postman
    pug
    pwa
    railway
    react
    rollupdotjs
    sass
    sequelize
    snyk
    socketdotio
    stripe
    supabase
    swagger
    swc
    tailwindcss
    terraform
    testinglibrary
    trpc
    twilio
    twitch
    typescript
    upstash
    vercel
    vue
    webrtc
    xo
)

declare -a AVOID_TECH=(
    angular
    ansible
    atlassian
    bitbucket
    bitcoin
    chef
    django
    dotnet
    dynatrace
    eclipseide
    facebook
    firebase
    githubcopilot
    grunt
    gulp
    heroku
    hibernate
    instagram
    jenkins
    jest
    jira
    jirasoftware
    jquery
    lodash
    meta
    mobx
    mocha
    modx
    mongodb
    mongoosedotws
    mui
    newrelic
    php
    postcss
    prisma
    python
    qt
    reddit
    relay
    ruby
    sap
    sonarcloud
    splunk
    springboot
    storybook
    underscoredotjs
    vuedotjs
    webpack
    zoom
)
declare -a SHADES=('000000,110022,110033' '110033,110022,110022,110033' '110033,110022,000000')

function put_breaker {
    cat <<- EOF >> README.md
		<div align="center">
  		<img width="${1:-50}%" src="${ASSETS}/hr$((RANDOM%4)).png?raw=true"  />
		</div>
		EOF
}

function put_image {
    printf '<img src="%s" %s />\n' "${1:?NO_FILE}" "${2:-}" >> README.md
}

function put_section {
    local fn="${1:?NO_FN}"
    cat <<< '<div align="center">' >> README.md
    "$fn" "${@:2}"
    cat <<< $'\n</div>' >> README.md
}


function put_streak_stats {
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
    declare -A IMG_ATTRIBUTES=([height]='110')

    declare -a STAT_TYPES=(current_streak longest_streak total_contributions)

    cat <<< $'<img height="150" src="https://github-readme-stats.vercel.app/api?username=metaory&ring_color=5522CC&bg_color=45,110022,110022,110022,110011,100010,000000&text_color=44BBFF&border_radius=30&hide_title=true&hide_rank=false&show_icons=true&include_all_commits=true&count_private=true&disable_animations=false&locale=en&hide_border=true"  alt="stats graph" /> \n' >> README.md

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
}

function put_tech {
    cat <<< "<h4>${1:?NO_TITLE}</h4>" >> README.md
    shift

    while [ "$1" ]; do
        # put_image "https://skillicons.dev/icons?i=${1}" 'height="30"'
        #  <img src="https://skillicons.dev/icons?i=vim" height="30" alt="vim logo"  />
        #  <img src="https://cdn.simpleicons.org/ocaml/EC6813" height="30" alt="ocaml logo"  />
        #  <img src="https://cdn.simpleicons.org/tcs/3311ff" height="30" alt="ocaml logo"  />
        #  <img src="https://img.shields.io/badge/Neovim-57A143?logo=neovim&logoColor=black&style=for-the-badge" height="30" alt="neovim logo"  />
        #  <img height="20" src="https://cdn.simpleicons.org/simpleicons?viewbox=auto" />
        #  https://img.shields.io/badge/you_like-993388?style=for-the-badge&logo=go&logoColor=aa00ee&labelColor=5511ee&logoSize=auto&label=ffoo
        #  tcs
        put_image "https://cdn.simpleicons.org/${1}?viewbox=auto" 'height="20"'
        shift
    done
}

# for IC in "${l[@]}"; do put_image "https://skillicons.dev/icons?i=${IC}" 'height="30"' done

function put_footer {
    put_image "${ASSETS}/home.webp?raw=true"
    cat <<- EOF >> README.md
       <img height="280"
            alt="activity-graph graph"
            src="https://github-readme-activity-graph.vercel.app/graph?username=metaory&bg_color=00000000&color=4411FF&title_color=000000&line=4411FF&point=5522CC&area_color=5522CC&hide_border=true&hide_title=true&area=true&radius=20"
       />
		EOF
    put_breaker 40
}


# #########################################

put_section put_image "$ASSETS"/mxc.png
put_breaker 30
put_section put_streak_stats
put_breaker 20
put_section put_tech 'stuff I occasionally use or aspire' "${ASPIRED_TECH[@]}"
put_breaker 40
put_section put_tech 'stuff I regularly use' "${PERSONAL_TECH[@]}"
put_breaker 40
put_section put_tech 'stuff I moderately tolerate' "${TOLERATE_TECH[@]}"
put_breaker 20
put_section put_tech 'stuff I actively avoid' "${AVOID_TECH[@]}"
put_breaker 20
put_image "$ASSETS"/home.webp


# declare -a SKILLICONS=() # declare -a SKILLICONS=(deno docker github haskell md mysql nextjs nuxtjs planetsc postgres rabbitmq react redis regex replit rust sentry sqlite supabase tauri ts vercel vim zig)

# vim: ft=bash
