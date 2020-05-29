
# notes.md


## determining FFS1 or FFS2 on OpenBSD

```sh
yawara$ doas dumpfs / | head -1
magic   19540119 (FFS2) time    Thu May 28 14:59:46 2020

terebi$ doas dumpfs / | head -1
magic   11954 (FFS1)    time    Thu May 28 15:00:33 2020
```


## /root/tarsnap-backup.sh

Something that goes like:

```sh
#!/bin/sh

META=/var/_meta

mkdir -p $META
  #
pkg_info > $META/pkg_info_list.txt
dmesg > $META/dmesg.txt

/usr/local/bin/tarsnap \
  -c -f "$(uname -n)-$(uname -r)-$(date +%Y%m%d_%H%M%S)" \
  --exclude .cache \
  --exclude .bundle \
  --exclude .rubies \
  /etc \
  /home \
  /var/www \
  /var/postgresql \
  $META
```

with

```
# /var/cron/tabs/root

# ...

0 13,19 * * * /root/tarsnap-backup.sh
```

