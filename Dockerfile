# -*- mode: dockerfile -*-
# vi: set ft=dockerfile :

FROM ubuntu:bionic
RUN apt-get update -qq \
    && apt-get install --no-install-recommends -qy \
         git ca-certificates build-essential cmake-curses-gui \
         lsb-release python3.7 python3.7-dev python3-pip python3-setuptools python3-wheel \
         g++ unzip zlib1g-dev wget \
    && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/RobotLocomotion/drake /drake
RUN export DEBIAN_FRONTEND=noninteractive \
    && yes | /drake/setup/ubuntu/install_prereqs.sh \
    && rm -rf /var/lib/apt/lists/*
# Fix Python3.6 to 3.7
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1
RUN pip3 install --upgrade --force-reinstall numpy matplotlib pydot scipy tk tornado msgpack pyyaml pyzmq lxml ipywidgets
RUN mkdir /drake/build \
    && cd drake/build \
    && cmake .. && make -j4
RUN cd /drake/build/ && tar -zcvf /drake_bionic_py37.tar.gz ./install --transform s/install/drake/
#RUN apt-get update -qq \
#    && apt-get install --no-install-recommends -qy \
#         $(cat /drake/setup/ubuntu/source_distribution/packages-bionic.txt) \
#    && rm -rf /var/lib/apt/lists/*
#RUN wget "https://releases.bazel.build/4.1.0/release/bazel_4.1.0-linux-x86_64.deb" -O /tmp/bazel.deb \
#    && dpkg -i /tmp/bazel.deb \
#    && rm /tmp/bazel.deb
