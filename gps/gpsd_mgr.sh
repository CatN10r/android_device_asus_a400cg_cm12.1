
#set -x

LOGLV=`getprop persist.logtool.gps.loglv`

if [ "$LOGLV" == "2" ] ; then
    rm /data/gps/libgps.conf
    rm /data/gps/gpsconfig.xml
    ln -s /system/bin/gpstest /data/data/GpsTest
    ln -s /system/etc/gpsconfig_debug.xml /data/gps/gpsconfig.xml
    ln -s /system/etc/libgps.conf /data/gps/libgps.conf
fi

if [ "$LOGLV" == "1" ] ; then
    rm /data/gps/libgps.conf
    rm /data/gps/gpsconfig.xml
    ln -s /system/bin/gpstest /data/data/GpsTest
    ln -s /system/etc/gpsconfig_debug.xml /data/gps/gpsconfig.xml
fi

if [ "$LOGLV" == "0" ] ; then
    rm /data/gps/libgps.conf
    rm /data/gps/gpsconfig.xml
    ln -s /system/etc/gpsconfig_user.xml /data/gps/gpsconfig.xml
fi

start gpsd

