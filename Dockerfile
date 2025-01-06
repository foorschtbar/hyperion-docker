# ubuntu:jammy is LTS and will be supported until 2027/04
FROM ubuntu:jammy 
ARG RELEASE_TYPE=STABLE

# Preventing debconf errors
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
# Checkout https://github.com/hyperion-project/hyperion.docker-ci/blob/master/ubuntu_debian for changes
RUN set -eux; \
    apt-get update ; \
    apt-get upgrade -y ; \
    apt-get install -y \
    wget \
    gnupg \
    dirmngr \
    libgnutls30 \
    lsb-release \
    apt-transport-https \
    ca-certificates \
    libqt5sql5-sqlite \
    openssl  \
    libx11-6 \
    libusb-1.0-0  \
    libftdi1-2 \
    libexpat-dev  \
    libgl-dev  \
    libfreetype6 \
    libpython3.10; \
    apt-get clean -q -y ; \
    apt-get autoremove -y ; \
    rm -rf /var/lib/apt/lists/*

# Install latest Hyperion
COPY install.sh .
RUN chmod +x install.sh && ./install.sh && rm install.sh

EXPOSE 8090 8092 19400 19444 19445 

ENTRYPOINT "/usr/bin/hyperiond"
