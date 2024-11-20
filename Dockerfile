FROM ubuntu:noble

# Install dependencies
RUN set -eux; \
    apt-get update ; \
    apt-get upgrade -y ; \
    apt-get install -y \
    wget \
    gnupg \
    dirmngr \
    libgnutls30 \
    lsb-release \
    ca-certificates \
    libqt5sql5-sqlite \
    openssl  \
    libx11-6 \
    libusb-1.0-0  \
    libexpat-dev  \
    libgl-dev  \
    libfreetype6 \
    libpython3.10; \
    apt-get clean -q -y ; \
    apt-get autoremove -y ; \
    rm -rf /var/lib/apt/lists/*

# Install latest Hyperion
RUN set -eux; \
    wget --no-check-certificate -qO- https://apt.hyperion-project.org/hyperion.pub.key | gpg --dearmor -o /usr/share/keyrings/hyperion.pub.gpg;\
    echo "deb [signed-by=/usr/share/keyrings/hyperion.pub.gpg] https://apt.hyperion-project.org/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hyperion.list;\
    apt-get update ; \
    apt-get install -y hyperion; \
    apt-get clean -q -y ; \
    apt-get autoremove -y ; \
    rm -rf /var/lib/apt/lists/*

EXPOSE 8090 8091 19444 19445 

ENTRYPOINT "/usr/bin/hyperiond"