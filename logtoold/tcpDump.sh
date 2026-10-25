DATE=$(timestamp)
STARTSTOP=$1
${STARTSTOP} tcpdump
LOGFILE=/data/pnp/netstat.txt
date "+%F %T" >> $LOGFILE
busybox netstat -p -t -u -w >> $LOGFILE