const elements = {
  hero: document.querySelector("#hero"),
  viewer: document.querySelector("#viewer"),
  frame: document.querySelector("#desktopFrame"),
  frameWrap: document.querySelector("#frameWrap"),
  statusPill: document.querySelector("#statusPill"),
  statusText: document.querySelector("#statusText"),
  hostLabel: document.querySelector("#hostLabel"),
  settingsDialog: document.querySelector("#settingsDialog"),
  settingsForm: document.querySelector("#settingsForm"),
  hostInput: document.querySelector("#hostInput"),
  inputError: document.querySelector("#inputError")
};

const STORAGE_KEY = "orbit.remoteDesktopUrl";
let desktopUrl = "";

function validHttpsUrl(value) {
  try {
    const url = new URL(value);
    return url.protocol === "https:" ? url.href.replace(/\/$/, "") : "";
  } catch {
    return "";
  }
}

function setStatus(state, label) {
  elements.statusPill.className = `status-pill ${state}`;
  elements.statusText.textContent = label;
}

async function loadConfiguration() {
  const locallySaved = validHttpsUrl(localStorage.getItem(STORAGE_KEY) || "");
  try {
    const response = await fetch("/api/config", { cache: "no-store" });
    const config = await response.json();
    desktopUrl = locallySaved || validHttpsUrl(config.desktopUrl);
  } catch {
    desktopUrl = locallySaved;
  }
  setStatus(desktopUrl ? "ready" : "error", desktopUrl ? "Host configured" : "Setup required");
}

function openSettings() {
  elements.hostInput.value = desktopUrl;
  elements.inputError.textContent = "";
  elements.settingsDialog.showModal();
  requestAnimationFrame(() => elements.hostInput.focus());
}

function requireHost() {
  if (desktopUrl) return true;
  openSettings();
  return false;
}

function connect() {
  if (!requireHost()) return;
  elements.frameWrap.classList.remove("loaded");
  elements.hostLabel.textContent = new URL(desktopUrl).host;
  elements.frame.src = desktopUrl;
  elements.hero.hidden = true;
  elements.viewer.classList.add("visible");
  elements.viewer.setAttribute("aria-hidden", "false");
}

function disconnect() {
  elements.frame.src = "about:blank";
  elements.viewer.classList.remove("visible");
  elements.viewer.setAttribute("aria-hidden", "true");
  elements.hero.hidden = false;
}

document.querySelector("#connectButton").addEventListener("click", connect);
document.querySelector("#newTabButton").addEventListener("click", () => {
  if (requireHost()) window.open(desktopUrl, "_blank", "noopener,noreferrer");
});
document.querySelector("#settingsButton").addEventListener("click", openSettings);
document.querySelector("#closeButton").addEventListener("click", disconnect);
document.querySelector("#reloadButton").addEventListener("click", () => {
  elements.frameWrap.classList.remove("loaded");
  elements.frame.src = desktopUrl;
});
document.querySelector("#fullscreenButton").addEventListener("click", () => {
  if (elements.viewer.requestFullscreen) elements.viewer.requestFullscreen();
});
elements.frame.addEventListener("load", () => {
  if (elements.frame.src !== "about:blank") elements.frameWrap.classList.add("loaded");
});
elements.settingsForm.addEventListener("submit", (event) => {
  if (event.submitter?.value === "cancel") return;
  event.preventDefault();
  const nextUrl = validHttpsUrl(elements.hostInput.value.trim());
  if (!nextUrl) {
    elements.inputError.textContent = "Enter a valid URL beginning with https://";
    return;
  }
  desktopUrl = nextUrl;
  localStorage.setItem(STORAGE_KEY, desktopUrl);
  setStatus("ready", "Host configured");
  elements.settingsDialog.close();
});

loadConfiguration();
