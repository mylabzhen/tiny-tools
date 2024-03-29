 #!/usr/bin/env bash

# NOTE: support only one process

_term() {
  echo "caught SIGTERM, kill $child"
  kill -TERM "$child" 2>/dev/null
}

trap _term SIGTERM

SECONDS=0
"$@" &
child=$!
psrecord ${child} --interval 1 --plot mrun_${child}.png --log mrun_${child}.log &
wait ${child}
echo $SECONDS "sec(s) elapsed"
