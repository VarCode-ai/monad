<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/brand/monad-logo-white.svg">
    <img alt="Monad" src="docs/brand/monad-logo.svg" width="300">
  </picture>
</p>

<p align="center">
  <b>Local AI apps for Intel OpenVINO. Nothing comes in, nothing goes out.</b>
</p>

<p align="center">
  Monad is a family of desktop apps for Linux that run AI models <b>entirely on your own computer</b>,
  on the CPU, the Intel GPU or the NPU.<br>No cloud services, no accounts, no telemetry: your voice, your
  documents and your questions never leave the machine.
</p>

<p align="center">
  <a href="https://github.com/VarCode-ai/monad/actions/workflows/checks.yml"><img alt="Checks" src="https://github.com/VarCode-ai/monad/actions/workflows/checks.yml/badge.svg"></a>
  <a href="LICENSE"><img alt="License: GPL-3.0-or-later" src="https://img.shields.io/badge/license-GPL--3.0--or--later-9a6415?style=flat-square"></a>
  <img alt="Runs on Intel CPU, GPU and NPU" src="https://img.shields.io/badge/runs%20on-CPU%20%C2%B7%20GPU%20%C2%B7%20NPU-1c1b19?style=flat-square">
  <img alt="Private by design: no cloud, no accounts, no telemetry" src="https://img.shields.io/badge/private-no%20cloud%20%C2%B7%20no%20accounts%20%C2%B7%20no%20telemetry-1c1b19?style=flat-square">
</p>

<p align="center">
  <a href="#the-apps">The apps</a> ·
  <a href="#install-in-this-order">Install</a> ·
  <a href="#why-monad">Why Monad</a> ·
  <a href="#open-source-and-private-by-design">Private by design</a> ·
  <a href="#requirements">Requirements</a> ·
  <a href="#troubleshooting">Troubleshooting</a> ·
  <a href="#contributing">Contributing</a>
</p>

<br>

<p align="center">
  <img src="docs/images/lectern-light.png" alt="Lectern recording a lecture: live transcript, waveform and the local GPU indicator" width="49%">
  <img src="docs/images/ovms-manager-explore-dark.png" alt="OVMS Manager: OpenVINO models on Hugging Face, with the RAM fit indicator" width="49%">
</p>

> [!NOTE]
> **Why "Monad"?** For Leibniz, a monad is a self-sufficient unit with *no windows* through which
> anything could come in or go out. Monad apps work the same way: the AI comes to your computer and
> everything it does stays there. The symbol ⊙, a circle around a point, is the ancient sign of the monad,
> and it signs every app of the family.

## The apps

Each app has its own repository, its own releases and its own color, and they all share the same
foundations: OpenVINO, one models folder, one design.

| | App | What it does |
| :---: | --- | --- |
| <img src="docs/brand/apps/ovms-manager.svg" alt="" width="48"> | **[OVMS Manager](https://github.com/VarCode-ai/ovms-manager)**<br><sub>the models hub · install first</sub> | A graphical front end for [OpenVINO Model Server](https://github.com/openvinotoolkit/model_server). Browse the ready-to-use OpenVINO models on Hugging Face, download them, serve them through an OpenAI-compatible API (for example to chat in [Open WebUI](https://github.com/open-webui/open-webui)), and convert other models with Optimum. |
| <img src="docs/brand/apps/lectern.svg" alt="" width="48"> | **[Lectern](https://github.com/VarCode-ai/lectern)**<br><sub>lecture notebook</sub> | A lecture notebook with live speech-to-text. It records from the microphone and transcribes in real time with Whisper, organizing the text by course, lecture and category. It also installs **lectern-transcribe**, which transcribes every audio or video file in a folder. |

More apps, all based on AI and built the same way, will follow.

## Install in this order

Monad apps are installed one by one, each from its own repository. Install them in this order:

### 1. The system packages

Install what the apps need from your distribution (see [System packages](#system-packages-by-distribution)
for the exact command). The installers also check for anything missing and tell you what to run.

### 2. OVMS Manager

[**OVMS Manager**](https://github.com/VarCode-ai/ovms-manager) is the hub of the family: it finds and
downloads the models into `~/models`, the folder every Monad app shares, and serves them to other apps.
Install it first.

```bash
git clone https://github.com/VarCode-ai/ovms-manager.git
./ovms-manager/install.sh
```

Or download `OVMS-Manager-<version>-x86_64.AppImage` from its
[latest release](https://github.com/VarCode-ai/ovms-manager/releases/latest).

### 3. Lectern

[**Lectern**](https://github.com/VarCode-ai/lectern) uses the Whisper models found in `~/models`.

```bash
git clone https://github.com/VarCode-ai/lectern.git
./lectern/install.sh
```

Or download `Lectern-<version>-x86_64.AppImage` from its
[latest release](https://github.com/VarCode-ai/lectern/releases/latest).

Lectern also works on its own: `lectern-transcribe` can download its Whisper model the first time you use
it. Installing OVMS Manager first gives you one place to browse, download and remove every model.

### 4. Your first models

1. Open **OVMS Manager → Explore Hugging Face**.
2. For chat, pick an `INT4` model that fits your memory (for example `Qwen3-8B-int4-ov`) and press
   **Download with OVMS**.
3. For Lectern, choose the *Speech-to-Text* type and download `whisper-large-v3-turbo-int8-ov`.

Then open Lectern: the model is already there.

### Installers and AppImages

Every app offers the same two ways in, and they behave the same everywhere:

- **AppImage**: one file with its own Python, Qt and OpenVINO. It installs nothing, needs no root, and runs
  on any x86-64 distribution with glibc 2.34 or newer. Verify it with the `SHA256SUMS` of the same release.
- **Installer** (`./install.sh` in each repository): works only in your home folder and never asks for
  `sudo`. It creates a private Python environment, adds the app to the application menu and a command to
  `~/.local/bin`. Once done you can delete the clone. `--uninstall` removes the app and keeps your models,
  notes and settings; `--dev` runs the files of the clone; `PYTHON=python3.12` picks another Python.

### Updating

When a new version of an app is published, that app shows a banner with a link to its release notes. To
update, download the new AppImage, or pull the app's repository and run its installer again:

```bash
git -C ovms-manager pull && ./ovms-manager/install.sh
git -C lectern pull && ./lectern/install.sh
```

Your models, notes and settings are kept.

> [!TIP]
> Did you install the apps from this repository when it was called `ai-app-local-openvino`? Clone the two
> app repositories as shown above and run their installers: they update the apps in place, with your
> models, notes and settings.

## Why Monad

Recent Intel processors include an NPU (the *AI Boost* in Core Ultra chips) and a capable integrated GPU,
and OpenVINO can run modern AI models on both. Using them, though, still means working in the terminal:
installing drivers and runtimes, converting models, and writing code against the OpenVINO APIs.

Monad makes the NPU and OpenVINO **easy to use from a graphical interface**: you install an app, pick a
model and an accelerator, and start working. Every app is built on the same architecture:

- **OpenVINO** runs every model locally, on the CPU, the GPU or the NPU.
- **Shared models**: all apps use one models folder (`~/models`), so a model downloaded once is available
  to every app.
- **OVMS Manager** is the common hub to find, download, convert and serve models.
- Every app is a **PySide6 desktop app** with a per-user installer that needs no root access, built on the
  shared UI kit in [`common/`](common/ui_kit.py).

## Open source and private by design

AI assistants usually work by sending your voice, your documents and your questions to someone else's
servers. Monad apps take the opposite approach: **the AI comes to your computer, your data does not go
anywhere.**

### Private by design

- **Everything runs locally.** Lectern transcribes your microphone and files on your CPU, GPU or NPU.
  The models served by OVMS Manager answer from your own machine. Recordings, transcripts, prompts and
  answers never leave your computer.
- **No accounts, no API keys, no subscriptions.** There is nothing to sign up for, and no usage limit
  other than your hardware.
- **No telemetry.** The apps collect no usage statistics, analytics or crash reports. They also switch off
  the optional usage statistics of the libraries they run: Hugging Face downloads
  (`HF_HUB_DISABLE_TELEMETRY`, `DO_NOT_TRACK`) and OpenVINO's model conversion in the Converter.
- **Works offline.** Once the models are downloaded, transcription and inference need no connection at
  all.
- **Your data stays yours.** Notes are plain text files in folders you choose: no database, no
  proprietary format, no lock-in. Uninstalling an app never deletes your notes, models or settings.
- **Recordings are local too.** If you choose to save the audio of a lecture, it is a `.wav` file in the
  lecture folder, nowhere else.

#### Every network connection, listed

The apps connect to the internet only in these cases. Each request reveals your IP address and a software
name, as any HTTP request does; none of them carries your audio, your text or anything that identifies you.

| When | Where | What for | What is sent | Can you avoid it? |
| --- | --- | --- | --- | --- |
| You open *Explore Hugging Face* (OVMS Manager) | huggingface.co | List of OpenVINO models | Your search text, if any | Yes: the catalog is cached for 6 hours and offline the cache is used |
| You download a model | huggingface.co | Model files | The model name | No: it is the download you asked for |
| You start the server or download for the first time | docker.io | The OpenVINO Model Server container image | The image name | No, but only once |
| First recording in Lectern | raw.githubusercontent.com | Silero voice detection model (1.3 MB) | Nothing | Yes: offline, Lectern uses a simpler volume-based detection |
| At most once a day | api.github.com | Is there a newer release of this app? | Nothing | Yes: **Help → Check for updates automatically** in Lectern, the command palette in OVMS Manager |
| You run the Converter | huggingface.co | The original model to convert | The model name | No: it is the conversion you asked for |

Buttons such as *Open on Hugging Face* or *Open WebUI* simply open your web browser.

### Free and open source

- **GPL-3.0-or-later.** You are free to use the apps for any purpose, study how they work, change them and
  share them. Copyleft guarantees that every version based on this code stays free and open as well: these
  apps can never be turned into a closed product.
- **Open from top to bottom.** The apps depend only on open source software: OpenVINO and OpenVINO Model
  Server (Apache 2.0), Qt for Python (LGPL), Silero VAD (MIT), and the Inter and Newsreader fonts (OFL).
  The Whisper models are open-weight (MIT).
- **Verifiable, not just promised.** Every claim on this page can be checked in a few files:
  - [`common/ui_kit.py`](common/ui_kit.py), `UpdateChecker`: the update check, shared by every app;
  - [`ovms_manager.py`](https://github.com/VarCode-ai/ovms-manager/blob/HEAD/ovms_manager.py), `hf_get` and
    `NO_TELEMETRY_ENV`: the catalog and the conversion;
  - [`lectern.py`](https://github.com/VarCode-ai/lectern/blob/HEAD/lectern.py), `SileroVAD`: the voice
    detection download;
  - [`transcribe.py`](https://github.com/VarCode-ai/lectern/blob/HEAD/transcribe.py), `resolve_model`: the
    model download.
- **Built in the open.** Every change runs the public checks in GitHub Actions. Issues, translations and pull
  requests are welcome: see [CONTRIBUTING.md](CONTRIBUTING.md).

## One family, one design

Every Monad app shares the same kit, so they look and behave the same while each keeps its own color:
<img src="https://img.shields.io/badge/-OVMS%20Manager-2552e0?style=flat-square" alt="OVMS Manager: electric blue" align="absmiddle">
<img src="https://img.shields.io/badge/-Lectern-b4471f?style=flat-square" alt="Lectern: ember" align="absmiddle">.
The brand itself (the name, the ⊙ symbol, the colors and the icon template) is described in
[docs/brand](docs/brand/README.md).

- **Light and dark theme** that follow the system and switch live. You can force either one: **Tools →
  Appearance** in Lectern, the theme menu in the sidebar of OVMS Manager.
- **Calm layout**: warm neutral colors, a sidebar that recedes, few borders. Depth is used only for what
  floats, such as Lectern's recorder dock and the command palette.
- **Command palette** (**Ctrl+K**) in every app: every action, every lecture and every local model is one
  search away.
- **Visible provenance**: Lectern shows where the transcription runs (*Local · GPU*, updated if it falls back
  to the CPU), and a live waveform shows when it hears speech. OVMS Manager tells you whether a model fits in
  your RAM before you download it.
- **Typography**: [Inter](https://rsms.me/inter/) for the interface, with tabular figures for clocks and
  tables, and [Newsreader](https://github.com/productiontype/Newsreader) as an optional serif for reading
  transcripts. Both fonts are bundled, so the apps look the same on every distribution.
- **Accessibility**: every text and focus color reaches the WCAG 2.2 AA contrast ratios in both themes
  (checked by `tools/check_contrast.py`), focus rings are visible, and **Reduce motion** turns off the
  animations. It follows GNOME's setting by default.

### Languages

The apps are available in **English** and **Italian**. They follow the language of your system, and you
can choose another one from the app: **Tools → Interface language** in Lectern, the 🌐 menu in the
sidebar of OVMS Manager. The change applies the next time you start the app.

Translations are plain JSON files in each app's `locale/` folder, so adding a language does not need any
tool: see the CONTRIBUTING guide of each app.

## Requirements

- **Linux on x86-64** with glibc: Ubuntu 22.04+, Debian 12+, Fedora 39+, Arch Linux, openSUSE
  Tumbleweed, Linux Mint, Pop!_OS and their derivatives. openSUSE Leap 15.6 works with the `python311`
  package and `PYTHON=python3.11` (its default `python3` is too old). Distributions based on musl
  (Alpine) are not supported, because PySide6 and OpenVINO only publish glibc wheels.
- **Python 3.10 or newer** with the `venv` module (only for the installers: the AppImages carry their own).
- A desktop session (Wayland or X11).
- **OVMS Manager** also needs [Podman](https://podman.io) or [Docker](https://docs.docker.com/engine/install/) to run the model server.
- **Lectern** also needs `ffmpeg` to read files other than `.wav`, and records best with PipeWire's
  `pw-record`.

Optional, for hardware acceleration:

- **Intel GPU** (integrated UHD/Iris Xe graphics or Arc). OVMS Manager needs nothing extra, since the
  container image ships its own GPU driver. Lectern runs Whisper directly on your system, so it needs the
  Intel compute runtime on the host (see the table below).
- **Intel NPU** (Core Ultra processors). Needs the
  [Linux NPU driver](https://github.com/intel/linux-npu-driver) and a recent kernel.

### System packages by distribution

The installers check for missing packages and print the right command for your system. To install
everything up front, use the command for your distribution:

| Distribution | Base packages | Intel GPU runtime (for Lectern) |
| --- | --- | --- |
| Ubuntu, Debian, Mint | `sudo apt install python3 python3-venv ffmpeg podman pipewire-bin libxcb-cursor0` | `sudo apt install intel-opencl-icd` |
| Fedora | `sudo dnf install python3 ffmpeg-free podman pipewire-utils xcb-util-cursor` | `sudo dnf install intel-compute-runtime` |
| Fedora Atomic (Silverblue, Kinoite) | `rpm-ostree install ffmpeg-free xcb-util-cursor` (Python, Podman and PipeWire are preinstalled) | `rpm-ostree install intel-compute-runtime` |
| Arch Linux, Manjaro, EndeavourOS | `sudo pacman -S python ffmpeg podman pipewire xcb-util-cursor` | `sudo pacman -S intel-compute-runtime` |
| openSUSE | `sudo zypper install python3 ffmpeg podman pipewire-tools libxcb-cursor0` | `sudo zypper install intel-opencl` |

You can replace `podman` with Docker if you already use it. `libxcb-cursor` is only needed on X11
sessions, but installing it costs nothing.

## Configuration

These variables are shared by the apps; each app's README lists its own.

| Variable | Default | Used by | Meaning |
| --- | --- | --- | --- |
| `OPENVINO_MODELS_DIR` | `~/models` | every app | Folder holding the OpenVINO models. |
| `OVMS_CONTAINER_RUNTIME` | auto (`podman`, then `docker`) | OVMS Manager | Forces the container runtime. |
| `OVMS_EXTRA_RUN_ARGS` | empty | OVMS Manager | Extra options for every container, e.g. `--group-add keep-groups`. |
| `OPEN_WEBUI_URL` | `http://localhost:3000` | OVMS Manager | Address opened by the *Open WebUI* button. |
| `LECTERN_AUDIO` | `pw-record` when available | Lectern | `qt` records the microphone through Qt instead of PipeWire. |
| `PYTHON` | `python3` | installers | Interpreter used to create the environments. |

The apps follow the XDG base directories: settings go in `~/.config`, caches and logs in `~/.cache`, and
the installed apps in `~/.local/share`.

## Security notes

- The OVMS API has **no authentication**. By default the container publishes port 8000 on every network
  interface, so a containerized Open WebUI can reach it. On untrusted networks, enable **Localhost only**
  on the Server page or block the port with your firewall.
- **Allow custom code** (`--trust-remote-code`) in the Converter runs Python code from the model
  repository on your computer. Enable it only for repositories you trust.
- Models come from their authors on Hugging Face. Prefer the official `OpenVINO/` repositories, which
  OVMS Manager marks with ✓.
- To opt out of OpenVINO's usage statistics for every OpenVINO tool on your system, not only inside these
  apps, run `opt_in_out --opt_out` once.

## This repository

This is the home of the family: the guide you are reading, the brand, and the reference copy of the kit
every app is built on. The apps themselves live in their own repositories.

```
monad/
├── common/                    # the shared UI kit, copied into every app
│   ├── ui_kit.py              # design tokens, themes, icons, command palette, update checker
│   └── fonts/                 # Inter and Newsreader (SIL Open Font License)
├── docs/
│   ├── brand/                 # the Monad logo, symbol, app icons and brand guide
│   ├── images/                # screenshots
│   └── troubleshooting.md     # problems common to every app
├── tools/
│   ├── check_contrast.py      # checks the WCAG contrast of the theme colors
│   └── sync-common.sh         # copies the kit into the app repositories
└── .github/workflows/         # checks on every push
```

## Troubleshooting

[docs/troubleshooting.md](docs/troubleshooting.md) covers the problems common to every app: installation,
Qt failing to start, the NPU. Each app has its own guide too:
[OVMS Manager](https://github.com/VarCode-ai/ovms-manager/blob/HEAD/docs/troubleshooting.md) (containers,
the GPU in Podman) and [Lectern](https://github.com/VarCode-ai/lectern/blob/HEAD/docs/troubleshooting.md)
(the Intel GPU, audio).

## Contributing

Bug reports and pull requests are welcome. Report a problem with an app in that app's repository; the kit,
the brand and the documentation of the family belong here. [CONTRIBUTING.md](CONTRIBUTING.md) explains how
the kit is shared and how to build a new Monad app.

## License

Copyright © 2026 VarCode-ai.

Monad and its apps are free software, released under the [GNU General Public License v3.0 or later](LICENSE).

They build on third-party software that keeps its own license: OpenVINO, OpenVINO GenAI and OpenVINO
Model Server (Apache 2.0), Qt for Python / PySide6 (LGPL v3), Silero VAD (MIT), OpenAI Whisper models
(MIT), the Inter and Newsreader fonts (SIL Open Font License 1.1, see `common/fonts/`), and the models you
download, each covered by the license on its Hugging Face page.

<br>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/brand/monad-mark-white.svg">
    <img src="docs/brand/monad-mark.svg" alt="Monad" width="40">
  </picture>
</p>
