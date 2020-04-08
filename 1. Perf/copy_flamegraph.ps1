$img = $(docker ps -q) + ":/app/perf_example.svg"
docker cp $img ./perf_examle.svg
