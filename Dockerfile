FROM debian:jessie

ARG LANGUAGE
ARG PORT

ENV PACKAGE="bash wget git tig tmux vim less lv gawk rsync openssh-server bzip2 locales nkf ansible" \
    LANGUAGE=${LANGUAGE:-en_US.UTF-8} \
    PORT=${PORT:-22} \
    SSHKEY=''

RUN apt-get update && apt-get upgrade && apt-get -y install ${PACKAGE}

RUN if [ ${LANGUAGE} = 'ja_JP.UTF-8' ] ; then apt-get install -y locales ;fi && \ 
    sed -i "s/# \(.*ja_JP\.UTF-8.*\)/\1/g" /etc/locale.gen && \
    locale-gen && update-locale LANG=${LANGUAGE}

CMD ["bash"]
EXPOSE ${PORT}
