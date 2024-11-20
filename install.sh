#!/bin/sh

set -eux
wget --no-check-certificate -qO- https://apt.hyperion-project.org/hyperion.pub.key | gpg --dearmor -o /usr/share/keyrings/hyperion.pub.gpg
if [ "${RELEASE_TYPE}" = "nightly" ]; then
    echo "Installing Hyperion Nightly"
    echo "deb [signed-by=/usr/share/keyrings/hyperion.pub.gpg] https://nightly.apt.releases.hyperion-project.org/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hyperion.nightly.list
else
    echo "Installing Hyperion Stable"
    echo "deb [signed-by=/usr/share/keyrings/hyperion.pub.gpg] https://apt.hyperion-project.org/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hyperion.list
fi
apt-get update
apt-get install -y hyperion
apt-get clean -q -y
apt-get autoremove -y
rm -rf /var/lib/apt/lists/*
