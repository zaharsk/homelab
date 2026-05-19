#!/usr/bin/env python3

from collections import defaultdict
import json
import os
from pathlib import Path
import subprocess

env = os.environ.copy()

TF_PATH = Path(f"{env["WORKSPACE_FOLDER"]}/terraform/infra")
SSH_PRIVATE_KEY_PATH = str(
    Path(
        f"{env["WORKSPACE_FOLDER"]}/{env["SECRETS_FOLDER"]}/ssh.ubuntu"
    )
)


raw = subprocess.check_output(
    [
        "terraform",
        "output",
        "-json",
        "inventory",
    ],
    cwd=TF_PATH,
    text=True,
    env=env,
)

data = json.loads(raw)
servers = data["servers"]

inventory = {
    "_meta": {
        "hostvars": {}
    }
}

groups = defaultdict(list)

for hostname, cfg in servers.items():

    inventory["_meta"]["hostvars"][hostname] = {
        "ansible_host": cfg["ip"],
        "ansible_user": cfg["user"],
        "ansible_ssh_private_key_file": SSH_PRIVATE_KEY_PATH,
    }

    for group in cfg["groups"]:
        groups[group].append(hostname)

for group, hosts in groups.items():
    inventory[group] = {
        "hosts": hosts
    }

inventory["all"] = {
    "children": list(groups.keys())
}

print(json.dumps(inventory, indent=2))
