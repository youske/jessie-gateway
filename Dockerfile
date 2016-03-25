FROM debian:jessie
MAINTAINER youske miyakoshi <youske@gmail.com>

LABEL Role="gateway"

ARG LANGUAGE
ARG SERVICEPORT

ENV PACKAGE="locales bash wget git vim less gawk rsync openssh-server bzip2 nkf" \
    OPTPACKAGE="tig tmux lv ansible" \
    LANGUAGE=${LANGUAGE:-en_US.UTF-8} \
    SERVICEPORT=${SERVICEPORT:-22} \
    SSHKEY=''

# update install
RUN apt-get update && apt-get upgrade && apt-get -y install ${PACKAGE} ${OPTPACKAGE}

# update locales
RUN if [ ${LANGUAGE} = 'ja_JP.UTF-8' ] ; then apt-get install -y locales ;fi && \
    sed -i "s/# \(.*ja_JP\.UTF-8.*\)/\1/g" /etc/locale.gen && \
    locale-gen && update-locale LANG=${LANGUAGE}

CMD ["bash"]
EXPOSE ${SERVICEPORT}
