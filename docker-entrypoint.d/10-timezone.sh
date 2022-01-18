[ -w /etc/timezone ] || return
[ -w /etc/localtime ] || return
[ -z "$TZ" ] && return

echo "$TZ" > /etc/timezone
ln -svf /usr/share/zoneinfo/$TZ /etc/localtime