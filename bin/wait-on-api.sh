#!/bin/bash

waited_seconds=0
message_shown_count=0
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'
i=1
sp="/-\|"

until nc -z localhost 3000
do
  if ((waited_seconds > 40))
  then
    if ((message_shown_count == 0))
    then
      echo -e "${RED}[WARNING]${NC} The api took more than 10 seconds to show up."
      echo -e "Run: ${YELLOW}docker-compose logs api${NC} to investigate the issue."
      echo -e "The fix is often to run ${YELLOW}make database${NC}, ${YELLOW}make migrate${NC}"
      message_shown_count=1
    fi
  fi

  echo -ne "...waiting for api ${GREEN}\b${sp:i++%${#sp}:1} ${NC}\r"
  sleep 0.25
  waited_seconds=$((waited_seconds + 1))
done
