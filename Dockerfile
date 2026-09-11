FROM lscr.io/linuxserver/webtop:ubuntu-xfce

LABEL org.opencontainers.image.title="Orbit Cloud Desktop" \
      org.opencontainers.image.description="Remote Ubuntu XFCE desktop streamed with Selkies"

ENV TZ=Etc/UTC \
    TITLE="Orbit Linux" \
    PUID=1000 \
    PGID=1000

EXPOSE 3000
