/usr/bin/perf_4.9 record  -g -F 997 -p $(pidof dotnet) -- sleep 30
/usr/bin/perf_4.9 script -i ./perf.data | FlameGraph/stackcollapse-perf.pl | FlameGraph/flamegraph.pl > perf_example.svg