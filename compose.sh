#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Usage: $0 [up|down|infras-up|plugin-up|plugin-it-up|...]" >&2
  exit 1
fi

set -Eeo pipefail

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

COMPOSE_INFRAS_PATH="docker-compose/docker-compose.infras.yaml"
COMPOSE_PLUGIN_PATH="docker-compose/docker-compose.plugin.yaml"
COMPOSE_PLUGIN_IT_PATH="docker-compose/docker-compose.plugin-it.yaml"


for arg in "$@"
do
    case "$arg" in
        # up and down mapped to infras + plugin_it
        "up")
            shift
            detach_option=""; if [ "$1" = "-d" ]; then detach_option=$1; shift; fi
            cmd="docker compose -f $COMPOSE_INFRAS_PATH -f $COMPOSE_PLUGIN_IT_PATH up --remove-orphans $detach_option --build $@"
            echo -e "$cmd"
            $cmd
            ;;
        "down")
            shift
            cmd="docker compose -f $COMPOSE_INFRAS_PATH -f $COMPOSE_PLUGIN_IT_PATH down --remove-orphans $@"
            echo -e "$cmd"
            $cmd
            ;;

        "infras-up")
            shift
            detach_option=""; if [ "$1" = "-d" ]; then detach_option=$1; shift; fi
            cmd="docker compose -f $COMPOSE_INFRAS_PATH -p cc-infras up --remove-orphans $detach_option --build $@"
            echo -e "$cmd"
            $cmd
            ;;
        "infras-down")
            shift
            cmd="docker compose -f $COMPOSE_INFRAS_PATH -p cc-infras down --remove-orphans $@"
            echo -e "$cmd"
            $cmd
            ;;

        "plugin-up")
            shift
            detach_option=""; if [ "$1" = "-d" ]; then detach_option=$1; shift; fi
            cmd="docker compose -f $COMPOSE_PLUGIN_PATH -p cc-plugin up --remove-orphans $detach_option --build $@"
            echo -e "$cmd"
            $cmd
            ;;
        "plugin-down")
            shift
            cmd="docker compose -f $COMPOSE_PLUGIN_PATH -p cc-plugin down --remove-orphans $@"
            echo -e "$cmd"
            $cmd
            ;;

        "plugin-it-up")
            shift
            detach_option=""; if [ "$1" = "-d" ]; then detach_option=$1; shift; fi
            cmd="docker compose -f $COMPOSE_PLUGIN_IT_PATH -p cc-plugin up --remove-orphans $detach_option --build $@"
            echo -e "$cmd"
            $cmd
            ;;
        "plugin-it-down")
            shift
            cmd="docker compose -f $COMPOSE_PLUGIN_IT_PATH -p cc-plugin down --remove-orphans $@"
            echo -e "$cmd"
            $cmd
            ;;

        "watch")
            shift
            cmd="docker compose -f $COMPOSE_INFRAS_PATH -f $COMPOSE_PLUGIN_PATH up --remove-orphans --build --watch $@"
            echo -e "$cmd"
            $cmd
            ;;
        "logs")
            shift
            cmd="docker compose -f $COMPOSE_INFRAS_PATH -f $COMPOSE_PLUGIN_PATH logs -f $@"
            echo -e "$cmd"
            $cmd
            ;;
        "volume-prune")
            cmd="docker compose -f $COMPOSE_INFRAS_PATH -p cc-infras down --remove-orphans -v && \
                 docker compose -f $COMPOSE_PLUGIN_PATH -p cc-plugin down --remove-orphans -v && \
                 docker compose -f $COMPOSE_PLUGIN_IT_PATH -p cc-plugin down --remove-orphans -v"
            echo -e "$cmd"
            bash -c "$cmd"
            ;;
    esac
done

exit 0
