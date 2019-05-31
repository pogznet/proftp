FROM ubuntu

RUN apt-get update -y
RUN apt-get install -y default-jdk
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:openjdk-r/ppa -y
RUN apt update -y
RUN apt install -y openjdk-11-jdk
RUN apt-get install -y proftpd

ADD launch /launch
ADD proftpd.conf /etc/proftpd/proftpd.conf
RUN chown root:root /etc/proftpd/proftpd.conf
RUN groupadd ftp
RUN usermod -a -G ftp ftp
RUN mkdir /ftp
RUN mkdir /rawdata
RUN mkdir /rawdata/rx
RUN mkdir /rawdata/invalid
RUN chown -R ftp:ftp /rawdata/rx

VOLUME /rawdata

EXPOSE 21
EXPOSE 20

ENTRYPOINT /launch
