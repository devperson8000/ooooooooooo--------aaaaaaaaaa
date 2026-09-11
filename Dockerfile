FROM lscr.io/linuxserver/webtop:alpine-mate

LABEL org.opencontainers.image.title="Orbit Cloud Desktop" \
      org.opencontainers.image.description="Low-memory Alpine MATE desktop streamed with Selkies"

COPY --chmod=755 scripts/chromium-low-memory /usr/bin/chromium-browser

ENV TZ=Etc/UTC \
    TITLE="Orbit Linux" \
    PUID=1000 \
    PGID=1000 \
    SELKIES_IS_MANUAL_RESOLUTION_MODE=true \
    SELKIES_MANUAL_WIDTH=1152 \
    SELKIES_MANUAL_HEIGHT=648 \
    SELKIES_FRAMERATE=15 \
    SELKIES_H264_CRF=34 \
    SELKIES_SECOND_SCREEN=false \
    SELKIES_AUDIO_ENABLED=false \
    SELKIES_MICROPHONE_ENABLED=false \
    SELKIES_GAMEPAD_ENABLED=false

EXPOSE 3000
