### Add ubuntu user

```bash
sudo useradd -m -s /bin/bash -G sudo,docker ubuntu && \
sudo mkdir -p /home/ubuntu/.ssh && \
echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPf1eBQZohkDZK6yT0k4MOOa56AT3zNsEOLMrpGlrFuy ubuntu@homelab' | sudo tee /home/ubuntu/.ssh/authorized_keys >/dev/null && \
sudo chown -R ubuntu:ubuntu /home/ubuntu/.ssh && \
sudo chmod 700 /home/ubuntu/.ssh && \
sudo chmod 600 /home/ubuntu/.ssh/authorized_keys && \
echo 'ubuntu ALL=(ALL:ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/ubuntu >/dev/null && \
sudo chmod 440 /etc/sudoers.d/ubuntu
```

### Reboot all machines one by one

```bash
ansible \
  all \
  -b \
  -f 2 \
  -m ansible.builtin.reboot \
  -a 'msg="Rolling reboot initiated by Ansible"'
```

### Custom command

```bash
ansible \
  all \
  -b -m shell \
  -a "rm /etc/apt/apt.conf.d/20auto-upgrades /etc/apt/apt.conf.d/50-unattended-upgrades"
```
