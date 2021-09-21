# -*- mode: dockerfile -*-
# vi: set ft=dockerfile :

FROM ros:noetic-robot
RUN apt-get update -qq \
    && apt-get install --no-install-recommends -qy \
         git ca-certificates build-essential cmake-curses-gui \
         lsb-release python3-dev python3-pip python3-setuptools python3-wheel \
         g++ unzip zlib1g-dev wget \
    && rm -rf /var/lib/apt/lists/*
RUN git clone --branch icra2022_changes https://github.com/gizatt/drake /drake
RUN export DEBIAN_FRONTEND=noninteractive \
    && yes | /drake/setup/ubuntu/install_prereqs.sh \
    && rm -rf /var/lib/apt/lists/*
RUN pip3 install --upgrade --force-reinstall numpy matplotlib pydot scipy tk tornado msgpack pyyaml pyzmq lxml ipywidgets
RUN mkdir /drake/build \
    && cd drake/build \
    && cmake .. && make -j4
RUN cd /drake/build/ && tar -zcvf /drake_focal.tar.gz ./install --transform s/install/drake/
#RUN apt-get update -qq \
#    && apt-get install --no-install-recommends -qy \
#         $(cat /drake/setup/ubuntu/source_distribution/packages-bionic.txt) \
#    && rm -rf /var/lib/apt/lists/*
#RUN wget "https://releases.bazel.build/4.1.0/release/bazel_4.1.0-linux-x86_64.deb" -O /tmp/bazel.deb \
#    && dpkg -i /tmp/bazel.deb \
#    && rm /tmp/bazel.deb
