# Arch Linux UEFI Installation

  - Verify and adjust the "LC_" variables declared inside the scripts
  - Copy the ```aui-src``` folder into the Installation medium, usually the USB
  - Boot into the Live environment and wait for it to load
  - Run ```cp -r /run/archiso/bootmnt/aui-src /root/ && cd aui-src && ls -l```
  - Verify the "LC_" variables match the live environment, E.g. disk partitions
  - Remove the USB and ```reboot```
  - Login into root and run ```aui-root.sh```
  - Exit and login as the new admin user
  - Run ```aui-user.sh```
  - Run any setup you need ```aui-gui-name.sh```

END
