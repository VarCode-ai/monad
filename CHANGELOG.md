# Changelog

All notable changes to Monad, the family repository, are documented here. From now on each app has its own
changelog: [OVMS Manager](https://github.com/VarCode-ai/ovms-manager/blob/HEAD/CHANGELOG.md),
[Lectern](https://github.com/VarCode-ai/lectern/blob/HEAD/CHANGELOG.md).

The entries up to 1.0.0 cover both apps, which lived in this repository, then named `ai-app-local-openvino`.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the project uses
[semantic versioning](https://semver.org/).

## [Unreleased]

### Monad

- The project is now **Monad**, a family of local AI apps, with its own brand: the ⊙ symbol, the wordmark,
  the colors and a common template for the app icons (`docs/brand/`).
- **OVMS Manager** and **Lectern** moved to their own repositories, with their history:
  [VarCode-ai/ovms-manager](https://github.com/VarCode-ai/ovms-manager) and
  [VarCode-ai/lectern](https://github.com/VarCode-ai/lectern). Each one has its own releases and AppImage.
- This repository keeps the install guide (OVMS Manager first, then Lectern), the documentation shared by
  every app, and the reference copy of the UI kit, copied into the apps with `tools/sync-common.sh`.
- The kit's update checker takes the repository of each app, so every app follows its own releases.

The entries below, up to the move, describe changes to the apps made while they lived here.

### Downloads

- AppImages of both apps: one file each, with Python, Qt and OpenVINO inside, for any x86-64 distribution
  with glibc 2.34 or newer. The Lectern AppImage also runs `lectern-transcribe` (`… transcribe -i <folder>`).
- A *Release binaries* workflow builds them for every tag and attaches them to the GitHub release.

### Fixed

- Lectern: speech was almost never detected on some laptops (an Intel Core Ultra digital microphone with
  Qt 6.12, including the AppImage). The microphone is now recorded through PipeWire's `pw-record`, with Qt as
  the fallback; the log records which way it is recorded and in what format.

### Privacy

- The apps switch off the optional usage statistics of the libraries they run. For Hugging Face downloads
  in Lectern, lectern-transcribe and the Converter they set `HF_HUB_DISABLE_TELEMETRY` and `DO_NOT_TRACK`.
  For OpenVINO's model conversion in the Converter, which otherwise sends anonymous statistics unless you
  opted out, they decline them for that process.

### Documentation

- New README section "Open source and private by design", with every network connection the apps make.

## [1.0.0] — 2026-10-23

First public release.

### Apps

- **OVMS Manager**: a desktop front end for OpenVINO Model Server.
  - Browse the OpenVINO models on Hugging Face and download them.
  - Serve them through an OpenAI-compatible API on the Intel CPU, GPU or NPU.
  - Convert other models with Optimum.
  - Runs the server with Podman or Docker.
- **Lectern**: a lecture notebook with live speech-to-text (Whisper on OpenVINO GenAI).
  - Organized by course, lecture and category, and saved as plain text files.
  - Transcribes already recorded audio and video files.
  - Exports a lecture to Markdown.
- **lectern-transcribe**: batch transcription of a folder from the terminal, with resume, audio cleanup and
  automatic model download.

### Design

- Shared UI kit for the whole ecosystem (`common/ui_kit.py`).
- Light and dark themes that follow the system and switch live.
- Command palette (Ctrl+K) in both apps.
- Bundled Inter and Newsreader fonts.
- Live waveform and local-processing indicator in Lectern.
- RAM fit indicator in OVMS Manager.
- WCAG 2.2 AA contrast in both themes, visible focus rings, and a *Reduce motion* option.

### Platform

- English and Italian interface, following the system language.
- Per-user installers for every major glibc distribution: Debian/Ubuntu, Fedora (also Atomic), Arch and
  openSUSE. They check for missing packages and do not require root.
- Automatic fallback from GPU or NPU to the CPU when an accelerator cannot be used.
- Update notifications based on the GitHub releases: checked at most once a day, and they can be turned off.

[Unreleased]: https://github.com/VarCode-ai/monad/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/VarCode-ai/monad/releases/tag/v1.0.0
