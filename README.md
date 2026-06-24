

### Installation

Clone as .config. So git clone 
`https://github.com/IllusiveAldebaran/.quick_dotfiles .config`

This is meant to replace any `.config/` directory, so delete it or just manually copy the files if there is one already.

I always just use bash. So my config is just to add this to `~/.bashrc`:

```bash
source $HOME/.config/.bash_config
```


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
