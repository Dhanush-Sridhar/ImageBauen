FROM ubuntu:20.04
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ARG USER=dhanush
ARG UID=1000
ARG GID=1000

RUN apt-get update
RUN apt-get install --yes git build-essential gcc g++ gperf bison flex texinfo help2man make libncurses5-dev libisl-dev autoconf automake libtool libtool-bin gawk wget bzip2 xz-utils unzip patch curl libstdc++6 m4 binutils dh-autoreconf libcunit1-ncurses libexpat1-dev python-dev sudo zsh rsync vim cmake ninja-build libxkbcommon0 libgl1-mesa-dev libfontconfig1-dev libdbus-1-dev
RUN apt-get clean --yes && rm -rf /var/lib/apt/lists/*


RUN useradd -m ${USER} --uid=${UID} && echo "${USER}:${USER}" | chpasswd && adduser ${USER} sudo
RUN echo "Set disable_coredump false" >> /etc/sudo.conf
RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN echo "%${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${UID}:${GID}
WORKDIR /home/${USER}
