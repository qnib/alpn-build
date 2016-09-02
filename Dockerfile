FROM qnib/alpn-base

RUN apk add --update alpine-sdk
RUN adduser -D abuilder \
 && addgroup abuilder abuild \
 && sed -i'' -e 's/#PACKAGER=.*/PACKAGER="Christian Kniep <christian@qnib.org>"/' /etc/abuild.conf \
 && mkdir -p /var/cache/distfiles \
 && chgrp abuild /var/cache/distfiles \
 && chmod g+w /var/cache/distfiles

USER abuilder
RUN abuild-keygen -a -i
USER root
RUN echo "su - abuilder" >> /root/.bash_history
