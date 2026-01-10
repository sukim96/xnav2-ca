#!/bin/zsh

# Get current directory
ROOT_DIR="${0:A:h}"

# Isaac Sim Setup
export ISAACSIM_PATH="${ROOT_DIR}/third_party/IsaacSim/_build/linux-aarch64/release"
export ISAACSIM_PYTHON_EXE="${ISAACSIM_PATH}/python.sh"
export LD_PRELOAD="$LD_PRELOAD:/lib/aarch64-linux-gnu/libgomp.so.1"

# Isaac Lab Setup
alias isaaclab="${ROOT_DIR}/third_party/IsaacLab/isaaclab.sh"
alias python="${ROOT_DIR}/third_party/IsaacLab/isaaclab.sh -p"
alias pip="${ROOT_DIR}/third_party/IsaacLab/isaaclab.sh -p -m uv pip"
