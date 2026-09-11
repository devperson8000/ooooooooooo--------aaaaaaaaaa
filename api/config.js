function normaliseUrl(value) {
  if (!value) return "";
  try {
    const url = new URL(value);
    if (url.protocol !== "https:") return "";
    return url.href.replace(/\/$/, "");
  } catch {
    return "";
  }
}

export default function handler(_request, response) {
  response.setHeader("Cache-Control", "no-store");
  response.status(200).json({
    desktopUrl: normaliseUrl(process.env.REMOTE_DESKTOP_URL),
    configured: Boolean(normaliseUrl(process.env.REMOTE_DESKTOP_URL))
  });
}
