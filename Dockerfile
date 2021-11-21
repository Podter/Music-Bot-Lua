# Ubuntu Focal
FROM ubuntu:focal

# Copy things
WORKDIR /data
COPY ./ /data

# Install Luvit and Other things
RUN ln -snf /usr/share/zoneinfo/Asia/Bangkok /etc/localtime && echo Asia/Bangkok > /etc/timezone
RUN apt-get update -y
RUN apt-get install ffmpeg youtube-dl libopus-dev libsodium-dev curl -y
RUN curl -L https://github.com/luvit/lit/raw/master/get-lit.sh | sh && mv luvi lit luvit /usr/local/bin

# Install lit packages
RUN lit install

# ENV Things
ENV Prefix=!
ENV Token=1234567890
RUN rm settings.lua
RUN mv settings.lua.docker settings.lua

# Start app
CMD [ "luvit", "main.lua" ]
