echo [program:storm-$1] | tee -a /etc/supervisor/conf.d/storm-$1.conf
echo command=storm $1 | tee -a /etc/supervisor/conf.d/storm-$1.conf
echo directory=/home/storm | tee -a /etc/supervisor/conf.d/storm-$1.conf
echo autostart=true | tee -a /etc/supervisor/conf.d/storm-$1.conf
echo autorestart=true | tee -a /etc/supervisor/conf.d/storm-$1.conf
echo startsecs=15 | tee -a /etc/supervisor/conf.d/storm-$1.conf
echo user=root | tee -a /etc/supervisor/conf.d/storm-$1.conf
echo redirect_stderr=true | tee -a /etc/supervisor/conf.d/storm-$1.conf
echo stdout_logfile=/dev/stdout | tee -a /etc/supervisor/conf.d/storm-$1.conf
echo stdout_logfile_maxbytes=0 | tee -a /etc/supervisor/conf.d/storm-$1.conf
