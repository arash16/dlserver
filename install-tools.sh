#!/bin/sh -e
set -xe

function gh_latest() {
  curl -s https://api.github.com/repos/$1/releases/latest \
  | grep -m1 "browser_download_url$2" \
  | cut -d : -f 2,3 \
  | tr -d \" \
  | wget -O $3 -i -
}

cd /tmp
gh_latest aria2/aria2 ".*tar\\.gz" aria2.tar.gz
tar -xvf aria2.tar.gz
cd $(ls -d aria2-*)
./configure
make install

cd /tmp
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl

which aria2c
which youtube-dl

rm -rf /tmp
