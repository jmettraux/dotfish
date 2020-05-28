
# notes.md

## determining FFS1 or FFS2 on OpenBSD

```sh
yawara$ doas dumpfs / | head -1
magic   19540119 (FFS2) time    Thu May 28 14:59:46 2020

terebi$ doas dumpfs / | head -1
magic   11954 (FFS1)    time    Thu May 28 15:00:33 2020
```

