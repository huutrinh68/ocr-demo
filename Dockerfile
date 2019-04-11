FROM ubuntu:18.04

MAINTAINER trinhnh <trinhsp89@gmail.com>
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NOWARNINGS yes

RUN apt-get update
RUN apt-get install gnupg ca-certificates -y
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
RUN echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
    build-essential \
    ca-certificates \
    gcc \
    git \
    libpq-dev \
    make \
    python \
    python-pip \
    python-tk \
    python-dev \
    python3 \
    python3-pip \
    python3-tk \
    python3-dev \
    imagemagick \
    icu-devtools \
    libicu-dev \
    libsm6 \
    locales \
    logrotate \
    redis-server \
    mongodb \
    cron \
    curl \
    wget \
    vim

# tesseract, training tools, comandline tools
RUN apt-get install -y \
    tesseract-ocr \
    tesseract-ocr-jpn \
    tesseract-ocr-jpn-vert \
    tesseract-ocr-script-jpan \
    tesseract-ocr-script-jpan-vert \
    libtesseract-dev \
    g++ \
    autoconf automake libtool \
    pkg-config \
    libpng-dev \
    libjpeg8-dev \
    libtiff5-dev \
    zlib1g-dev \
    libpango1.0-dev \
    libcairo2-dev \
    libleptonica-dev

RUN pip install pillow \
    pyocr \
    pytesseract

RUN locale-gen en_US.UTF-8
RUN unlink /etc/localtime
RUN ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
ENV LANG en_US.UTF-8

RUN rm -rf /var/lib/apt/lists/* ~/.cache/pip
RUN apt-get autoremove && apt-get clean

ENV TESSDATA_PREFIX=/usr/local/share/tessdata
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
ENV PATH=$PATH:/usr/local/tesseract/bin

RUN wget https://github.com/tesseract-ocr/tessdata/raw/master/eng.traineddata -P $TESSDATA_PREFIX
RUN wget https://github.com/tesseract-ocr/tessdata/raw/master/jpn.traineddata -P $TESSDATA_PREFIX 
RUN wget https://github.com/tesseract-ocr/tessdata/raw/master/osd.traineddata -P $TESSDATA_PREFIX
RUN mkdir -p /home/work/code
ADD code /home/work/code
WORKDIR /home/work/code
RUN pip install -r requirements.txt

WORKDIR flask_server
CMD ["python", "app.py"]
#CMD ["/usr/bin/tail", "/bin/bash"]
