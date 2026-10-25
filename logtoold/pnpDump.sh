DATE=$(timestamp)
LOGINDEX=$1
STARTEND=$2
LOGFILE=/data/pnp/${LOGINDEX}_${STARTEND}.log

if [ "$STARTEND" == "End" ]; then
	cat /sys/module/bcmdhd/parameters/op_mode >> $LOGFILE
elif [ "$STARTEND" == "Start" ]; then
	cat /sys/module/bcmdhd/parameters/op_mode > $LOGFILE
else
	echo "" > $LOGFILE
fi

dumpsys batterystats >> $LOGFILE
cat /proc/net/xt_qtaguid/stats >> $LOGFILE
dumpsys power | busybox sed '/Wake Locks:/,/Suspend Blockers:/p' -n | busybox sed '$d' >> $LOGFILE

