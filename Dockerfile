FROM docker.io/python:3.9.17-alpine

ENV LANG en_US.utf-8
ENV LC_ALL en_US.utf-8

RUN apk add --no-cache git sudo wget && \
    git clone https://github.com/StevenBlack/hosts.git && \
    wget -q -O hosts/myhosts https://raw.githubusercontent.com/kenbat/gh/master/hosts

COPY blacklist /hosts
COPY data/* /hosts/data

RUN pip install --no-cache-dir --upgrade -r /hosts/requirements.txt

WORKDIR /hosts

RUN python makeHosts.py && \
    python testUpdateHostsFile.py && \
    python updateHostsFile.py -a -e fakenews gambling social -m -x blacklist -o build
