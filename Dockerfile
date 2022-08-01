# syntax=docker/dockerfile:1
FROM ubuntu:22.04

# User env variables
ENV USER=neutrino
ENV PASS=qwe
ENV HOME=/home/${USER}
ENV VNC_PORT=6969

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt install -y --no-install-recommends --allow-unauthenticated \
    wget g++ make cmake \
    libx11-dev libgl1-mesa-dev mesa-common-dev \
    sudo supervisor xvfb x11vnc \
    dbus-x11 psmisc xdg-utils \
    xfce4 xfce4-goodies \
    x11-xserver-utils x11-utils x11-apps mesa-utils \
    && apt autoclean -y && apt autoremove -y && rm -rf /var/lib/apt/lists/*

# Add user
RUN useradd -rm -d ${HOME} -s /bin/bash -g root -G sudo -u 1001 ${USER} \
    && echo "root:${PASS}"    | chpasswd \
    && echo "${USER}:${PASS}" | chpasswd

# Set password for vnc
RUN x11vnc -storepasswd "${PASS}" /etc/x11vnc.pass
RUN chmod ugo+r /etc/x11vnc.pass

# Add some configs and files
ADD fluxbox_init /etc/fluxbox_init
ADD supervisord.conf /root
ADD startup.sh /root

# Access rights
RUN chmod a+rx /root/startup.sh

# Set user and home directory for xfce
RUN sed -i "s|\$USER|${USER}|g" /root/supervisord.conf
RUN sed -i "s|\$HOME|${HOME}|g" /root/supervisord.conf

EXPOSE ${VNC_PORT}

# Add xterm in fluxbox menu 
CMD ["/root/startup.sh"]
