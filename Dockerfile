FROM lscr.io/linuxserver/webtop:ubuntu-mate

LABEL org.opencontainers.image.title="Orbit Cloud Desktop" \
      org.opencontainers.image.description="Low-memory Ubuntu MATE desktop streamed with Selkies"

COPY --chmod=755 scripts/chromium-low-memory /usr/local/bin/orbit-browser-wrapper
RUN set -eu; \
    browser_path=""; \
    for candidate in /usr/bin/chromium-browser /usr/bin/chromium /usr/bin/google-chrome /usr/bin/google-chrome-stable; do \
      if [ -e "$candidate" ] || [ -L "$candidate" ]; then browser_path="$candidate"; break; fi; \
    done; \
    if [ -n "$browser_path" ]; then \
      mv "$browser_path" "$browser_path.real"; \
      printf '%s\n' "$browser_path.real" > /usr/local/share/orbit-browser-real; \
      ln -s /usr/local/bin/orbit-browser-wrapper "$browser_path"; \
      echo "Installed low-memory wrapper for $browser_path"; \
    else \
      echo "No Chromium-compatible browser found; keeping the image default browser"; \
    fi

ENV TZ=Etc/UTC \
    TITLE="Orbit Linux" \
    PUID=1000 \
    PGID=1000 \
    MALLOC_ARENA_MAX=2 \
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
