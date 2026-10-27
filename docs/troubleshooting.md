# Troubleshooting

Problems common to every Monad app, grouped by area. Each app has its own guide for the rest:
[OVMS Manager](https://github.com/VarCode-ai/ovms-manager/blob/HEAD/docs/troubleshooting.md) (containers, the
GPU in Podman) and [Lectern](https://github.com/VarCode-ai/lectern/blob/HEAD/docs/troubleshooting.md) (the
Intel GPU, audio).

## Installation

### `Cannot create a Python virtual environment`

Debian, Ubuntu and their derivatives ship the `venv` module in a separate package:

```bash
sudo apt install python3-venv
```

### `pip could not install` / `No matching distribution found for openvino-genai`

OpenVINO and PySide6 publish wheels for specific Python versions. A distribution that has just moved to a
new Python may be ahead of them, and an old one (openSUSE Leap ships Python 3.6 as `python3`) is too far
behind. Install a supported Python next to the system one and point the installer to it:

```bash
sudo zypper install python311        # openSUSE Leap
sudo dnf install python3.12          # Fedora
PYTHON=python3.12 ./install.sh   # in the app's folder
```

The installer recreates the environment when the Python version changes.

### The app is not in the menu, or the command is not found

- Some desktops refresh the menu only after you log out and back in.
- `~/.local/bin` is not on the `PATH` of every distribution (for example Arch). Add it to your shell
  profile:

  ```bash
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.profile
  ```

## Starting the apps

### `Could not load the Qt platform plugin "xcb"`

On X11 sessions Qt 6 needs `libxcb-cursor`:

| Distribution | Command |
| --- | --- |
| Debian, Ubuntu | `sudo apt install libxcb-cursor0` |
| Fedora | `sudo dnf install xcb-util-cursor` |
| Arch | `sudo pacman -S xcb-util-cursor` |
| openSUSE | `sudo zypper install libxcb-cursor0` |

To see which library is missing, start the app from a terminal with `QT_DEBUG_PLUGINS=1 lectern`. On a
Wayland session you can also force the native backend with `QT_QPA_PLATFORM=wayland`.

## Hardware acceleration

For the Intel GPU, see the guide of each app: OVMS Manager runs the driver inside its container, Lectern
needs the Intel compute runtime on your system.

### Intel NPU not detected

The NPU needs the [Linux NPU driver](https://github.com/intel/linux-npu-driver) (packaged as
`intel-npu-driver` in some distributions) and a recent kernel with the `intel_vpu` module (the newer the
processor, the newer the kernel it needs). After installing it, `/dev/accel/accel0` must exist and be accessible to your user (usually
through the `render` group).

Not every model runs on the NPU. For LLMs prefer the `INT4 CW` variants. If Whisper fails on the NPU, use
the GPU or the CPU.

### The GPU is from AMD or NVIDIA

OpenVINO supports Intel GPUs and NPUs only. On other hardware use the CPU mode. OVMS Manager marks
non-Intel devices as *not Intel · unsupported*.

## Getting help

Open the issue in the repository of the app, and include your distribution and version, the output of
the installer, and the relevant log:

- [Lectern](https://github.com/VarCode-ai/lectern/issues): **Help → Open log file** (`~/.cache/lectern/lectern.log`).
- [OVMS Manager](https://github.com/VarCode-ai/ovms-manager/issues): the console at the bottom of the window, and **Container log**.
