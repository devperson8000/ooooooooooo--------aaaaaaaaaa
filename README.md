# Orbit Cloud Linux

A polished browser portal for a **remotely hosted Ubuntu MATE desktop**. The frontend deploys to Vercel; Linux and every desktop application run inside a separate Docker host.

## Architecture

- **Vercel:** static portal and a tiny configuration endpoint.
- **Remote Docker host:** Ubuntu MATE via LinuxServer Webtop/Selkies.
- **Browser:** receives the desktop stream and sends keyboard, mouse, audio, and controller input.

This is not a VM running inside Vercel or inside the visitor's browser.

## 1. Deploy the Linux desktop

Create a service on a Docker-capable host from this repository. Railway can use the included the root `Dockerfile` automatically.

Set these environment variables on the remote service:

```text
CUSTOM_USER=choose-a-username
PASSWORD=choose-a-long-random-password
TZ=Australia/Sydney
```

Attach persistent storage at `/config`, allocate at least 2 GB RAM, and expose internal port `3000` through the host's HTTPS domain. For smoother desktop use, 4 GB RAM or more is recommended. GPU-backed gaming requires a host that supports GPU passthrough; ordinary cloud containers are intended only for lightweight games.

## 2. Deploy the portal to Vercel

Import this repository into Vercel and add:

```text
REMOTE_DESKTOP_URL=https://your-remote-desktop-host.example.com
```

Redeploy after saving the variable. The portal can also accept a host URL from its settings panel and stores that address in the current browser.

## Security

Do not expose the remote desktop without authentication. `CUSTOM_USER` and `PASSWORD` enable the image's built-in login, but an Internet-facing production desktop should also sit behind strong access control supplied by the hosting platform or a trusted identity-aware reverse proxy. Never commit credentials to this repository.

## Gaming

Selkies supports browser audio, microphone, and up to four gamepads. Lightweight games can use CPU rendering. Modern 3D games need a GPU-enabled Linux host, compatible drivers, GPU passthrough, and enough network bandwidth; Vercel does not provide that compute.

## Local validation (optional)

Nothing needs to run locally for deployment. Maintainers who want to validate the files can run `npm install && npm run check`; the Linux desktop itself still belongs on the remote Docker service.
