/dev/sda:
  blockdev.formatted:
    - fs_type: ext4

/mnt/consul:
  mount.mounted:
    - device: /dev/sda
    - fstype: ext4
    - mkmnt: true
  file.directory:
    - user: consul
    - group: consul
