

### MPD

Files in .config/mpd/mpd.conf

Starts automatically using init system (runit)
Here's the service file:

```
#!/bin/sh
exec 2>&1
[ -r conf ] && . ./conf
install -d -m 0755 -o mpd -g mpd /run/mpd
#exec mpd --no-daemon ${OPTS:-}
exec mpd --no-daemon /home/lowell/.config/mpd/mpd.conf ${OPTS:-} 2>&1
```
