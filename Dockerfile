FROM ubuntu:xenial

LABEL authors="Isaac (Ike) Arias <ikester@gmail.com>"

RUN apt-get update && \
	apt-get install -y \
		curl \
		bzip2 \
		libfreetype6 \
		libgl1-mesa-dev \
		libglu1-mesa \
		libxi6 \
		libxrender1 && \
	apt-get -y autoremove && \
	rm -rf /var/lib/apt/lists/*

ENV BLENDER_MAJOR 2.79
ENV BLENDER_VERSION 2.79
ENV BLENDER_BZ2_URL https://mirror.clarkson.edu/blender/release/Blender$BLENDER_MAJOR/blender-$BLENDER_VERSION-linux-glibc219-x86_64.tar.bz2

RUN mkdir /usr/local/blender && \
	curl -SL "$BLENDER_BZ2_URL" -o blender.tar.bz2 && \
	tar -jxvf blender.tar.bz2 -C /usr/local/blender --strip-components=1 && \
	rm blender.tar.bz2

# add the google cloud sdk
#ENV CLOUD_SDK_VERSION 178.0.0

# ARG INSTALL_COMPONENTS
# RUN apt-get update -qqy && apt-get install -qqy \
#         curl \
#         gcc \
#         python-dev \
#         python-setuptools \
#         apt-transport-https \
#         lsb-release \
#         openssh-client \
#         git \
#     && easy_install -U pip && \
#     pip install -U crcmod && \
#     export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
#     echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" > /etc/apt/sources.list.d/google-cloud-sdk.list && \
#     curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
#     apt-get update && apt-get install -y google-cloud-sdk=${CLOUD_SDK_VERSION}-0 $INSTALL_COMPONENTS && \
#     gcloud config set core/disable_usage_reporting true && \
#     gcloud config set component_manager/disable_update_check true && \
#     gcloud config set metrics/environment github_docker_image && \
#     gcloud --version
# VOLUME ["/root/.config"]

# build our go app
FROM golang:1.7

#RUN go get -u cloud.google.com/go/storage

RUN mkdir -p /app

WORKDIR /app

ADD . /app

#RUN go build ./app.go

CMD ["./app", "-o=blenderfiles:hello.txt", "write"]

#VOLUME /media
#ENTRYPOINT ["/usr/local/blender/blender", "-b"]