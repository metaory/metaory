#!/bin/bash
# set -Eeuo pipefail

:>README.md

# declare ASSETS=https://github.com/metaory/metaory/blob/master/.github/assets
declare ASSETS=https://raw.githubusercontent.com/metaory/metaory/master/.github/assets

declare -a ASPIRED_TECH=(
    c
    cmake
    cplusplus
    framework7
    kubernetes
    leptos
    hyperland
    creativecommons
    adventofcode
    k3s
    elixir
    erlang
    gnu
    houdini
    htmx
    libuv
    crunchbase
    linuxfoundation
    llvm
    mapbox
    ocaml
    opel
    opencollective
    openfaas
    opengl
    openid
    openjsfoundation
    openssl
    prometheus
    redis
    rust
    snowflake
    spacex
    steam
    steamdb
    trivy
    turso
    v8
    valve
    webassembly
    zig
)
declare -a AVOID_TECH=(
    dotnet
    atlassian
    grunt
    gulp
    bitbucket
    facebook
    bitcoin
    heroku
    hibernate
    instagram
angular
    chef
    dynatrace
    githubcopilot
    eclipseide
    jira
    jirasoftware
    jquery
    jenkins
    jest
    firebase
    django
    lodash
    ansible
)
declare -a PERSONAL_TECH=(
    alacritty
    elastic
    gitter
    awesomewm
    caldotcom
    alpinelinux
    authy
    archlinux
    asciidoctor
    dotenv
    koa
    giphy
    githubpages
    gitter
    gimp
    cssmodules
    curl
    githubactions
    darkreader
    asciinema
    gravatar
    headlessui
    astro
    biome
    fastapi
    lightning
    linear
    bun
    fontbase
    deno
    docusaurus
    elasticsearch
    letsencrypt
    envoyproxy
    excalidraw
    ffmpeg
    git
    github
    gitkraken
    gnubash
    go
    graphite
    hoppscotch
    dota2
    docker
    hotjar
    drizzle
    devrant
    duckduckgo
    iconify
    ifttt
    inkscape
    javascript
    jsonwebtokens
    jsr
    knowledgebase
    less
    libreoffice
    linux
    linuxcontainers
    linuxserver
    commitlint
    logseq
    loom
    lua
    make
    man
    meta
    microstrategy
    miro
    mpv
    neovim
    nixos
    notion
    npm
    obsidian
    postgresql
    prettier
    puppeteer
    qmk
    readme
    runkit
    semver
    sentry
    shell
    stencil
    lucia
    suckless
    svelte
    svg
    tails
    tmux
    travisci
    tui
    unicode
    wezterm
    yaml
    zsh
    excalidraw
    brave
    markdown
    lit
    css3
    gtk
    cloudflarepages
)

declare -a TOLERATE_TECH=(
    amazon amazonapigateway amazoncloudwatch amazoncognito amazondocumentdb amazondynamodb amazonec2 amazonecs amazoneks amazonelasticache amazoniam amazonroute53 amazons3 amazonsimpleemailservice amazonsqs amazonwebservices awslambda awsorganizations awssecretsmanager
    backbonedotjs
    clerk
    clickup
    buildkite
    crowdin
    cloudflare
    express
    codesandbox
    esbuild
    creality
    discord
    genius
    google
    datadog
    debian
    auth0
    googlechrome
    awsamplify
    jetbrains
    grafana
    graphql
    hcl
    html5
    icon
    logstash
    openvpn
    owasp
    pwa
    react
    snyk
    stripe
    supabase
    terraform
    googlecloud
    axios
    trpc
    twilio
    twitch
    typescript
    upstash
    circleci
    vercel
    less
    mailchimp
    sass
    vue
    xo
)

declare -a SHADES=('000000,110022,110033' '110033,110022,110022,110033' '110033,110022,000000')

function put_breaker {
    cat <<- EOF >> README.md
		<div align="center">
  		<img width="${1:-50}%" src="${ASSETS}/hr$((RANDOM%3)).png?raw=true"  />
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
put_section put_tech 'stuff I occasionally use and aspire' "${ASPIRED_TECH[@]}"
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
