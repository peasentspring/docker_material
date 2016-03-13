FROM ubuntu:14.04
MAINTAINER peasant <zhaowenjia1989@126.com>
RUN apt-get update && apt-get install -y vim && apt-get install -y make && useradd -m -d /home/myuser -p myuser myuser && chsh -s /bin/bash myuser
WORKDIR /home/myuser
CMD ["/bin/bash"]

