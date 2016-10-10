/dev/sda:
  blockdev.formatted:
    - fs_type: ext4

/mnt/persist:
  mount.mounted:
    - device: /dev/sda
    - fstype: ext4
    - mkmnt: true

/mnt/persist/consul:
  file.directory:
    - user: consul
    - group: consul
