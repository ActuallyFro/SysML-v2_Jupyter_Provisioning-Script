#!/bin/bash

echo "0) IF FIRST RUN!"
echo "CondaError: Run 'conda init' before 'conda activate'"
echo ""
echo "1) ENSURE you are running in the RIGHT ENV! Run: \$ \`conda activate sysml-env\`"
echo ""
echo "2) ENSURE sysml kernel is installed! Run:\$ \`jupyter kernelspec list\`"
echo ""
echo "    Lookfor:"
echo "    [ListKernelSpecs] WARNING | Native kernel (python3) is not available"
echo "    [ListKernelSpecs] WARNING | Native kernel (python3) is not available"
echo "    Available kernels:"
echo "      sysml    /home/jupyter/anaconda3/envs/sysml-env/share/jupyter/kernels/sysml"
echo ""
echo "Look at specific file: \`\$ cat \"\$(jupyter kernelspec list --json | jq -r '.kernelspecs.sysml.resource_dir')/kernel.json\"\`"
echo ""
echo "    Else -- run: conda install \"jupyter-sysml-kernel=0.50.0\" -c conda-forge -y"
echo ""
echo "3) To activate this environment, use"
echo ""
echo "     $ jupyter lab --ip \"\$(ip -o -4 addr show | awk '!/127.0.0.1/ {print \$4}' | cut -d/ -f1 | head -n 1)\" --port 8888"
echo ""
echo "4) To deactivate an active environment, use"
echo ""
echo "     $ conda deactivate"
