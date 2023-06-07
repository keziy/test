#!/bin/sh

python3 makeHosts.py && \
python3 testUpdateHostsFile.py && \
python3 updateHostsFile.py -a -e fakenews gambling social -m -x blacklist -o build
