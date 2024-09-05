#!/bin/sh

# Parse command-line arguments
clean=false
while [ "$#" -gt 0 ]; do
  case "$1" in
    --c|-clean) clean=true; shift 1;;
    *) echo "Unknown parameter: $1"; exit 1;;
  esac
done

volumes=$(docker volume ls --format '{{.Name}}')
echo "-----------------"
for volume in $volumes
do
  containers=$(docker ps -a --filter volume="$volume" --format '{{.Names}}' | sed 's/^/  /')
  echo "Volume: $volume"

  if [ -z "$containers" ]; then
    echo "No containers using this volume"
    if [ "$clean" = true ]; then
      echo "Deleting orphaned volume: $volume"
      docker volume rm "$volume"
    fi
  else
    echo "Containers using this volume:"
    echo "$containers"
  fi

  echo "-----------------"
done