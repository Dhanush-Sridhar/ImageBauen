https://github.com/wokis/raspberrypi/blob/master/rpi-debootstrap.sh
https://gitlab.com/yaegashi/raspi-debootstrap/-/blob/master/build.sh


https://gist.github.com/WilsonQueirozdeOliveira/185bec3d98f2e42a036e2126a9474c62

FROM ubuntu:20.04

LABEL description="Build the capcontrol binary for PURE machine."

RUN apt update && apt upgrade -y

ARG PACKAGES="bison build-essential gperf flex python2 ninja-build perl python git g++ wget"

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y $PACKAGES 

RUN echo "Build Qt from source"
RUN wget https://download.qt.io/archive/qt/5.15/5.15.1/single/qt-everywhere-src-5.15.1.tar.xz
#COPY qt-everywhere-src-5.15.1 /root/qt5
WORKDIR /root/qt5
RUN mkdir build
WORKDIR /root/qt5/build

RUN ../configure -confirm-license -opensource -nomake examples -nomake tests
#RUN ../configure -confirm-license -commercial -nomake examples -nomake tests
RUN make -j$(nproc); echo "DONE"
RUN make -j$(nproc) install; echo "DONE"
