### Reboot all machines one by one

```sh
ansible all \
  -b \
  -f 1 \
  -m ansible.builtin.reboot \
  -a 'msg="Rolling reboot initiated by Ansible"'
```
