# Contributing to Monad

Thanks for helping! Monad is a family: this repository holds what the apps share (the guide, the brand
and the UI kit), and each app lives in its own repository.

| You want to… | Go to |
| --- | --- |
| Report a bug or propose a feature in an app | That app's repository: [OVMS Manager](https://github.com/VarCode-ai/ovms-manager/issues), [Lectern](https://github.com/VarCode-ai/lectern/issues) |
| Translate an app | The `CONTRIBUTING.md` of that app (*Translations*) |
| Change the shared kit, the brand or the family documentation | This repository |
| Build a new Monad app | [Building a new Monad app](#building-a-new-monad-app), below |

## The shared kit

Every app is built on [common/ui_kit.py](common/ui_kit.py) and the fonts in `common/fonts/`: design tokens,
light and dark themes, icons, the command palette, the update checker. Each app keeps **its own copy** in
its `common/` folder, so every repository installs and builds on its own, without submodules.

The copy in this repository is the reference:

1. Change the kit here, and run `python tools/check_contrast.py` if you touched a color.
2. Copy it into the app repositories, cloned next to this one:

   ```bash
   tools/sync-common.sh ../ovms-manager ../lectern
   ```

3. In each app, run its checks and try the app, then commit the kit together with any change the app needs.

Never change the kit only inside an app: the next sync would undo it.

## Building a new Monad app

A Monad app is a PySide6 desktop app that runs its AI models locally with OpenVINO. Start from an existing
app, which already has the layout every app shares:

```
<app>/
├── <app>.py               # the app, a single file that runs without being installed
├── <app>.svg              # its icon, from the template in docs/brand
├── install.sh             # per-user installer, no root
├── requirements.txt
├── locale/it.json         # translations
├── common/                # copy of the kit (tools/sync-common.sh)
├── packaging/             # AppImage build
├── tools/                 # translation and contrast checks
└── .github/workflows/     # checks on every push, AppImage on every tag
```

Then use the kit, so the new app looks and behaves like the others:

```python
import ui_kit as kit
C = kit.T                                    # colors of the current theme
kit.load_fonts(app)                          # Inter for the interface, Newsreader for reading
theme = kit.ThemeManager(app, "ember", "system", lambda t: kit.base_qss(t) + my_qss(t))
button = kit.IconButton("download", tr("Download"), "primary", slot)
palette = kit.CommandPalette(window, provider, tr("Type a command…"), tr("No results"))
updates = kit.UpdateChecker(window, APP_VERSION, get, put, "VarCode-ai/<app>")
```

- Give the app **its own accent**: add it to `ACCENTS` in the kit and check it with
  `python tools/check_contrast.py`. The [brand guide](docs/brand/README.md) lists the accents in use.
- Draw with the theme tokens (`C["text"]`, `C["accent_soft"]`…), never with fixed colors. Painted
  widgets read them at paint time; anything else connects to `kit.signals.changed` (or uses
  `kit.Themed`) so it follows live theme switches.
- Use `kit.icon()` instead of emoji, which some distributions cannot display.
- Read and write models in `~/models` (`$OPENVINO_MODELS_DIR`), so they are shared with every other app.
- Follow the privacy rules of the family: no telemetry, no accounts, and every network connection listed
  in the [README](README.md#every-network-connection-listed).
- Draw the icon from the template in the [brand guide](docs/brand/README.md#app-icons), write the README
  with the Monad header (copy it from an existing app), and add the app to [The apps](README.md#the-apps)
  and to [Install in this order](README.md#install-in-this-order) here.

## Code style

- Python 3.10+, standard library plus the packages in the `requirements.txt` files.
- Follow the style of the surrounding code: 120-character lines, short comments that explain *why*.
- User-visible text is written in English and wrapped in `tr()`.
- Shell scripts use `bash` with `set -euo pipefail`, must work on every distribution listed in the
  README, and must not require root.

## Checks before a pull request

```bash
pip install pyflakes shellcheck-py PySide6-Essentials
python -m pyflakes common/*.py tools/*.py
shellcheck tools/*.sh
python tools/check_contrast.py
```

## License

By contributing you agree that your contributions are licensed under the
[GNU GPL v3.0 or later](LICENSE), the license of the project.
