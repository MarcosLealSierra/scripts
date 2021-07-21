#!/usr/bin/env bash

while [[ -z $VERSION ]]; do
    read -p "version (4.1.5): " VERSION
done

cd /tmp

wget https://download.electrum.org/${VERSION}/Electrum-${VERSION}.tar.gz
wget https://download.electrum.org/${VERSION}/Electrum-${VERSION}.tar.gz.ThomasV.asc
wget https://download.electrum.org/${VERSION}/Electrum-${VERSION}.tar.gz.sombernight_releasekey.asc

gpg --verify Electrum-${VERSION}.tar.gz.ThomasV.asc Electrum-${VERSION}.tar.gz
if [ $? -eq 0 ]; then
    tar -xvzf Electrum-${VERSION}.tar.gz
    cd /tmp/Electrum-${VERSION}
    python3 -m pip install --user .[gui,crypto]
fi
