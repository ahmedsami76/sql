FROM ubuntu:latest
LABEL maintainer="hazem omar hazem.ay=twwa@gmail.com"
WORKDIR /usr/local/ 
RUN apt-get update && \ 
    apt-get upgrade
SHELL [ "/bin/bash" , "-o" ]
RUN  apt install mysql-server 
RUN service mysql start

ENTRYPOINT [ "/bin/bash" ]
CMD [ "mysql" ]
