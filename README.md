# Browser Linux VM

A polished, browser-accessible Alpine Linux virtual machine powered by the [v86](https://github.com/copy/v86) x86 emulator.

## What it is

Vercel cannot host a traditional always-running VM. This project instead boots a real Alpine Linux x86 guest inside each visitor's browser. The Vercel deployment is only the static host; CPU, memory, and VM state stay on the visitor's device.

## Deploy on Vercel

1. Import this GitHub repository into Vercel.
2. Keep **Framework Preset** set to **Other**.
3. Leave build and output settings empty.
4. Deploy.

No environment variables are required.

## Controls

- **Start / Pause** controls CPU execution.
- **Restart** performs a VM reboot.
- **Save** stores a snapshot in the browser.
- **Restore** loads that saved snapshot.
- **Fullscreen** expands the VM display.
- Click inside the display before typing.

The first boot downloads the emulator, BIOS, and Alpine image, so it can take a moment. Saved snapshots are local to the current browser and device.

## Limitations

- VM data is not automatically persistent between browsers or devices.
- Public deployments let anyone with the domain start their own isolated VM.
- Network availability inside the guest depends on browser and v86 networking support.
- This is suited to learning, demos, and temporary shell sessions—not production hosting.
