#!/usr/bin/env bash

set -e
cd $(dirname ${BASH_SOURCE[0]})/..

# Install GCC/G++ 11 & git lfs
echo "[INFO] Install GCC/G++ 11 & Git LFS..."
sudo apt update && sudo apt install -y gcc-11 g++-11 git-lfs

echo "[INFO] Updating alternatives of gcc/g++ as gcc/g++-11..."
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 200
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 200

# Build IsaacSim
echo "[INFO] Building IsaacSim..."
pushd third_party/IsaacSim
./build.sh
popd

# Create symbolic link to IsaacSim
export ISAACSIM_PATH="${PWD}/third_party/IsaacSim/_build/linux-$(uname -m)/release"
echo "ISAACSIM_PATH=$ISAACSIM_PATH"

pushd third_party/IsaacLab
echo "[INFO] Creating symbolic link to IsaacSim in IsaacLab..."
ln -sfn "${ISAACSIM_PATH}" _isaac_sim
ls -l _isaac_sim/python.sh

# Install IsaacLab
echo "[INFO] Installing IsaacLab..."
./isaaclab.sh --install
popd

# Install this repository
echo "[INFO] Installing this repository..."
ISAACLAB_PATH="${PWD}/third_party/IsaacLab/isaaclab.sh"
pushd source/xnav2_ca
$ISAACLAB_PATH -p -m pip install -e .
popd

# Generate vscode settings
exec utils/generate_vscode_config.sh
