FROM nginx:stable

LABEL authors https://www.oda-alexandre.com

ENV USER www
ENV HOME /home/${USER}
ENV PORTS 80
ENV DEBIAN_FRONTEND noninteractive

RUN echo -e '\033[36;1m ******* INSTALL PACKAGES ******** \033[0m' && \
  apt-get update && apt-get install -y --no-install-recommends \
  sudo && \
  rm -rf /var/lib/apt/lists/*

RUN echo -e '\033[36;1m ******* ADD USER ******** \033[0m' && \
  useradd -d ${HOME} -m ${USER} && \
  passwd -d ${USER} && \
  adduser ${USER} sudo

RUN echo -e '\033[36;1m ******* SELECT USER ******** \033[0m'
USER ${USER}

RUN echo -e '\033[36;1m ******* SELECT WORKING SPACE ******** \033[0m'
WORKDIR /usr/share/nginx/html

RUN echo -e '\033[36;1m ******* ADD SITE WEB ******** \033[0m'
COPY . /usr/share/nginx/html

RUN echo -e '\033[36;1m ******* OPENING PORTS ******** \033[0m'
EXPOSE ${PORTS}

RUN echo -e '\033[36;1m ******* CONTAINER START COMMAND ******** \033[0m'
CMD sudo nginx -g 'daemon off;' \