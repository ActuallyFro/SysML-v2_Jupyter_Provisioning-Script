#!/bin/bash
#
# SysML 2 Pilot Implementation
# Copyright (C) 2020 California Institute of Technology ("Caltech")
# Copyright (C) 2021 Twingineer LLC
# Copyright (C) 2021 Model Driven Solutions, Inc.
# Copyright (C) 2025 ActuallyFro (+Step 0, some deltas from pilot implementation script)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
# @license LGPL-3.0-or-later <http://spdx.org/licenses/LGPL-3.0-or-later>
#

# Original script here: https://github.com/Systems-Modeling/SysML-v2-Release/blob/master/install/jupyter/install.sh

set -e

ENV_NAME="sysml-env"
SYSML_VERSION="0.48.0"
MINICONDA_VERSION="Miniconda3-latest-Linux-x86_64.sh"

if command -v conda &> /dev/null; then
    echo "Conda is already installed, skipping Step 0"
else
    echo "--- Step 0: Installing Miniconda ---"

    wget https://repo.anaconda.com/miniconda/$MINICONDA_VERSION
    chmod +x $MINICONDA_VERSION
    ./$MINICONDA_VERSION

    echo 'export PATH="$HOME/miniconda3/bin/:$PATH"' >> ~/.bashrc
    source ~/.bashrc
fi

echo "--- Step 1: Creating Conda environment '$ENV_NAME' ---"
conda create -n "$ENV_NAME" python=3.9 -y

echo "--- Step 2: Activating environment and installing packages ---"
eval "$(conda shell.bash hook)"
conda activate "$ENV_NAME"

echo "--- Step 3: Installing JupyterLab 3.x, ipykernel, SysML kernel ---"
conda install jupyterlab=3.* nodejs=16 ipykernel -c conda-forge -y
conda install jupyter-sysml-kernel="$SYSML_VERSION" -c conda-forge -y

echo "--- Step 4: Registering Python kernel ---"
python -m ipykernel install --sys-prefix

echo "--- Step 5: Customizing JupyterLab settings (line numbers + folding) ---"
python3 <<EOF
import json, os
from jupyterlab.labapp import get_app_dir

override_file = os.path.join(get_app_dir(), 'settings', 'overrides.json')
settings = {
    '@jupyterlab/notebook-extension:tracker': {
        'codeCellConfig': {
            'lineNumbers': True,
            'codeFolding': True
        }
    }
}
os.makedirs(os.path.dirname(override_file), exist_ok=True)
with open(override_file, 'w+') as f:
    json.dump(settings, f, indent=2)
print(f"✅ Settings written to: {override_file}")
EOF

echo "--- ✅ Installation complete! ---"
echo "Activate with: conda activate $ENV_NAME"
echo "Then run: jupyter lab"
echo "📌 Note: No UI extension for SysML is installed; use the 'SysML' kernel in the Launcher to run .sysml cells."

