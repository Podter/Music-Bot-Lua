# Ubuntu Focal
FROM ubuntu:focal

# Copy things
WORKDIR /data
COPY ./ /data

# Install Luvit and Other things
RUN curl -L https://github.com/luvit/lit/raw/master/get-lit.sh | sh && mv luvi lit luvit /usr/local/bin
RUN apt-get install ffmpeg youtube-dl libopus-dev libsodium-dev

# Install lit packages
RUN lit install

# ENV Things
ENV Prefix=!
ENV Token=1234567890
RUN rm settings.lua
RUN mv settings.lua.docker settings.lua

# Start app
CMD [ "luvit", "main.lua" ]
