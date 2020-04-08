$img = $(docker ps -q) + ":/app/sampleTrace.trace.zip"
docker cp $img ./sampleTrace.trace.zip
