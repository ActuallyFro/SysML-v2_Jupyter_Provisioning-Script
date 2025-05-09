import json
import os
import subprocess

def get_jupyterlab_app_dir():
    # Call `jupyter lab path` and extract the app_dir
    output = subprocess.check_output(["jupyter", "lab", "path"]).decode()
    for line in output.splitlines():
        if "Application directory:" in line:
            return line.split("Application directory:")[1].strip()
    raise RuntimeError("Could not determine JupyterLab application directory.")

if __name__ == '__main__':
    app_dir = get_jupyterlab_app_dir()
    override_file = os.path.join(app_dir, 'settings', 'overrides.json')
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
