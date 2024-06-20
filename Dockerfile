FROM  python:3.12-slim

# Unfortunately OBuilder (which Shark is based on) assumes /usr/bin/env, so we have
# to bloat the container with coreutils.
RUN apt-get update -qqy && \
	apt-get install -qy \
		coreutils \
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
