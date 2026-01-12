#!/usr/bin/env bash

set -e
cd $(dirname ${BASH_SOURCE[0]})/..

echo "[INFO] Generating VSCode settings from IsaacLab..."
mkdir -p .vscode
cp third_party/IsaacLab/.vscode/settings.json .vscode/settings.json
# Adjust IsaacSim-related packages
sed -i \
    "s|\${workspaceFolder}/_isaac_sim|\${workspaceFolder}/third_party/IsaacSim/_build/linux-$(uname -m)/release|g" \
    .vscode/settings.json

# Adjust IsaacLab-related packages
sed -i \
    "s|\${workspaceFolder}/source/|\${workspaceFolder}/third_party/IsaacLab/source/|g" \
    .vscode/settings.json

# Adjust itself
sed -z -i 's|"[[:space:]]*\n[[:space:]]*]\n}|",\n        \"${workspaceFolder}/source/xnav2_ca\"\n    ]\n}|g' \
    .vscode/settings.json
