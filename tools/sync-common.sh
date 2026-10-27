#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
# Copy the shared UI kit (common/) of this repository, the reference copy, into Monad app repositories.
#
#   tools/sync-common.sh ../ovms-manager ../lectern
#
# Each app keeps its own copy in <app>/common/, so it installs and builds without this repository.
# Review and commit the result in each app.
set -euo pipefail

ROOT="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/.." && pwd)"
(( $# )) || { sed -n '3,7p' "$0"; exit 1; }

for target in "$@"; do
    target="$(cd "$target" && pwd)"
    # only an app repository: its own installer and an existing kit, never a random folder
    if [[ ! -f "$target/install.sh" || ! -f "$target/common/ui_kit.py" ]]; then
        echo "✗ $target is not a Monad app (no install.sh or common/ui_kit.py): skipped" >&2
        continue
    fi
    rm -rf "$target/common"
    mkdir -p "$target/common"
    (cd "$ROOT/common" && tar --exclude=__pycache__ -cf - .) | (cd "$target/common" && tar -xf -)
    echo "✓ $target/common"
    git -C "$target" status --short -- common 2>/dev/null | sed 's/^/    /'
done
