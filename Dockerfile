FROM ubuntu:14.04
MAINTAINER Me <me@gdomod.de>

# Keep image updated

RUN apt-get update -yq && \
    apt-get install -yq python3 python3-pip git-core  && \
    apt-get clean -y && \
    apt-get autoremove -y


RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN pip3 install --upgrade setuptools
RUN mkdir -p /usr/share/onedrive-d
RUN git clone https://github.com/xybu/onedrive-d /usr/share/onedrive-d

RUN cd /usr/share/onedrive-d/ && python3 setup.py build
RUN cd /usr/share/onedrive-d/ && python3 setup.py install

RUN mkdir /root/.onedrived
COPY odignore.txt /root/.onedrived/

COPY start /
RUN chmod a+x /start

#CMD ["/start"]
CMD ["/bin/bash"]

