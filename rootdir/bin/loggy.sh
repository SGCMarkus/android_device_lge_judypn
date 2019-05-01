#!/vendor/bin/sh
# loggy.sh.

date=`date +%F_%H-%M-%S`
mkdir /data/ramoops/
/system/bin/logcat > /data/ramoops/los16_logcat_${date}.txt
