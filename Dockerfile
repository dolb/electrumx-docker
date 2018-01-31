FROM python:3.6.4-jessie
# Prepare user
RUN useradd -ms /bin/bash zcluser
WORKDIR /home/zcluser

# Install dependencies
RUN apt-get update
RUN apt-get install -y apt-utils libleveldb1 libleveldb-dev \
                       build-essential pkg-config libc6-dev m4 \
                       g++-multilib autoconf libtool ncurses-dev \
                       unzip git python zlib1g-dev wget bsdmainutils \
                       automake sudo

# Install electrumx dependencies
RUN pip install pylru==1.0.9 \
&& pip install aiohttp==1.0.5 \
&& pip install x11_hash==1.4 \
&& pip install plyvel==0.9

# Define mandatory volumes

VOLUME /home/zcluser/zcl_electrum_db
VOLUME /home/zcluser/.zclassic
VOLUME /home/zcluser/.zcash-params


# Build zcl node daemon

RUN git clone https://github.com/z-classic/zclassic
RUN /home/zcluser/zclassic/zcutil/build.sh -j$(nproc)

RUN /home/zcluser/zclassic/zcutil/fetch-params.sh

RUN git clone https://github.com/BTCP-community/electrumx.git
RUN wget -q https://github.com/z-classic/zclassic/releases/download/Config/zclassic.conf
RUN sed -ie '/^rpcport=8232/a txindex=1' zclassic.conf

COPY elextrumx-server /usr/bin/electrumx-server
COPY docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
RUN chmod +x /usr/bin/electrumx-server && chmod +x /usr/bin/docker-entrypoint.sh

EXPOSE 50002

RUN echo DEFAULT_RPCUSER="zcluser" > /home/zcluser/config \
&& echo DEFAULT_RPCPASS="default_pass" >> /home/zcluser/config \
&& echo VK_SHA256="4bd498dae0aacfd8e98dc306338d017d9c08dd0918ead18172bd0aec2fc5df82" >> /home/zcluser/config \
&& echo PK_SHA256="8bc20a7f013b2b58970cddd2e7ea028975c88ae7ceb9259a5344a16bc2c0eef7" >> /home/zcluser/config

ENV CUSTOM_USER="zcluser"

ENTRYPOINT ["docker-entrypoint.sh"]
