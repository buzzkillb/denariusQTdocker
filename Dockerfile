FROM ubuntu:16.04 as builder

LABEL author="buzzkillb"
RUN apt-get update && apt-get install -y \
git \
wget \
unzip \
automake \
build-essential \
libssl-dev \
libdb++-dev \
libboost-all-dev \
libqrencode-dev \
libminiupnpc-dev \
libevent-dev \
autogen \
automake \
libtool \
make \
libqt5gui5 \
libqt5core5a \
libqt5dbus5 \
qttools5-dev \
qttools5-dev-tools \
qt5-default \
&& rm -rf /var/lib/apt/lists/*
RUN (git clone https://github.com/carsenk/denarius && \
cd denarius && \
git checkout v3.4 && \
git pull && \
qmake "USE_UPNP=1" "USE_QRCODE=1" denarius-qt.pro && \
make)

# final image
FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
automake \
build-essential \
libssl-dev \
libdb++-dev \
libboost-all-dev \
libqrencode-dev \
libminiupnpc-dev \
libevent-dev \
libtool \
libqt5gui5 \
libqt5core5a \
libqt5dbus5 \
qttools5-dev \
qttools5-dev-tools \
qt5-default \
&& rm -rf /var/lib/apt/lists/*

VOLUME /denarius

COPY --from=builder /denarius/Denarius /usr/local/bin/

ENV DISPLAY=:0
ENV QT_GRAPHICSSYSTEM="native"

CMD ["/usr/local/bin/Denarius", "-datadir=/denarius"]
