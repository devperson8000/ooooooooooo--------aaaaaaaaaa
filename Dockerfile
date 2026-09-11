FROM lscr.io/linuxserver/webtop:ubuntu-mate

LABEL org.opencontainers.image.title="Orbit Cloud Desktop" \
      org.opencontainers.image.description="Low-resource remote Ubuntu MATE desktop streamed with Selkies"

ENV TZ=Etc/UTC \
    TITLE="Orbit Linux" \
    PUID=1000 \
    PGID=1000 \
    SELKIES_IS_MANUAL_RESOLUTION_MODE=true \
    SELKIES_MANUAL_WIDTH=1280 \
    SELKIES_MANUAL_HEIGHT=720 \
    SELKIES_FRAMERATE=24 \
    SELKIES_H264_CRF=32 \
    SELKIES_SECOND_SCREEN=false \
    SELKIES_AUDIO_ENABLED=false \
    SELKIES_MICROPHONE_ENABLED=false \
    SELKIES_GAMEPAD_ENABLED=false

EXPOSE 3000
