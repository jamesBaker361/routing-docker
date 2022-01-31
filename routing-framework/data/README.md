1. Convert OSM file to binary file

Build/Devel/RawData/ConvertGraph -s osm -d binary -a capacity coordinate free_flow_speed lat_lng length -i data/beamville/beamville -o graph 

we can check defination of input attribute using following command

Build/Devel/RawData/ConvertGraph -h


2. Generate OD Pair file

Build/Devel/RawData/GenerateODPairs -n 100 -r 1 -d 10 -geom -g data/beamville/graph.gr.bin -o od-pairs


we can check defination of input attribute using following command

Build/Devel/RawData/GenerateODPairs -h

3. Assign traffic

Build/Devel/Launchers/AssignTraffic -so -l -i -v -o random -n 5 -a Dijkstra -g graph.gr.bin -d od-pairs.csv -flow flow -dist dist -stat stat

we can check defination of input attribute using following command

Build/Devel/Launchers/AssignTraffic -h