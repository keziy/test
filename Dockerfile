FROM docker.io/python:3-alpine

RUN apk add --no-cache git sudo wget && \
    git clone https://github.com/StevenBlack/hosts.git && \
    wget -q -O hosts/myhosts https://raw.githubusercontent.com/kenbat/gh/master/hosts 
	
COPY blacklist /hosts
#COPY build /hosts
COPY data/* /hosts/data

RUN pip install --no-cache-dir --upgrade -r /hosts/requirements.txt

WORKDIR /hosts

RUN python3 makeHosts.py && \
    python3 testUpdateHostsFile.py && \
    python3 updateHostsFile.py -a -e fakenews gambling social -m -x blacklist -o build
