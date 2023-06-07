FROM docker.io/python:3-alpine

RUN apk add --no-cache git sudo wget && \
    git clone https://github.com/StevenBlack/hosts.git && \
    wget -q -O hosts/myhosts https://raw.githubusercontent.com/kenbat/gh/master/hosts 
	
COPY blacklist /hosts
COPY build /hosts/build
COPY data/* /hosts/data/
COPY entrypoint.sh /hosts

RUN pip install --no-cache-dir --upgrade -r /hosts/requirements.txt

WORKDIR /hosts

RUN chmod +x entrypoint.sh
CMD [ "/entrypoint.sh" ]	
