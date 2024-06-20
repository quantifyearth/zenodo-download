FROM  python:3.12-slim

RUN apt-get update -qqy && \
	apt-get install -qy \
		git \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /var/cache/apt/*

RUN pip install --upgrade pip
COPY requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt

COPY ./ /root/
WORKDIR /root/

RUN pylint *.py

RUN chmod 755 *.py
