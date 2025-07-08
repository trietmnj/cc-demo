#!/bin/bash

set -Eeo pipefail

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

COMPOSECMD_INFRAS="docker compose -f docker-compose/docker-compose.infras.yaml"
COMPOSECMD_PLUGIN="docker compose -f docker-compose/docker-compose.plugin.yaml"
COMPOSECMD_PLUGIN_IT="docker compose -f docker-compose/docker-compose.plugin-it.yaml"


for arg in "$@"
do
    case "$arg" in
        "up")
            shift
            detach_option=""; if [ "$1" = "-d" ]; then detach_option=$1; shift; fi
            cmd="$COMPOSECMD_INFRAS -f docker-compose/docker-compose.plugin.yaml up --remove-orphans $detach_option --build $@"
            echo -e "$cmd"
            $cmd
            ;;
        "infras-up")
            shift
            detach_option=""; if [ "$1" = "-d" ]; then detach_option=$1; shift; fi
            cmd="$COMPOSECMD_INFRAS -p cc-infras up --remove-orphans $detach_option --build $@"
            echo -e "$cmd"
            $cmd
            ;;
        "plugin-up")
            shift
            detach_option=""; if [ "$1" = "-d" ]; then detach_option=$1; shift; fi
            cmd="$COMPOSECMD_PLUGIN -p cc-plugin up --remove-orphans $detach_option --build $@"
            echo -e "$cmd"
            $cmd
            ;;
        "plugin-it-up")
            shift
            detach_option=""; if [ "$1" = "-d" ]; then detach_option=$1; shift; fi
            cmd="$COMPOSECMD_PLUGIN_IT -p cc-plugin up --remove-orphans $detach_option --build $@"
            echo -e "$cmd"
            $cmd
            ;;
        "down")
            shift
            cmd="$COMPOSECMD_INFRAS -f docker-compose/docker-compose.plugin.yaml -f docker-compose/docker-compose.plugin-it.yaml down --remove-orphans $@"
            echo -e "$cmd"
            $cmd
            ;;
        "infras-down")
            shift
            cmd="$COMPOSECMD_INFRAS down --remove-orphans $@"
            echo -e "$cmd"
            $cmd
            ;;
        "plugin-down")
            shift
            cmd="$COMPOSECMD_PLUGIN down --remove-orphans $@"
            echo -e "$cmd"
            $cmd
            ;;
        "watch")
            shift
            cmd="$COMPOSECMD_INFRAS -f docker-compose/docker-compose.plugin.yaml up --remove-orphans --build --watch $@"
            echo -e "$cmd"
            $cmd
            ;;
        "logs")
            shift
            cmd="$COMPOSECMD_INFRAS -f docker-compose/docker-compose.plugin.yaml logs -f $@"
            echo -e "$cmd"
            $cmd
            ;;
        "volume-prune")
            cmd="$COMPOSECMD_INFRAS down --remove-orphans -v"
            echo -e "$cmd"
            $cmd
            ;;
    esac
done

exit 0
