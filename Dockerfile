FROM node:22-alpine AS dependencies
WORKDIR /app
RUN apk add --no-cache python3 make g++
COPY package.json ./
RUN npm install --omit=dev

FROM node:22-alpine
RUN apk add --no-cache bash coreutils curl git nano openssh-client python3 \
    && addgroup -S terminal \
    && adduser -S -G terminal -h /workspace -s /bin/bash terminal \
    && mkdir -p /workspace \
    && chown -R terminal:terminal /workspace
WORKDIR /app
COPY --from=dependencies /app/node_modules ./node_modules
COPY --chown=terminal:terminal . .
USER terminal
ENV NODE_ENV=production
ENV PORT=3000
EXPOSE 3000
CMD ["node", "server/index.js"]
