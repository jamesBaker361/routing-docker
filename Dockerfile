# syntax=docker/dockerfile:1
FROM ubuntu:latest


ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update && apt-get install -y -f \
	curl \
	osmctools \
	wget \
	build-essential \
	cmake \
	python3 \
	libboost-all-dev \
	libcairo2-dev \
	libcgal-dev \
	libproj-dev \
	git-all \
	gdb \
	jupyter-notebook \
	jupyter \
	python3-pip \
	zlib1g-dev

RUN pip install osmnx

COPY routing-framework /routing-framework

#RUN git clone https://github.com/LBNL-UCB-STI/routing-framework.git

SHELL ["/bin/bash", "-c"]
WORKDIR routing-framework/External

RUN git clone https://github.com/RoutingKit/RoutingKit.git
RUN git clone https://github.com/ben-strasser/fast-cpp-csv-parser.git
RUN git clone https://github.com/vectorclass/version2.git

#RUN rmdir vectorclass
RUN mv version2 vectorclass

RUN  cd fast-cpp-csv-parser && cp *.h /usr/local/include && cd .. && \
		cd rapidxml && cp *.hpp /usr/local/include && cd .. && \
     cd randomc && mkdir /usr/local/include/randomc && cp *.cpp *.h $_ && cd .. && \
     cd RoutingKit && make && cp -r include lib /usr/local && cd .. && \
     cd stocc && mkdir /usr/local/include/stocc && cp *.cpp *.h $_ && cd .. \
      && cd vectorclass && mkdir /usr/local/include/vectorclass && cp *.h $_ && cd ..

WORKDIR /routing-framework

RUN cmake -S . -B Build/Devel && cmake --build Build/Devel

ENV PATH=/routing-framework/data/beamville:/routing-framework/Build/Devel/Launchers:/routing-framework/Build/Devel/RawData:${PATH}

WORKDIR /