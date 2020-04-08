$trace = $(docker ps -q) + ":/app/trace.nettrace"
docker cp $trace ./trace.nettrace

$speedscope = $(docker ps -q) + ":/app/trace.speedscope.json"
docker cp $speedscope ./trace.speedscope.json
