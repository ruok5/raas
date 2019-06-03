FROM perl:5.30

MAINTAINER brad@fyvm.org

RUN cpanm AVAR/Hailo-0.75.tar.gz

CMD ["echo", "Made it to the CMD part!"]