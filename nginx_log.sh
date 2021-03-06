
#!/bin/bash

log_dir="/data/logs/tj"
cut_dir="/data/logs/tj/cut"
t=`date +%Y%m%d%H%M`
dir=`date +%Y%m%d`
nginx_id="/var/run/nginx.pid"

cd $log_dir
allfile=`ls -F *.log`

for ff in $allfile
do
file_size=`du -k $log_dir/$ff|awk '{print $1}'`
    if [ "$file_size" -gt 10 ];then
         if [ ! -d "$cut_dir/$dir" ];then
           mkdir "$cut_dir/$dir"
        fi
        mv -n $log_dir/$ff $cut_dir/$ff-$t
    fi
done

kill -USR1 `cat ${nginx_id}`

