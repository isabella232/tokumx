FROM ubuntu:trusty
MAINTAINER Ankur Chauhan  <ankur@malloc64.com>

# Install TokuMX
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key 505A7412
RUN echo "deb [arch=amd64] http://s3.amazonaws.com/tokumx-debs trusty main" | tee /etc/apt/sources.list.d/tokumx.list
RUN apt-get update
RUN apt-get install -y tokumx
RUN sed -i'' -e '/logpath/d' /etc/tokumx.conf
RUN rm -rf /var/lib/apt/lists/*

# Define mountable directories.
VOLUME ["/data/db"]

# Define working directory.
WORKDIR /data

COPY ./entrypoint.sh /

# Define default command.
ENTRYPOINT ["/entrypoint.sh"]

# Expose ports [ process port and http port ]
EXPOSE 27017
EXPOSE 28017
